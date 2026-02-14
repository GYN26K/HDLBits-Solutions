module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = 4'b0001 ;
    assign next_state[B] = 4'b0010 ;
    assign next_state[C] = 4'b0100 ;
    assign next_state[D] = 4'b1000 ;

    

    // Output logic: 
    assign out = ;

endmodule