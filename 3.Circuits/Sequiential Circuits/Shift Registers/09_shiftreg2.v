module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    
    dff dff0(SW[3], KEY[0], KEY[1], KEY[2], KEY[3], LEDR[3]);
    dff dff1(SW[2], KEY[0], KEY[1], KEY[2], LEDR[3], LEDR[2]);
    dff dff2(SW[1], KEY[0], KEY[1], KEY[2], LEDR[2], LEDR[1]);
    dff dff3(SW[0], KEY[0], KEY[1], KEY[2], LEDR[1], LEDR[0]);

endmodule

module dff (
    input R,
    input clk,
    input E,
    input L,
    input w,
    output reg out
);
    wire [1:0] temp;
    assign temp[0] = E ? w : out;
    assign temp[1] = L ? R : temp[0];
    
    always @(posedge clk) begin
        out <= temp[1];
    end

endmodule