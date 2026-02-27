module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 

    reg [7:0] bits ;
    reg state ;
    reg next ;

    always @ (posedge clk) begin
        if(reset) begin 
            done <= 1'b0 ;
        end
        else begin 
            state <= next ;
        end
    end

endmodule