
module rom(			  input wire [18:0] addr1,addr2,addr3,addr4,addr5,addr6,addr7,addr8,addr9,addr10,
                    output reg [15:0] data1,data2,data3,data4,data5,data6,data7,data8,data9,data10);

parameter file = "image.txt";


reg [7:0] rom [307200:0];

//always @(posedge clk) begin
   //data1 <= rom[addr1];
	//data2 <= rom[addr2];
	//data3 <= rom[addr3];
	//data4 <= rom[addr4];
	//data5 <= rom[addr5];
	//data6 <= rom[addr6];
	//data7 <= rom[addr7];
	//data8 <= rom[addr8];
	//data9 <= rom[addr9];
	//data10 <= rom[addr10];
//end

assign data1= {rom[addr1], rom[addr1+1]};
assign data2= {rom[addr2+1], rom[addr2+2]};
assign data3= {rom[addr3+2], rom[addr3+3]};
assign data4= {rom[addr4+3], rom[addr4+4]};
assign data5= {rom[addr5+4], rom[addr5+5]};
assign data6= {rom[addr6+5], rom[addr6+6]};
assign data7= {rom[addr7+6], rom[addr7+7]};
assign data8= {rom[addr8+7], rom[addr8+8]};
assign data9= {rom[addr9+8], rom[addr9+9]};
assign data10= {rom[addr10+9], rom[addr10+10]};
initial begin
  $readmemh(file, rom);
end

endmodule