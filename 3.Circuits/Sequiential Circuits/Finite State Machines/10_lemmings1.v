module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg state, next_state;

    parameter LEFT  = 1'b0,
              RIGHT = 1'b1;

    // Next state logic
    always @(*) begin
        case(state)
            LEFT:  next_state = bump_left  ? RIGHT : LEFT;
            RIGHT: next_state = bump_right ? LEFT  : RIGHT;
        endcase
    end

    // State register with async reset
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic (Moore)
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
