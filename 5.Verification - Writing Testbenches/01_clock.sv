module top_module ( );

reg clk ;

dut clk1 (.clk(clk));

initial begin
    clk= 0 ;
    forever #5 clk = ~clk ;
end

endmodule

module dut ( input clk ) ;

endmodule