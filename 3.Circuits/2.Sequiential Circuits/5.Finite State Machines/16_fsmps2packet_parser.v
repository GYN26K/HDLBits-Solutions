module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    localparam [1:0] X  = 2'b00,
                     Y1 = 2'b01,
                     Y2 = 2'b10,
                     Z  = 2'b11;

    reg [1:0] state, next;

    reg [23:0] bits ;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            X :  begin 
                next = (in[3]) ? Y1 : X;
            end
            Y1:  begin 
                next = Y2;
            end
            Y2:  begin 
                next = Z;
            end
            Z :  next = (in[3]) ? Y1 : X;
            default: next = X;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
    	if (reset) begin
            state <= X ;
            bits <= 24'b0;
        end
    	else begin
            state <= next ;
            bits <= {bits[15:8], bits[7:0], in}; // like a auto shift register
        end
    end

    // Output logic
    assign done = (state == Z);
    assign out_bytes = done ? bits : 24'b0 ;

endmodule