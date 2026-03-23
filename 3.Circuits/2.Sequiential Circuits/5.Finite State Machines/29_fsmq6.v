module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output reg z
);

    reg [2:0] state;
    reg [2:0] next;

    localparam a = 3'd0;
    localparam b = 3'd1;
    localparam c = 3'd2;
    localparam d = 3'd3;
    localparam e = 3'd4;
    localparam f = 3'd5;

    always @(posedge clk) begin 
        if (reset)
            state <= a;
        else
            state <= next;
    end

    always @(*) begin 
        case ({state, w})
            {a,1'b0}: next = b;
            {a,1'b1}: next = a;

            {b,1'b0}: next = c;
            {b,1'b1}: next = d;

            {c,1'b0}: next = e;
            {c,1'b1}: next = d;

            {d,1'b0}: next = f;
            {d,1'b1}: next = a;

            {e,1'b0}: next = e;
            {e,1'b1}: next = d;

            {f,1'b0}: next = c;
            {f,1'b1}: next = d;

            default: next = a;
        endcase
    end

    always @(*) begin
        if (state == e || state == f)
            z = 1;
        else
            z = 0;
    end

endmodule