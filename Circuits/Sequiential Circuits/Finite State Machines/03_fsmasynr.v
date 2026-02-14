module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case(state)
            OFF : begin
                if(j) begin
                    next_state <= ON ;
                end
                else if(j==0) begin
                    next_state <= OFF ;
                end
                else begin
                    next_state <= state ;
                end
            end
            ON : begin
                if(k) begin
                    next_state <= OFF ;
                end
                else if(k==0) begin
                    next_state <= ON ;
                end
                else begin
                    next_state <= state ;
                end
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= OFF ;
        end
        else begin
            state <= next_state ;
        end
    end

    assign out = (state == ON) ?  1 :  0 ;
    // Output logic
    // assign out = (state == ...);

endmodule
