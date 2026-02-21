module top_module (
    input clk,
    input a,
    output [3:0] q );

    reg [2:0] count ;

    always @ (posedge clk) begin
        if(a) begin 
            count <= 4 ;
        end
        else if(count == 6) begin 
            count <= 0 ;
        end
        else if(a == 0) begin
            count <= count + 1 ;
        end
    end 

    assign q = count ;

endmodule
