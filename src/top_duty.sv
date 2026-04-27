`include "src/clk_div.sv"
`include "src/duty_counter.sv"
`include "src/decoder.sv"
`include "src/pwm.sv"

module top_duty (
    /** Input Ports */
    input logic clk,
    input logic btn,    // LED1
    input logic btn2,   // LED2
    input logic sw,    // DIP Switch

    /** Output Ports */
    output logic [6:0] seg7,
    output logic dp,    //decimal point
    output logic led_r,
    output logic led_g, // LED2
    output logic led_b  // LED1
);

logic clk_speed;
logic [3:0] count_out;  //LED1
logic [3:0] count_out2; //LED2
logic pwm_signal;       //LED1
logic pwn_signal2;      //LED2

logic [3:0] display_val;

clk_div clk_div (
    .clk_in(clk),
    .clk_led(clk_speed)
);

/** 1 LED Logic */
// duty_counter duty_counter (
//     .clk(clk_speed),
//     .btn_press(~btn),
//     .duty_counter(count_out)
// );

// pwm led_pwm (
//     .clk(clk),
//     .duty_counter(count_out),
//     .led_out(pwm_signal)
// );

/** 2 LED Logic */
duty_counter counter1 (
    .clk(clk_speed),
    .btn_press(~btn),
    .duty_counter(count_out)
);

pwm led_pwm1 (
    .clk(clk),
    .duty_counter(count_out),
    .led_out(pwm_signal)
);

duty_counter counter2 (
    .clk(clk_speed),
    .btn_press(~btn2),                                 
    .duty_counter(count_out2)
);

pwm led_pwm2 (
    .clk(clk),
    .duty_counter(count_out2),
    .led_out(pwm_signal2)
);

assign display_val = (sw) ? count_out : count_out2;

assign dp = ~sw;

decoder decoder (
    .bcd(display_val),
    .seg7(seg7)
);

assign led_r    = 1'b1;
assign led_g    = pwm_signal2;
assign led_b    = pwm_signal;

endmodule