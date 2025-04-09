`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 01:10:39 PM
// Design Name: 
// Module Name: Register8BitTestBench
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


module Register8BitTestBench;
     logic clk, reset;
     logic [7:0] register;
     logic [7:0] out;
     
     Register8Bits DUT (.clk(clk), .reset(reset), .register(register), .out(out));
     
     always begin
        #10 clk = ~clk;
     end
     
     initial begin   
         clk= 0; 
         reset = 1; register = 8'hAE; #10;
         reset = 0; register = 8'h77; #10;
        
//         $finish; 
      end
      initial begin
        $dumpfile("Register8BitTestBench.vcd");
        $dumpvars(0,Register8BitTestBench);
      end
     
endmodule
