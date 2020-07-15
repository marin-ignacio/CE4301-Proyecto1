`timescale 1ns/100ps
module tb_rom();

reg clk_s;
reg [18:0] address_s;
wire [15:0] d1, d2, d3, d4, d5, d6, d7, d8, d9, d10;

rom romp( .clk_s(clk_s), .address_s(address_s), .d1(d1), .d2(d2), .d3(d3), .d4(d4), .d5(d5),
			 .d6(d6), .d7(d7), .d8(d8), .d9(d9), .d10(d10));
			 
			 
always begin
clk_s <=0;
#10;
clk_s <= 1;
#10;
end


initial begin
@(posedge clk_s);
#5 address_s <= 19'h0;
@(posedge clk_s);
#5 address_s <= 19'h0;
@(posedge clk_s);
#5 address_s <= 19'h4AFEC;
@(posedge clk_s);
#5 address_s <= 19'h4AFEC;

end
endmodule