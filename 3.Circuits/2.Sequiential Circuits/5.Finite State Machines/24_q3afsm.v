module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    localparam A = 1'b0 ;
    localparam B = 1'b1 ;

    always @ (posedge clk) begin 
    end

endmodule
