module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter bit = 2'b0 ;
    parameter found = 2'd1 ;
    parameter idle = 2'd2 ;

    reg [1:0] state , next ;

    reg [2:0] bits ;

    always @ (posedge clk or posedge aresetn) begin 
        if(aresetn) begin
            state <= idle ;
        end
        else begin 
            state <= next ;
        end
    end

    always @ (*) begin 
        case(state)
            idle : next = bits ;

            bits : begin 
                if(bits == 101) next = found ;
                else next = bits ;
            end  

            found : next = bits ;
        endcase
    end

    always @ (posedge clk or posedge aresetn) begin
        if(aresetn) begin
            bits <= 3'b0;
        end
        else begin 
            bits <= {bits[1:0] , x} ;
        end
    end 

    assign z = (state == found) ;

endmodule