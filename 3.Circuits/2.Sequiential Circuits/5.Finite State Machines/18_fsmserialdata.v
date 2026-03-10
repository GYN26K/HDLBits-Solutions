module top_module(
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [1:0] state, next;
    reg [2:0] count;
    reg [7:0] data;
    reg done_reg;

    parameter IDLE = 2'd0,
              DATA = 2'd1,
              STOP = 2'd2,
              WAIT = 2'd3;

    assign done = done_reg;
    assign out_byte = data;

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

    always @(posedge clk) begin
        if (reset)
            data <= 8'd0;
        else if (state == DATA)
            data <= {in, data[7:1]};
    end

    always @(*) begin
        case (state)

            IDLE:
                next = (in == 0) ? DATA : IDLE;

            DATA:
                next = (count == 3'd7) ? STOP : DATA;

            STOP:
                next = (in == 1) ? IDLE : WAIT;

            WAIT:
                next = (in == 1) ? IDLE : WAIT;

            default:
                next = IDLE;

        endcase
    end

    always @(posedge clk) begin
        if (reset)
            done_reg <= 0;
        else
            done_reg <= (state == STOP && in == 1);
    end

endmodule