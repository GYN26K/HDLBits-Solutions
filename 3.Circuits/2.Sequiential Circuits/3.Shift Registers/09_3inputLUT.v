module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z
);

    wire [7:0] q;
    wire [7:0] d;

    assign d[0] = enable ? S    : q[0];
    assign d[1] = enable ? q[0] : q[1];
    assign d[2] = enable ? q[1] : q[2];
    assign d[3] = enable ? q[2] : q[3];
    assign d[4] = enable ? q[3] : q[4];
    assign d[5] = enable ? q[4] : q[5];
    assign d[6] = enable ? q[5] : q[6];
    assign d[7] = enable ? q[6] : q[7];

    d_ff dff1 (d[0], clk, q[0]);
    d_ff dff2 (d[1], clk, q[1]);
    d_ff dff3 (d[2], clk, q[2]);
    d_ff dff4 (d[3], clk, q[3]);
    d_ff dff5 (d[4], clk, q[4]);
    d_ff dff6 (d[5], clk, q[5]);
    d_ff dff7 (d[6], clk, q[6]);
    d_ff dff8 (d[7], clk, q[7]);

    assign Z = q[{A,B,C}];

endmodule


module d_ff(
    input d,
    input clk,
    output reg q
);
    always @(posedge clk)
        q <= d;
endmodule