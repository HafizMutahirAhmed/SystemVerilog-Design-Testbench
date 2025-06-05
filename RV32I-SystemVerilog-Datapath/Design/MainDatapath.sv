`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2025 12:55:20 PM
// Design Name: 
// Module Name: MainDatapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import RISCV_PKG::*;

module MainDatapath(input logic CLK, Reset,
                    Tracer rvfi);
    logic [63:0] instruction_counter = 0;
                
    logic [OPCODE_SIZE-1:0] Opcode;
    logic [2:0] Func3 = 0, ALUOp = 0;
    logic [6:0] Func7 = 0;
    logic [4:0] RS1 = 0, RS2 = 0, RD = 0;
    logic [INSTRUCTION_SIZE - 1:0]  ImmediateOutput = 0, ALUResult = 0, ReadData1 = 0, ReadData2 = 0, ReadInstruction = 0, ReadData=0;
    logic [31:0] PC = 32'h0;
    logic [3:0] ALUOperation = 0;
    logic JumpReg = 0, Jump = 0, Branch = 0, RegSrc1 = 0, RegSrc2 = 0, UpperImm = 0, RegWrite = 0, MemWrite = 0, MemToReg = 0, RetAddr = 0, ONE = 0;
    
    always_comb begin    
        Func3 = ReadInstruction[14:12];
        Opcode = ReadInstruction[OPCODE_SIZE-1:0];
        Func7 = ReadInstruction[31:25];
        RS1 = ReadInstruction[19:15];
        RS2 = ReadInstruction[24:20];
        RD = ReadInstruction[11:7];
    end
    ProgramCounter ProgCount (
            .CLK(CLK),
            .Reset(Reset),
            .JumpReg(JumpReg),
            .Jump(Jump),
            .Branch(Branch),
            .ONE(ONE),
            .ImmediateOutput(ImmediateOutput),
            .ReadData1(ReadData1),
            .PC(PC)
        );
    
    ControlUnit CU(
        .Opcode(Opcode),
        .ALUOp(ALUOp),
        .JumpReg(JumpReg),
        .Jump(Jump),
        .Branch(Branch),
        .RegSrc1(RegSrc1),
        .RegSrc2(RegSrc2),
        .UpperImm(UpperImm),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .RetAddr(RetAddr));
        
  
         
     ALUControl ALUCU(.ALUOp(ALUOp),
                .func3(Func3),
                .func7(Func7),
                .ALUOperation(ALUOperation));
                 
     ImmediateGenerator IG(.Instruction(ReadInstruction),
                        .ImmediateOutput(ImmediateOutput));
                   
     RegisterFile RF(.CLK(CLK), 
                  .Reset(Reset), 
                  .RegWrite(RegWrite), 
                  .ReadReg1(RS1), 
                  .ReadReg2(RS2),
                  .WriteAddress(RD),
                  .WriteData((MemToReg)? ReadData : ALUResult),
                  .ReadData1(ReadData1),
                  .ReadData2(ReadData2));
                  
     ALU ALU(.dataA((UpperImm)?  32'b0 : ((RegSrc1)? ReadData1: PC)),
                           .dataB((RetAddr)?  32'd4 : ((RegSrc2)? ReadData2: ImmediateOutput)),
                           .ALUOperation(ALUOperation),
                           .ALUOutput(ALUResult),
                           .ONE(ONE));
     MainMemory MM(.CLK(CLK),
                .Reset(Reset),
                .MemWrite(MemWrite),
                .Funct3(Func3),
                .InstructionAddress(PC),
                .DataAddress(ALUResult),
                .WriteData(ReadData2),
                .ReadInstruction(ReadInstruction),
                .ReadData(ReadData));

    always_ff @(posedge CLK or posedge Reset) begin
        if (Reset)
            instruction_counter <= 0;
        else
            instruction_counter <= instruction_counter + 1;
    end

    logic illegal_instruction;
    logic [3:0] mask_bits;
    logic [3:0] final_mask_bits;
    
    always_comb begin
        case (Opcode)
            7'b0110011, // R-type
            7'b0010011, // I-type
            7'b0000011, // Loads
            7'b0100011, // Stores
            7'b1100011, // Branches
            7'b1101111, // JAL
            7'b1100111, // JALR
            7'b0110111, // LUI
            7'b0010111: // AUIPC
                illegal_instruction = 1'b0;
            default:
                illegal_instruction = 1'b1;
        endcase
        rvfi.trap  = illegal_instruction;
        rvfi.valid = ~illegal_instruction && (Reset == 0);
    
        case (Func3)
            3'b000: mask_bits = 4'b0001; // Byte
            3'b001: mask_bits = 4'b0011; // Half-word
            3'b010: mask_bits = 4'b1111; // Word
            default: mask_bits = 4'b0000;
        endcase
        
        final_mask_bits = mask_bits << ALUResult[1:0];

        rvfi.mem_wmask = MemWrite ? final_mask_bits : 4'b0000;
    

        if (~MemWrite && MemToReg) 
            rvfi.mem_rmask = final_mask_bits;  // Use final_mask_bits only for load operations
        else 
            rvfi.mem_rmask = 4'b0000;  // For store operations, set to 0000 (no read mask)
    
        rvfi.order     = instruction_counter;
        rvfi.insn      = ReadInstruction;
    
        rvfi.rs1_addr  = RS1;
        rvfi.rs2_addr  = RS2;
        rvfi.rs1_rdata = ReadData1;                     // Data from RS1 before execution
        rvfi.rs2_rdata = ReadData2;                     // Data from RS2 before execution
    
        rvfi.rd_addr   = RD;
        rvfi.rd_wdata  = (MemToReg) ? ReadData : ALUResult;  // Data written to RD after execution
    
        // Program Counter Read/Write
        rvfi.pc_rdata  = PC;                           // PC before instruction execution
        rvfi.pc_wdata  = PC + 4;                       // PC after instruction execution
    
        // Memory Access
        rvfi.mem_addr  = ALUResult;                     // Memory access address (ALU result)
        rvfi.mem_wdata = ReadData2;                     // Memory write data
        rvfi.mem_rdata = ReadData;                      // Memory read data
 

        // Memory Write/Read Masks
        rvfi.mem_wmask = MemWrite ? final_mask_bits : 4'b0000;  // Write mask for memory
        rvfi.mem_rmask = (MemWrite) ? 4'b0000 : final_mask_bits; // Read mask for memory during load operations

    end
endmodule
