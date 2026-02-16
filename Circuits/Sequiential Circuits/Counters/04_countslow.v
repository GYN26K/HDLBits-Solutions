module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);

    reg [3:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 4'd0;
        end
        else if (slowena) begin
            if (counter == 4'd9)
                counter <= 4'd0;
            else
                counter <= counter + 1;
        end
    end

    assign q = counter;

endmodule
