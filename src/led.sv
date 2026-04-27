module led (
    input logic clk,
    input logic btn_press,
    output logic out
);

typedef enum logic [3:0]{START, ON, OFF} state_t;

state_t state = START;

always_ff @(posedge clk) begin
    case (state)
        START: state <= OFF;
        OFF: state <= state_t' (btn_press ? ON : OFF);
        ON: state <= state_t' (btn_press ? OFF : ON); 
        default: state <= START;
    endcase
end

always_comb begin
    case (state)
        START:   out = 0;
        OFF:     out = 0;
        ON:      out = 1;
        default: out = 0;
    endcase
end




endmodule