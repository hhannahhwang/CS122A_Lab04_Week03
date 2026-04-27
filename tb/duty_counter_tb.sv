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