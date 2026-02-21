module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    reg [1:0] state, next_state ;
    reg [1:0] prev_state ;

    parameter LEFT  = 2'b00,
              RIGHT = 2'b01,
              AIR   = 2'b10;

    // Next state logic
    always @(*) begin
        case(state)
            LEFT: begin 
                if(ground)
                    next_state = bump_left ? RIGHT : LEFT;
                else
                    next_state = AIR;
            end

            RIGHT: begin
                if(ground)
                    next_state = bump_right ? LEFT : RIGHT;
                else
                    next_state = AIR;
            end

            AIR: begin
                if(ground)
                    next_state = prev_state;
                else
                    next_state = AIR;
            end

            default: next_state = LEFT;
        endcase
    end

    // State register with async reset
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            prev_state <= LEFT;
        end
        else begin
            if(state != AIR)
                prev_state <= state;
                state <= next_state;
        end
    end

    // Output logic
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == AIR);

endmodule
