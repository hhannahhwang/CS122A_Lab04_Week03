module clk_div (
    input logic clk_in,
    output logic clk_led
);

    logic [24:0] counter = 0;
    logic slow_clk = 0;

    always_ff @(posedge clk_in) begin
        counter <= counter + 1;
    end

    assign clk_led = counter[5];       // for simulation gtk
    //assign clk_led = counter[20];    // for synthesis iCESugar

endmodule