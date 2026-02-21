module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
    
    always @ (posedge clk) begin
        if(E) begin 
            if(L) begin
                Q <= R ;
            end
            else begin
                Q <= w ;
            end
        end
        else begin
            if(L) begin
                Q <= R ;
            end
            else begin
                Q <= Q ;
            end
        end
    end

endmodule
