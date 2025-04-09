`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 08:16:21 AM
// Design Name: 
// Module Name: FibonacciTestBench
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


module FibonacciTestBench;
    logic clk, reset;
    int n;
    logic [31:0] out;
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end
    
    FibonacciSeries DUT (.clk(clk), .reset(reset), .n(n), .out(out));
    
    initial begin
        reset = 1; #10;
        reset = 0; n = 88; #10;          
    end
    
endmodule
