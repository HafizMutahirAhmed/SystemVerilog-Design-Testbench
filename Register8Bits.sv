`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 12:14:41 PM
// Design Name: 
// Module Name: Register8Bits
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


module Register8Bits(
    input logic clk,
    input logic reset,
    
    input logic [7:0] register,
    output logic [7:0] out
    
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 8'b0;
        else
            out <=  register;
    end
    
        
endmodule
