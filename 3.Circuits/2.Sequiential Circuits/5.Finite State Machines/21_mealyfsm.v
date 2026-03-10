module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z
);

    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;

    reg [1:0] state, next;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next;
    end

    always @(*) begin
        case (state)
            S0: next = x ? S1 : S0;
            S1: next = x ? S1 : S2;
            S2: next = x ? S1 : S0;
            default: next = S0;
        endcase
    end

    assign z = (state == S2 && x == 1);

endmodule