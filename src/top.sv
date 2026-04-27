`include "src/clk_div.sv"
`include "src/led.sv"

module top (
    /** Input Ports */
    input logic clk,
    input logic btn,

    /** Output Ports */
    output logic led_r,
    output logic led_g,
    output logic led_b
);

/** Logic */
logic led_speed;
logic led_on;

clk_div clk_div (
    .clk_in(clk),
    .clk_led(led_speed)
);

led led (
    .clk(led_speed),
    .btn_press(~btn),
    .duty_counter(led_on)
);

assign led_r    = 1'b1;
assign led_g    = 1'b1;
assign led_b    = ~led_on;

endmodule