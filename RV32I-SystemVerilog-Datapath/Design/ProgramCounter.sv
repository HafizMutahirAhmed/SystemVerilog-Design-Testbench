`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 01:00:03 PM
// Design Name: 
// Module Name: ProgramCounter
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

module ProgramCounter(input logic CLK, Reset, JumpReg, Jump, Branch, ONE,
                      input logic [31:0] ImmediateOutput, ReadData1,
                      output logic [31:0] PC);
    always_ff @(posedge CLK or posedge Reset) begin
        if (Reset) begin
            PC = 32'b0;
        end
        else begin
            PC = ((JumpReg)? ReadData1: PC)  +  ( (Jump||(Branch && ONE))? ImmediateOutput: 32'd4); 
        end
    end
endmodule
