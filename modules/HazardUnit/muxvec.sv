module mux2VEC #(parameter WIDTH = 8)

(input logic [9:0][WIDTH-1:0] d0, d1, 
input logic s, 
output logic [9:0][WIDTH-1:0] y);

assign y[0] = s ? d1[0] : d0[0];
assign y[1] = s ? d1[1] : d0[1];
assign y[2] = s ? d1[2] : d0[2];
assign y[3] = s ? d1[3] : d0[3];
assign y[4] = s ? d1[4] : d0[4];
assign y[5] = s ? d1[5] : d0[5];
assign y[6] = s ? d1[6] : d0[6];
assign y[7] = s ? d1[7] : d0[7];
assign y[8] = s ? d1[8] : d0[8];
assign y[9] = s ? d1[9] : d0[9];

endmodule

