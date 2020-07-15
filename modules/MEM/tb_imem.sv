module tb_imem();

reg [31:0] a;
wire [32:0] rd;
imem imemp( .a(a), .rd(rd));



initial begin
   a <= 32'h0;
#5 a <= 32'h5;
#5 a <= 32'h9;
#5 a <= 32'hD;
#5 a <= 32'h11;
#5 a <= 32'h15;

end
endmodule