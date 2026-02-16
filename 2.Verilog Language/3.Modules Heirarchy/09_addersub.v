module top_module(
    input  [31:0] a,
    input  [31:0] b,
    input         sub,
    output [31:0] sum
);

    wire [31:0] bx;
    wire c1;


    assign bx = b ^ {32{sub}};

    add16 add_low (
        .a(a[15:0]),
        .b(bx[15:0]),
        .cin(sub),
        .sum(sum[15:0]),
        .cout(c1)
    );

    add16 add_high (
        .a(a[31:16]),
        .b(bx[31:16]),
        .cin(c1),
        .sum(sum[31:16]),
        .cout()
    );

endmodule
