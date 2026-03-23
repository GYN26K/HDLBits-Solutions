module top_module (
    input [5:0] y,   // current state (one-hot)
    input w,
    output Y1,
    output Y3
);

    localparam a = 6'b000001;
    localparam b = 6'b000010;
    localparam c = 6'b000100;
    localparam d = 6'b001000;
    localparam e = 6'b010000;
    localparam f = 6'b100000;

    reg [5:0] next;

    always @(*) begin 
        case ({y, w})
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

    assign Y1 = next[1];
    assign Y3 = next[3];

endmodule