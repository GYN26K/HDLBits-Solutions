module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    
    always @ (posedge clk) begin
        Q <= ~j&~k& Q | j&~k | j&k&~Q ;
    end

endmodule
