`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 07:32:31 AM
// Design Name: 
// Module Name: FourBitParallelAdderTestBench
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



module FourBitParallelAdderTestBench;
    logic [3:0] a, b; logic cin; //inputs
    logic [3:0] sum; logic cout; //outputs
    
    FourBitParallelAdder DUT(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
    
    initial begin
        a = 4'b1010; b = 4'b0101; cin = 1'b0; #10;
        a = 4'b1010; b = 4'b0100; cin = 1'b1; #10;
        a = 4'hA; b = 4'hA; cin = 1'b0; #10;
        a = 4'hF; b = 4'hF; cin = 1'b0; #10;
        a = 4'hF; b = 4'hF; cin = 1'b1; #10;
    end
    
endmodule

