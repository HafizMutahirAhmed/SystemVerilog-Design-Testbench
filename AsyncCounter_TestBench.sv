`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 08:25:53 AM
// Design Name: 
// Module Name: AsyncCounterTestBench
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


module AsyncCounterTestBench;
    logic clk, reset;//inputs
    logic [3:0] Q;//output
    AsynchronousUpCounter4Bit DUT(.clk(clk), .reset(reset), .Q(Q));
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  
    end
    
    initial begin
        reset = 1; #10;
        reset = 0;   
        
    end
endmodule
