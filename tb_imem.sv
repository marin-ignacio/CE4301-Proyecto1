module tb_imem();

reg [31:0] a;
wire [32:0] rd;
imem imemp( .a(a), .rd(rd));



initial begin
#5 a <= 32'd0;
#5 a <= 32'd5;
#5 a <= 32'd9;
#5 a <= 32'd13;
#5 a <= 32'd17;
#5 a <= 32'd21;

end
endmodule