module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [1:0] level;
    reg [1:0] level_prev;

    // Decode sensors directly to level
    always @(*) begin
        if (s[3])
            level = 2'd3;
        else if (s[2])
            level = 2'd2;
        else if (s[1])
            level = 2'd1;
        else
            level = 2'd0;
    end

    // Register previous level
    always @(posedge clk) begin
        if (reset)
            level_prev <= 2'd0;
        else
            level_prev <= level;
    end

    // Drop flag
    always @(posedge clk) begin
        if (reset)
            dfr <= 1'b0;
        else
            dfr <= (level_prev > level);
    end

    // Outputs
    always @(*) begin
        case (level)
            2'd0: begin 
                fr1=1; 
                fr2=1; 
                fr3=1; 
                end
            2'd1: begin 
                fr1=1; 
                fr2=1; 
                fr3=0; 
                end
            2'd2: begin 
                fr1=1; 
                fr2=0; 
                fr3=0; end
            2'd3: begin 
                fr1=0; 
                fr2=0; 
                fr3=0; 
                end
        endcase
    end

endmodule
