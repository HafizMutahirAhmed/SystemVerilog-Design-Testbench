`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 09:13:34 AM
// Design Name: 
// Module Name: MainMemory
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

module MainMemory(input logic CLK, Reset, MemWrite,
                  input logic [2:0] Funct3,
                  input logic [INSTRUCTION_SIZE-1:0] InstructionAddress, DataAddress, WriteData,
                  output logic [INSTRUCTION_SIZE-1:0] ReadInstruction, ReadData);           
    logic [7:0] Memory[MEM_SIZE-1:0];

    //Writing into Main Memory
    logic [5:0] count = 0;
    initial begin
        $readmemh("/home/mahmed/RISC-V-SCDP/RISC-V-SCDP.srcs/sources_1/new/Instructions.mem", Memory);
    end

    

    always_ff @(posedge CLK or posedge Reset) begin
        
        if (Reset) begin
            for (int i = 0; i < MEM_SIZE; i++) begin 
                Memory[i] <= 8'b0;
            end
        end
        else begin
//            if (InstructionAddress+3 < HALF_MEM) begin
//                //Storing Instruction into the Main Memory
//                Memory[InstructionAddress+0] <= WriteInstruction[7:0];
//                Memory[InstructionAddress+1] <= WriteInstruction[15:8];
//                Memory[InstructionAddress+2] <= WriteInstruction[23:16];
//                Memory[InstructionAddress+3] <= WriteInstruction[31:24]; 
//            end  
               
            //Storing Data into the Main Memory  
            if (MemWrite & (DataAddress+3 < HALF_MEM)) begin   
                case(Funct3)   
                    3'b010: begin //sw
                        Memory[DataAddress + HALF_MEM + 0] <= WriteData[7:0];
                        Memory[DataAddress + HALF_MEM + 1] <= WriteData[15:8];
                        Memory[DataAddress + HALF_MEM + 2] <= WriteData[23:16];
                        Memory[DataAddress + HALF_MEM + 3] <= WriteData[31:24];
                    end
                    3'b001: begin //sh
                        Memory[DataAddress + HALF_MEM + 0] <= WriteData[7:0];
                        Memory[DataAddress + HALF_MEM + 1] <= WriteData[15:8];
                    end
                    3'b000:  begin //sb
                        Memory[DataAddress + HALF_MEM + 0] <= WriteData[7:0];
                    end
                endcase
            end
        end    
    end
    
    //Reading From Main Memory
    always_comb begin
        //Loading Data from Main Memory to Register File
        if (DataAddress+3 < HALF_MEM) begin 
            case(Funct3)
                3'b010: begin //lw
                    ReadData = {Memory[DataAddress + HALF_MEM + 3], Memory[DataAddress + HALF_MEM + 2], Memory[DataAddress + HALF_MEM + 1], Memory[DataAddress + HALF_MEM + 0]};
                end
                3'b001: begin //lh
                    ReadData = {{16{Memory[DataAddress + HALF_MEM + 1][7]}}, Memory[DataAddress + HALF_MEM + 1], Memory[DataAddress + HALF_MEM + 0]};
                end
                3'b000: begin //lb
                    ReadData = {{24{Memory[DataAddress + HALF_MEM + 0][7]}}, Memory[DataAddress + HALF_MEM + 0]};
                end
                3'b101: begin //lhu
                    ReadData = {16'b0, Memory[DataAddress + HALF_MEM + 1], Memory[DataAddress + HALF_MEM + 0]};
                end     
                3'b100: begin //lbu
                    ReadData = {24'b0, Memory[DataAddress + HALF_MEM + 0]};
                end
            endcase
        end
        //Loading Instruction from Main Memory
        ReadInstruction = {Memory[InstructionAddress + 3], Memory[InstructionAddress + 2], Memory[InstructionAddress + 1], Memory[InstructionAddress + 0]};
        

    end    
      
endmodule
