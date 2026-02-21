module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    always @ (posedge clk) begin 
        if(load) begin 
            q <= data;
        end
        else begin 
            q<= ;
        end
    end
 
endmodule