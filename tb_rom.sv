module tb_rom();

//reg clk;
reg [18:0] addr1;
wire [15:0] data1, data2, data3, data4, data5, data6, data7, data8, data9, data10;

rom romp( .addr1(addr1), .data1(data1), .data2(data2), .data3(data3), .data4(data4), .data5(data5),
			 .data6(data6), .data7(data7), .data8(data8), .data9(data9), .data10(data10));




initial begin
   addr1 <= 19'h0;
#5 addr1 <= 19'h4AFEC;
#5 addr1 <= 19'h200;

end
endmodule