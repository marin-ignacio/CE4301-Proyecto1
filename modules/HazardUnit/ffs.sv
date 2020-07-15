module   flopenr #(parameter WIDTH = 8)

(input logic clk, reset, en, 
input logic [WIDTH-1:0] d, 
output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
 if (reset) q <= 0;
else if (en) q <= d;

endmodule

module flopr #(parameter WIDTH = 8)

(input logic clk, reset, 
input logic [WIDTH-1:0] d, 
output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset) 
if (reset) q <= 0; 
else q <= d;

endmodule


module flopenrc #(parameter WIDTH = 8)

(input logic clk, reset, en, clear, 
input logic [WIDTH-1:0] d, 
output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
 if (reset)     q <= 0;
 else if (en) 
    if (clear)  q <= 0; 
    else        q <= d;


endmodule


module floprc #(parameter WIDTH = 8)

(input logic clk, reset, clear, 
input logic [WIDTH-1:0] d, 
output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0; 
    else 
        if (clear) q <= 0; 
        else q <= d;


endmodule


module mux2 #(parameter WIDTH = 8)

(input logic [WIDTH-1:0] d0, d1, 
input logic s, 
output logic [WIDTH-1:0] y);

assign y = s ? d1 : d0;

 endmodule

module mux3 #(parameter WIDTH = 8)

(input logic [WIDTH-1:0] d0, d1, d2, 
input logic [1:0] s, 
output logic [WIDTH-1:0] y);

assign y = s[1] ? d2 : (s[0] ? d1 : d0); 

endmodule

module eqcmp #(parameter WIDTH = 8)

(input logic [WIDTH-1:0] a, b, 
output logic y);

assign y = (a == b);

endmodule