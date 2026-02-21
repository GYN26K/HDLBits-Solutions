module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff u_tff(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    initial begin
        reset = 1'b0;
        #3;
        reset = 1'b1;
        #10;
        reset = 1'b0;   
    end
    
    
    initial begin
        clk = 0;
        forever #5 clk=~clk;
    end

    always@(posedge clk)begin
        if(reset)begin
            t <= 1'b0;
        end
        else begin
            t <= 1'b1;
        end
    end

endmodule

// Ignore this code its just for not getting error in vscode

module tff (
    input clk,
    input reset,   // active-high synchronous reset
    input t,       // toggle
    output reg q
);

    always@(posedge clk)begin
        if(reset)begin
            q <= 1'b0;
        end
        else begin
            q <= t;
        end
    end

endmodule