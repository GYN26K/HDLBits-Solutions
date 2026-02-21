module top_module (
    input clock,
    input a,
    output reg p,
    output reg q 
);

    always @ (* ) begin 
        if(clock )
            p = a ;
    end

    always @ (negedge clock) begin
        q <= a ;
    end
endmodule