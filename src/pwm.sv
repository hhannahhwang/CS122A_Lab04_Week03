
module pwm(
    input logic clk,
    input logic [3:0] duty_counter,
    output logic led_out
);

logic [3:0] pwm_count = 4'd0;

always_ff @(posedge clk) begin
    if(pwm_count >= 4'd9) begin
        pwm_count <= 4'd0;
    end else begin
        pwm_count <= pwm_count + 1'b1;
    end
end

assign led_out = ~(pwm_count < duty_counter);

endmodule