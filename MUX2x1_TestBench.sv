`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:32:04 AM
// Design Name: 
// Module Name: MUX2x1TestBench
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


module MUX2x1TestBench;
    logic i0, i1, select; //inputs
    logic out; //outputs
    
    MUX2x1 DUT
    (.i0(i0),.i1(i1),.select(select),.out(out)
    );

    initial begin
        i0 = 0; i1 = 1; select = 0; #10;
        i0 = 0; i1 = 1; select = 1; #10;
        i0 = 1; i1 = 0; select = 0; #10;
        i0 = 1; i1 = 0; select = 1; #10;
     
     //   $finish;
     
    end    
    
    initial begin
            $dumpfile("MUX2x1TestBench.vcd");
            $dumpvars(0,MUX2x1TestBench);
    end
    
endmodule
