module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  

    // Fill in state name declarations
	parameter A = 0, B = 1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) present_state <=  B;
        else  present_state <= next_state;
    end
       
    always @(*) begin
        case (present_state)
            B : begin
                    if(in) begin
                        next_state <= B ;
                    end
                    else begin 
                        next_state <= A ;
                    end
            end
            A : begin
                    if(in) begin
                        next_state <= A ;
                    end
                    else begin 
                        next_state <= B ;
                    end
            end
        endcase
    end
        
    assign out = (present_state == B);

endmodule