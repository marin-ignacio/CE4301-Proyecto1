module dramImage(   input logic clk, we,
				        input logic [17:0] a1,  a2, a3, a4, a5, a6, a7, a8, a9, a10,
			           input logic [15:0] wd1, wd2, wd3, wd4, wd5, wd6, wd7, wd8, wd9, wd10,
						  output logic [15:0] rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10);


logic [15:0] ram[153600:0]; 
assign rd1 =  ram[a1];
assign rd2 =  ram[a2];
assign rd3 =  ram[a3];
assign rd4 =  ram[a4];
assign rd5 =  ram[a5];
assign rd6 =  ram[a6];
assign rd7 =  ram[a7];
assign rd8 =  ram[a8];
assign rd9 =  ram[a9];
assign rd10 =  ram[a10];


always_ff @(posedge clk)
if (we) 
begin
 ram[a1] <= wd1; 
 ram[a2] <= wd2;
 ram[a3] <= wd3;
 ram[a4] <= wd4;
 ram[a5] <= wd5;
 ram[a6] <= wd6;
 ram[a7] <= wd7;
 ram[a8] <= wd8;
 ram[a9] <= wd9;
 ram[a10] <= wd10;
end


endmodule
