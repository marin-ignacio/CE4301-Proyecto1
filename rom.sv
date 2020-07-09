
module rom(			  input logic [18:0] addr1,
                    output logic [15:0] data1,data2,data3,data4,data5,data6,data7,data8,data9,data10);

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
assign data2= {rom[addr1+2], rom[addr1+3]};
assign data3= {rom[addr1+4], rom[addr1+5]};
assign data4= {rom[addr1+6], rom[addr1+7]};
assign data5= {rom[addr1+8], rom[addr1+9]};
assign data6= {rom[addr1+10], rom[addr1+11]};
assign data7= {rom[addr1+12], rom[addr1+13]};
assign data8= {rom[addr1+14], rom[addr1+15]};
assign data9= {rom[addr1+16], rom[addr1+17]};
assign data10= {rom[addr1+18], rom[addr1+19]};
initial begin
  $readmemh(file, rom);
end

endmodule