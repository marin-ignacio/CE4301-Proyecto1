
module rom(			  input logic clk_s, 
					     input logic [18:0] address_s,
                    output logic [15:0] d1, d2,d3,d4,d5, d6,d7,d8,d9,d10);

parameter file = "image.txt";
logic [7:0] q_s1, q_s2, q_s3, q_s4, q_s5, q_s6, q_s7, q_s8, q_s9, q_s10,q_s11, q_s12, q_s13, q_s14, q_s15, q_s16, q_s17, q_s18, q_s19, q_s20;


reg [15:0] DataOut [9:0] ='{default:16'd0};

RomImage RI1 (.address(address_s), .clock(clk_s), .q(q_s1));
RomImage RI2 (.address(address_s+1'd1), .clock(clk_s), .q(q_s2));

RomImage RI3 (.address(address_s+2'd2), .clock(clk_s), .q(q_s3));
RomImage RI4 (.address(address_s+3'd3), .clock(clk_s), .q(q_s4));

RomImage RI5 (.address(address_s+4'd4), .clock(clk_s), .q(q_s5));
RomImage RI6 (.address(address_s+5'd5), .clock(clk_s), .q(q_s6));

RomImage RI7 (.address(address_s+6'd6), .clock(clk_s), .q(q_s7));
RomImage RI8 (.address(address_s+7'd7), .clock(clk_s), .q(q_s8));

RomImage RI9 (.address(address_s+8'd8), .clock(clk_s), .q(q_s9));
RomImage RI10 (.address(address_s+9'd9), .clock(clk_s), .q(q_s10));

RomImage RI11 (.address(address_s+10'd10), .clock(clk_s), .q(q_s11));
RomImage RI12 (.address(address_s+11'd11), .clock(clk_s), .q(q_s12));

RomImage RI13 (.address(address_s+12'd12), .clock(clk_s), .q(q_s13));
RomImage RI14 (.address(address_s+13'd13), .clock(clk_s), .q(q_s14));

RomImage RI15 (.address(address_s+14'd14), .clock(clk_s), .q(q_s15));
RomImage RI16 (.address(address_s+15'd15), .clock(clk_s), .q(q_s16));

RomImage RI17 (.address(address_s+16'd16), .clock(clk_s), .q(q_s17));
RomImage RI18 (.address(address_s+17'd17), .clock(clk_s), .q(q_s18));

RomImage RI19 (.address(address_s+18'd18), .clock(clk_s), .q(q_s19));
RomImage RI20 (.address(address_s+19'd19), .clock(clk_s), .q(q_s20));


assign d1= {q_s1, q_s2};
assign d2= {q_s3, q_s4};
assign d3= {q_s5, q_s6};
assign d4= {q_s7, q_s8};
assign d5= {q_s9, q_s10};
assign d6= {q_s11, q_s12};
assign d7= {q_s13, q_s14};
assign d8= {q_s15, q_s16};
assign d9= {q_s17, q_s18};
assign d10= {q_s19, q_s20};


endmodule