module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = (~b&~c)|(~a&~d)|(a&d&c)|(~a&c&b);

endmodule