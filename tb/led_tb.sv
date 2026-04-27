`include "src/top.sv"
`timescale 1ns/1ps         // Set tick to 1ns. Set sim resolution to 1ps.

/**
 * Note:
 *  The TB below is only an example of a testbench written in SV.
 *  Adapt this for your lab assignments as you see fit.
 *  An example clk signal has been added to show what a signal decl and usage looks like.
 *     You are welcome to delete the clk signal if it's not needed.
 *     For instance, purely combinational circuits do not need clks.
 *     So for labs without sequential elements, you can remove them.
 */

module led_tb;

/** declare tb signals below */
logic clk_tb;
logic btn_tb;
logic led_r, led_g, led_b;

/** declare module(s) below */
top dut                    // declare an inst of top called "dut" (device under test)
(
    /** hook up tb signals to dut signals */
    .clk(clk_tb),           // connect dut's clk wire to clk_tb
    .btn(btn_tb),
    .led_r(led_r),
    .led_g(led_g),
    .led_b(led_b)
);


localparam CLK_PERIOD = 84; /** clk period */
initial clk_tb = 0 ;
always #(CLK_PERIOD/2) clk_tb=~clk_tb;          // toggle clk_tb every #(CLK_PERIOD/2) ticks

initial begin
    $dumpfile("build/top.vcd"); // intermediate file for waveform generation
    $dumpvars(0, led_tb);       // capture all signals under top_tb
end

initial begin
    /** testbench logic goes below */

    $display("Starting LED_SM Testbench...");
    $display("---------------");

    btn_tb = 1;
    #(CLK_PERIOD * 100);

    // Case 1 : Press Button
    $display("Pressing button...");
    btn_tb = 0;
    #(CLK_PERIOD * 100);
    btn_tb = 1;

    #(CLK_PERIOD * 200);

    // Case 2 : Press button again 
    $display("Pressing button again...");
    btn_tb = 0;
    #(CLK_PERIOD * 100);
    btn_tb = 1;

    #(CLK_PERIOD * 100);

    $display("---------------");
    $display("Simulation Finished");
    $finish;            // end simulation, otherwise it runs indefinitely
end

endmodule
