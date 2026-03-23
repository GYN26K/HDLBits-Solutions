module top_module (
    input clk,
    input reset,     // Synchronous active-high reset
    input w,
    output z
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
            {a,1'b0}: next = a;
            {a,1'b1}: next = b;

            {b,1'b0}: next = d;
            {b,1'b1}: next = c;

            {c,1'b0}: next = d;
            {c,1'b1}: next = e;

            {d,1'b0}: next = a;
            {d,1'b1}: next = f;

            {e,1'b0}: next = d;
            {e,1'b1}: next = e;

            {f,1'b0}: next = d;
            {f,1'b1}: next = c;

            default: next = a;
        endcase
    end

    assign z = (state == e || state == f);

endmodule