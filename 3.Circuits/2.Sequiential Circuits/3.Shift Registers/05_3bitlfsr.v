module top_module (
    input [2:0] SW,      
    input [1:0] KEY,     
    output [2:0] LEDR
);

    wire r1, r2, r3;  
    wire d0, d1, d2; 
    
    assign d2 = LEDR[2] ^ LEDR[1];
    assign d1 = LEDR[0];
    assign d0 = LEDR[2];           

    mux mux1 (SW[0], d0, KEY[1], r1);
    mux mux2 (SW[1], d1, KEY[1], r2);
    mux mux3 (SW[2], d2, KEY[1], r3);

    d_ff dff1 (r1, KEY[0], LEDR[0]);
    d_ff dff2 (r2, KEY[0], LEDR[1]);
    d_ff dff3 (r3, KEY[0], LEDR[2]);

endmodule


module d_ff(
    input d,
    input clk,
    output reg q
);
    always @(posedge clk)
        q <= d;
endmodule


module mux(
    input r,
    input q,
    input slt,
    output qout
);
    assign qout = slt ? r : q;
endmodule