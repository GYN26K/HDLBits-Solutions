module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
  );
   
	wire [3:0] count1, count2, count3;

	bcdcount counter0 (clk, reset, c_enable[0], count1);
	bcdcount counter1 (clk, reset, c_enable[1], count2);
	bcdcount counter2 (clk, reset, c_enable[2], count3);

	assign c_enable = {(count1 == 4'b1001) & (count2 == 4'b1001), count1 == 4'b1001, 1'b1};
	assign OneHertz = (count1 == 4'b1001) & (count2 == 4'b1001) & (count3 == 4'b1001);
    // ITS 999 AS 0 - 999 IS 1000 .
    
endmodule