module top_module(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 

    reg [2:0] state, next_state;
    reg [6:0] timeair;

    parameter LEFT     = 3'd0,
              RIGHT    = 3'd1,
              AIR_L    = 3'd2,
              AIR_R    = 3'd3,
              DIG_L    = 3'd4,
              DIG_R    = 3'd5,
              SPATTER  = 3'd6;

    // Next state logic
    always @(*) begin
        next_state = state;

        case(state)

            LEFT: begin
                if(!ground)
                    next_state = AIR_L;
                else if(dig)
                    next_state = DIG_L;
                else if(bump_left)
                    next_state = RIGHT;
            end

            RIGHT: begin
                if(!ground)
                    next_state = AIR_R;
                else if(dig)
                    next_state = DIG_R;
                else if(bump_right)
                    next_state = LEFT;
            end

            AIR_L: begin
                if(ground) begin
                    if(timeair > 7'd19)
                        next_state = SPATTER;
                    else
                        next_state = LEFT;
                end
                else
                    next_state = AIR_L;
            end

            AIR_R: begin
                if(ground) begin
                    if(timeair > 7'd19)
                        next_state = SPATTER;
                    else
                        next_state = RIGHT;
                end
                else
                    next_state = AIR_R;
            end

            DIG_L: begin
                if(!ground)
                    next_state = AIR_L;
            end

            DIG_R: begin
                if(!ground)
                    next_state = AIR_R;
            end

            SPATTER: begin
                next_state = SPATTER;
            end

        endcase
    end

    // State + counter register
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            timeair <= 7'd0;
        end
        else begin
            state <= next_state;

            if(state == AIR_L || state == AIR_R)
                timeair <= timeair + 1;
            else
                timeair <= 7'd0;
        end
    end

    // Outputs
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == AIR_L || state == AIR_R);
    assign digging    = (state == DIG_L || state == DIG_R);

endmodule
