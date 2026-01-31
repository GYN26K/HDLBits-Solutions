module top_module(
    input  [2:0] a, b,
    input        cin,
    output [2:0] cout,
    output [2:0] sum
);

    wire c1, c2;

    assign {c1, sum[0]} = a[0] + b[0] + cin;
    assign {c2, sum[1]} = a[1] + b[1] + c1;
    assign {cout[2], sum[2]} = a[2] + b[2] + c2;

    assign cout[0] = c1;
    assign cout[1] = c2;

endmodule