`timescale 1ns/100ps



module tb_ROMSimulation();
reg clk_s;
reg [18:0] address_s;
wire [7:0] q_s;
RomImage ROM_DUT(address_s, clk_s, q_s);

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