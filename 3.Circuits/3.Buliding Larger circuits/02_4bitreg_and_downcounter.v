module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q
);

    reg [3:0] counter;

    always @(posedge clk) begin
        if (shift_ena) begin
            counter <= {counter[2:0] , data};
        end
        else if (count_ena) begin
            counter <= counter - 1; 
        end
    end

    assign q = counter;

endmodule