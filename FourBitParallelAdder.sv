`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 06:35:30 AM
// Design Name: 
// Module Name: FourBitParallelAdder
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

module FullAdder( input logic a, b, cin,
                  output logic sum, cout);
                  
    always_comb begin
        sum = a ^ b ^ cin;
        cout = (a & b) | ((a ^ b) & cin);
    end
    
endmodule

module FourBitParallelAdder(input logic [3:0] a,b, 
                            input logic cin,
                            output logic [3:0] sum, cout);
      wire c1,c2,c3;
      FullAdder FA0 (.a(a[0]),.b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
      FullAdder FA1 (.a(a[1]),.b(b[1]), .cin(c1), .sum(sum[1]), .cout(c2));
      FullAdder FA2 (.a(a[2]),.b(b[2]), .cin(c2), .sum(sum[2]), .cout(c3));
      FullAdder FA3 (.a(a[3]),.b(b[3]), .cin(c3), .sum(sum[3]), .cout(cout));
      
endmodule
