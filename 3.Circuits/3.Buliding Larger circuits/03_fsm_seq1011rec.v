module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);

    parameter search = 0;
    parameter found  = 1;

    reg state, next;
    reg [3:0] bits;

    always @(*) begin
        next = state;

        case (state)
            search: begin
                if ({bits[2:0], data} == 4'b1101)
                    next = found;
            end

            found: begin
                next = found;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            bits  <= 4'b0000;
            state <= search;
        end
        else begin
            bits  <= {bits[2:0], data};  
            state <= next;
        end
    end

    assign start_shifting = (state == found);

endmodule