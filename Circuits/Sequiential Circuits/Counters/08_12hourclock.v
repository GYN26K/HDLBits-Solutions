module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    reg [7:0] seconds = 8'h00;
    reg [7:0] minutes = 8'h00;
    reg [7:0] hours   = 8'h12;
    reg am = 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            seconds <= 8'h00;
            minutes <= 8'h00;
            hours   <= 8'h12;
            am      <= 1'b0;
        end
        else if (ena) begin
            if (seconds == 8'h59) begin
                seconds <= 8'h00;

                if (minutes == 8'h59) begin
                    minutes <= 8'h00;

                    if (hours == 8'h11) begin
                        hours <= 8'h12;
                        am <= ~am;
                    end
                    else if (hours == 8'h12) begin
                        hours <= 8'h01;
                    end
                    else begin
                        if (hours[3:0] == 4'd9)
                            hours <= {hours[7:4] + 1'b1, 4'd0};
                        else
                            hours <= hours + 1'b1;
                    end
                end
                else begin
                    if (minutes[3:0] == 4'd9)
                        minutes <= {minutes[7:4] + 1'b1, 4'd0};
                    else
                        minutes <= minutes + 1'b1;
                end
            end
            else begin
                if (seconds[3:0] == 4'd9)
                    seconds <= {seconds[7:4] + 1'b1, 4'd0};
                else
                    seconds <= seconds + 1'b1;
            end
        end
    end

    assign ss = seconds;
    assign mm = minutes;
    assign hh = hours;
    assign pm = am;

endmodule

