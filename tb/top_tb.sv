// `include "src/top.sv"
// `timescale 1ns/1ps         // Set tick to 1ns. Set sim resolution to 1ps.

// /**
//  * Note:
//  *  The TB below is only an example of a testbench written in SV.
//  *  Adapt this for your lab assignments as you see fit.
//  *  An example clk signal has been added to show what a signal decl and usage looks like.
//  *     You are welcome to delete the clk signal if it's not needed.
//  *     For instance, purely combinational circuits do not need clks.
//  *     So for labs without sequential elements, you can remove them.
//  */

// module top_tb;

// /** declare tb signals below */
// logic clk_tb = 0;
// logic btn_tb;
// logic led_r, led_g, led_b;

// /** declare module(s) below */
// top dut                    // declare an inst of top called "dut" (device under test)
// (
//     /** hook up tb signals to dut signals */
//     .clk(clk_tb),           // connect dut's clk wire to clk_tb
//     .btn(btn_tb),
//     .led_r(led_r_tb),
//     .led_g(led_g_tb),
//     .led_b(led_b_tb)
// );

// localparam CLK_PERIOD = 84;/** clk period */;
// always #(CLK_PERIOD/2) clk_tb=~clk_tb;          // toggle clk_tb every #(CLK_PERIOD/2) ticks

// initial begin
//     $dumpfile("build/top.vcd"); // intermediate file for waveform generation
//     $dumpvars(0, top_tb);       // capture all signals under top_tb
// end

// initial begin
//     /** testbench logic goes below */
//     btn_tb = 1;
//     #1000;

//     $display("Pressing button...");
//     btn_tb = 0;

//     #5000;

//     $display("Releasing button...");
//     btn_tb = 1;
    
//     #1000;
//     $display("Simulation Finished");
//     $finish;            // end simulation, otherwise it runs indefinitely
// end

// endmodule

`include "src/duty_counter.sv"
`timescale 1ns/1ps         // Set tick to 1ns. Set sim resolution to 1ps.

module duty_counter_tb;

logic clk;
logic btn_press;
logic [3:0] duty_val;

duty_counter dut(
    .clk(clk),
    .btn_press(btn_press),
    .duty_counter(duty_val)
);

localparam CLK_PERIOD = 84;
initial clk = 0;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("build/duty_counter.vcd"); // intermediate file for waveform generation
    $dumpvars(0, duty_counter_tb);       // capture all signals under top_tb
end

initial begin
    btn_press = 0;
    #(CLK_PERIOD *10);

    for (int i = 0; i < 12; i++) begin
        btn_press = 1;
        #(CLK_PERIOD * 20);
        btn_press = 0;
        #(CLK_PERIOD * 40);
    end

    #(CLK_PERIOD * 100);

    $display("Finished Simulation");
    $finish;

end

endmodule
