module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [15:0] sum1 , sum2;
    wire carry;
    wire out ;

    add16 m1(a[15:0] , b[15:0] , 1'b0 , sum1 , carry);
    add16 m2(a[31:16] , b[31:16] , carry , sum2 , out);

    assign sum = {sum2 , sum1};

endmodule