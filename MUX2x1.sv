`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:21:39 AM
// Design Name: 
// Module Name: 2x1MUX Design
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


module MUX2x1(

    input logic i0,
    input logic i1,
    input logic select,
    output logic out
);
    
    always_comb begin
    
        if (select) 
            out = i1;
        else 
            out = i0;  
             
    end
    
endmodule
