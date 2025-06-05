`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 11:34:17 AM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(input logic [2:0] ALUOp,
                  input logic [2:0] func3,
                  input logic [6:0] func7,
                  output logic [3:0] ALUOperation);
    always_comb begin
        casex({ALUOp,func3, func7[5]})
            7'b000110x, 7'b101110x: ALUOperation = 4'b0000;
            7'b000111x, 7'b101111x: ALUOperation = 4'b0001;
            7'b1010000, 7'b000000x, 7'b110xxxx, 7'b001xxxx, 7'b111xxxx, 7'b010xxxx: ALUOperation = 4'b0010;
            7'b1010001: ALUOperation = 4'b0011;
            7'b011101x: ALUOperation = 4'b0100;
            7'b011100x, 7'b101010x, 7'b000010x: ALUOperation = 4'b0101;
            7'b011000x: ALUOperation = 4'b0110;
            7'b011001x: ALUOperation = 4'b0111; 
            7'b101001x, 7'b000001x: ALUOperation = 4'b1000;
            7'b101100x, 7'b000100x: ALUOperation = 4'b1001;
            7'b1011010, 7'b0001010: ALUOperation = 4'b1010;
            7'b1011011, 7'b0001011: ALUOperation = 4'b1011;
            7'b011111x: ALUOperation = 4'b1100;
            7'b101011x, 7'b000011x, 7'b011110x: ALUOperation = 4'b1101;
            default: ALUOperation = 4'b1111;
        endcase
    end
endmodule
