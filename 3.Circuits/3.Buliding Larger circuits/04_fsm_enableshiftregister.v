module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [1:0] counter = 2'b11 ;
    reg flag = 1'b0 ;

    always @ (posedge clk) begin 
        if(reset) begin 
            counter <= 2'b11 ;
            flag <= 1'b0 ;
        end
        else if(counter == 0) begin
            flag <= 1'b1 ;
        end
        else if(counter != 0) begin 
            counter <= counter - 1;
        end
    end

    assign shift_ena = ~flag ;

endmodule
