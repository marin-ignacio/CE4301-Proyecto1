module tb_dramImage();



reg clk, we;
reg [17:0] a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
reg [15:0] wd1, wd2, wd3, wd4, wd5, wd6, wd7, wd8, wd9, wd10;

dramImage dramImagep( .clk(clk), .we(we), .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5),
			 .a6(a6), .a7(a7),  .a8(a8), .a9(a9), .a10(a10),
			 .wd1(wd1), .wd2(wd2), .wd3(wd3), .wd4(wd4), .wd5(wd5),
			 .wd6(wd6), .wd7(wd7), .wd8(wd8), .wd9(wd9), .wd10(wd10));


always begin
	
  	clk <=0;
  	#5;
  	clk <=1;
	#5;
  	
end

initial begin
#5 we <= 1;
 a1 <= 18'd0; wd1 <= 16'd111;
 a2 <= 18'd1; wd2 <= 16'd110;
 a3 <= 18'd3; wd3 <= 16'd112;
 a4 <= 18'd4; wd4 <= 16'd113;
 a5 <= 18'd5; wd5 <= 16'd114;
 a6 <= 18'd6; wd6 <= 16'd115;
 a7 <= 18'd7; wd7 <= 16'd116;
 a8 <= 18'd8; wd8 <= 16'd117;
 a9 <= 18'd9; wd9 <= 16'd118;
 a10 <= 18'd10; wd10 <= 16'd119;

end
endmodule