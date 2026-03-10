module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

    reg state;
    reg next;

    localparam one  = 0;
    localparam zero = 1;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= one;
        else
            state <= next;
    end

    always @(*) begin 
        case(state)
            one: begin
                if (x == 1'b1)
                    next = zero;
                else
                    next = one;
            end

            zero: next = zero;

            default: next = zero;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else
            z <= (state == one) ? x : ~x;
    end

endmodule

