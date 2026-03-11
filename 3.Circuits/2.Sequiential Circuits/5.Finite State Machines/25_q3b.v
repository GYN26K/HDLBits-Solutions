module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    localparam x1 = 3'b000;
    localparam x2 = 3'b001;
    localparam x3 = 3'b100;
    localparam x4 = 3'b010;
    localparam x5 = 3'b011;

    reg [2:0] state ;
    reg [2:0] next ;

    always @ (posedge clk) begin 
        if(reset) state <= x1 ;
        else state <= next ;
    end

    always @ (*) begin
        case(state)
            3'b000 : next = x ? 3'b001 : 3'b000 ;
            3'b001 : next = x ? 3'b100 : 3'b001 ;
            3'b010 : next = x ? 3'b001 : 3'b010 ;
            3'b011 : next = x ? 3'b010 : 3'b001 ;
            3'b100 : next = x ? 3'b100 : 3'b011 ;
        endcase 
    end

    assign z = ((state == x5)|(state == x3));

endmodule