module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out
    );  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    
        case(state)
            A : begin 
                if(in == 0) next_state <= B ;
                else next_state <= A ; 
            end
            B : begin 
                if(in == 0) next_state <= A ;
                else next_state <= B ; 
            end
            default : next_state <= B ;
        endcase
    end

    always @(posedge clk or posedge areset) begin    
        if(areset) state <= B ;
        else state <= next_state ;
    end

    assign out = (state == B );

endmodule
