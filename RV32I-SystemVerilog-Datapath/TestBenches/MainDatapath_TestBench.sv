`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 08:29:07 AM
// Design Name: 
// Module Name: MainDatapath_TestBench
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

module MainDatapath_TestBench;

    logic clk = 0;
    logic reset = 0;

    // Create an instance of the tracer interface
    Tracer tracer_if(clk);

    // Instantiate the DUT
    MainDatapath uut (
        .CLK(clk),
        .Reset(reset),
        .rvfi(tracer_if)
    );

    // Clock generation
    always #5 clk = ~clk;

    // File handler
    integer trace_file;

    // Write tracer output to file on every positive clock edge
    always_ff @(posedge clk) begin
        if (tracer_if.valid) begin
            $fwrite(trace_file, 
            "PC_R: %h | PC_W: %h | Instr: %h | rs1: x%0d=%h | rs2: x%0d=%h | rd: x%0d=%h | valid: %0b | order: %0d | mem_addr: %h | mem_rdata: %h | mem_wdata: %h | mem_rmask: %b | mem_wmask: %b\n", 
            tracer_if.pc_rdata, 
            tracer_if.pc_wdata,
            tracer_if.insn, 
            tracer_if.rs1_addr, 
            tracer_if.rs1_rdata,
            tracer_if.rs2_addr, 
            tracer_if.rs2_rdata, 
            tracer_if.rd_addr, 
            tracer_if.rd_wdata,
            tracer_if.valid,
            tracer_if.order,
            tracer_if.mem_addr,
            tracer_if.mem_rdata,
            tracer_if.mem_wdata,
            tracer_if.mem_rmask,
            tracer_if.mem_wmask
        );

        end
    end
    
    initial begin
        trace_file = $fopen("tracer_output.txt", "w");
        if (!trace_file) begin
            $display("ERROR: Unable to open file.");
            $finish;
        end

        #1000;

        $fclose(trace_file);
        $display("Trace log written to tracer_output.txt");

        $finish;
    end

endmodule
