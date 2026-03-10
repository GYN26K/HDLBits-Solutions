module top_module(
    input clk,
    input in,
    input reset,    // synchronous reset
    output done
);

    reg [1:0] state, next;
    reg [2:0] count;
    reg done_reg;

    parameter IDLE = 2'd0,
              DATA = 2'd1,
              STOP = 2'd2,
              WAIT = 2'd3;

    assign done = done_reg;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next;
    end

    always @(posedge clk) begin
        if (reset)
            count <= 3'd0;
        else if (state == DATA)
            count <= count + 1;
        else
            count <= 3'd0;
    end

    always @(*) begin
        case (state)

            IDLE: begin
                if (in == 1'b0)
                    next = DATA;
                else
                    next = IDLE;
            end

            DATA: begin
                if (count == 3'd7)
                    next = STOP;
                else
                    next = DATA;
            end

            STOP: begin
                if (in == 1'b1)
                    next = IDLE;
                else
                    next = WAIT;
            end

            WAIT: begin
                if (in == 1'b1)
                    next = IDLE;
                else
                    next = WAIT;
            end

            default: next = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            done_reg <= 0;
        else
            done_reg <= (state == STOP && in == 1'b1);
    end

endmodule