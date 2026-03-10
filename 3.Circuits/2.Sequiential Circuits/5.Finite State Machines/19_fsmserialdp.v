module top_module(
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    parameter IDLE=0, DATA=1, PARITY=2, STOP=3, WAIT=4;

    reg [2:0] state,next;
    reg [2:0] count;
    reg [7:0] data;
    reg done_reg;
    wire odd;
    reg parity_reset;

    parity parity(clk, parity_reset, in, odd);

    assign out_byte = data;
    assign done = done_reg;

    always @(posedge clk) begin
        if(reset) state <= IDLE;
        else state <= next;
    end
    always @(posedge clk) begin
        if(reset) count <= 0;

        else if(state==DATA) count <= count+1;
        
        else count <= 0;
    end

    always @(posedge clk) begin
        if(state==DATA) data <= {in,data[7:1]};
    end

    always @(*) begin
        case(state)
            
            IDLE:   next = (in==0) ? DATA : IDLE;
            DATA:   next = (count==3'd7) ? PARITY : DATA;
            PARITY: next = STOP;
            STOP:   next = in ? IDLE : WAIT;
            WAIT:   next = in ? IDLE : WAIT;
            default:next = IDLE;
        
        endcase
    end

    always @(*) begin
        parity_reset = reset | (state==IDLE);
    end

    always @(posedge clk) begin
        
        if(reset) done_reg <= 0;

        else done_reg <= (state==STOP && in && odd);
    end

endmodule

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule
