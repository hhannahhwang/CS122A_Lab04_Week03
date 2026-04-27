module duty_counter(
    input logic clk,
    input logic btn_press,
    output logic [3:0] duty_counter
);

 logic [3:0] count = 4'd0;
 logic btn_prev = 0;

 always_ff @(posedge clk) begin
    btn_prev <= btn_press;

    if (btn_press && !btn_prev) begin
        if (count >= 4'd9) begin
            count <= 4'd0;
        end else begin
            count <= count + 1;
        end
    end
 end

 assign duty_counter = count;

endmodule