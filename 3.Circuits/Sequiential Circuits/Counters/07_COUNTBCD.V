module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);

    reg [3:0] one, ten, hund, thou;

    always @(posedge clk) begin
        if (reset) begin
            one  <= 4'd0;
            ten  <= 4'd0;
            hund <= 4'd0;
            thou <= 4'd0;
        end
        else begin
            if (one == 9) begin
                one <= 0;

                if (ten == 9) begin
                    ten <= 0;

                    if (hund == 9) begin
                        hund <= 0;

                        if (thou == 9)
                            thou <= 0;
                        else
                            thou <= thou + 1;
                    end
                    else
                        hund <= hund + 1;
                end
                else
                    ten <= ten + 1;
            end
            else
                one <= one + 1;
        end
    end

    assign ena[1] = (one  == 4'd9);
    assign ena[2] = (one  == 4'd9) && (ten  == 4'd9);
    assign ena[3] = (one  == 4'd9) && (ten  == 4'd9) && (hund == 4'd9);

    assign q = {thou, hund, ten, one};

endmodule
