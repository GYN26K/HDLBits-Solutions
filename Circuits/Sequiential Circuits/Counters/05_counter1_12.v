module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    reg [4:0] count = 1 ; 

    always @ (posedge clk) begin 
        if(reset | ((count == 12) & enable )) begin 
            count <= 4'b0001 ;
        end
        else if(enable) begin 
            count <= count + 1 ;
        end
        else begin 
            count <= count ;
        end
    end

    assign Q = count ;

    assign c_enable = enable ;
    assign c_load = (reset | ((count == 12) & enable));
    assign c_d = c_load ? 1 : 0;


    count4 the_counter (clk, c_enable, c_load, c_d /*, ... */ );

endmodule