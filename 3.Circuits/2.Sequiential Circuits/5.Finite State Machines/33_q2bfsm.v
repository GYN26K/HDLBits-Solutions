module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
); 

    parameter A=4'd0, f1=4'd1, tmp0=4'd2, tmp1=4'd3, tmp2=4'd4, g1=4'd5, g1p=4'd6, tmp3=4'd7, g0p=4'd8;
    reg [3:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = f1;

            f1: next = tmp0;

            tmp0: begin
                if(x) next = tmp1;
                else next = tmp0;
            end

            tmp1: begin
                if(~x) next = tmp2;
                else next = tmp1;
            end

            tmp2: begin
                if(x) next = g1;
                else next = tmp0;
            end

            g1: begin
                if(y) next = g1p;
                else next = tmp3;
            end

            tmp3: begin
                if(y) next = g1p;
                else next = g0p;
            end

            g1p: next = g1p;

            g0p: next = g0p;

            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(~resetn)
            state <= A;
        else
            state <= next;
    end
    
    always @(*) begin
        f = 0;
        g = 0;

        case(state)
            f1: f = 1;
            g1: g = 1;
            tmp3: g = 1;
            g1p: g = 1;
            g0p: g = 0;
        endcase
    end

endmodule