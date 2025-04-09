`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 08:17:33 AM
// Design Name: 
// Module Name: AsynchronousUpCounter4Bit
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

module T_FFP(input logic clk, T, reset,
             output logic Q);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            if (T)
                Q <= ~Q;
            else
                Q <= Q;   
    end
endmodule

module AsynchronousUpCounter4Bit (
    input logic clk, 
    input logic reset, 
    output logic [3:0] Q
);

    logic internal_reset;

    T_FFP TA (.clk(clk),     .T(1'b1), .reset(internal_reset), .Q(Q[0]));
    T_FFP TB (.clk(~Q[0]),    .T(1'b1), .reset(internal_reset), .Q(Q[1]));
    T_FFP TC (.clk(~Q[1]),    .T(1'b1), .reset(internal_reset), .Q(Q[2]));
    T_FFP TD (.clk(~Q[2]),    .T(1'b1), .reset(internal_reset), .Q(Q[3]));
    always @(posedge clk or posedge reset) begin
        if (reset | (Q == 4'd9))
        
            internal_reset <= 1;
        else
            internal_reset <= 0;
    end

endmodule



