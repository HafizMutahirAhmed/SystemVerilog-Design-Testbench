`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 07:40:52 AM
// Design Name: 
// Module Name: FibonacciSeries
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


module FibonacciSeries(input logic clk, reset, 
                       input int n, 
                       output logic [31:0] out);

    logic [31:0] a, b, result, count;
    always @(posedge clk or posedge reset) begin
        if (reset | (count==n-1)) begin
            count <=0;
            a <= 0;
            b <= 1;
            out <= 0;
        end
        
        else begin 
            result = a+b;
            out <= result;  
            a <= b;
            b <= result;   
            count <= count +1;
        end            
     end
    
endmodule