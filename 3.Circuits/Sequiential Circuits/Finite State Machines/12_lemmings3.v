module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    reg [1:0] state, next_state;
    reg [1:0] prev_state;

    parameter LEFT  = 2'b00,
              RIGHT = 2'b01,
              AIR   = 2'b10,
              DIG   = 2'b11;

    // Next state logic
    always @(*) begin
        case(state)

            LEFT: begin
                if (!ground)                   
                    next_state = AIR;
                else if (dig)                 
                    next_state = DIG;
                else if (bump_left)           
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = AIR;
                else if (dig)
                    next_state = DIG;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            AIR: begin
                if (ground)
                    next_state = prev_state;   
                else
                    next_state = AIR;
            end

            DIG: begin
                if (!ground)                  
                    next_state = AIR;
                else
                    next_state = DIG;
            end

            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            prev_state <= LEFT;
        end
        else begin
            if (state == LEFT || state == RIGHT)
                prev_state <= state;   
            state <= next_state;
        end
    end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == AIR);
    assign digging    = (state == DIG);

endmodule
