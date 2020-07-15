module top(input logic clk, reset,

output logic [31:0] WriteDataM, DataAdrM, output logic MemWriteM);

logic [31:0] PCF, InstrF, ReadDataM;

// instantiate processor and memories 
arm arm(clk, reset, PCF, InstrF, MemWriteM, DataAdrM, WriteDataM, ReadDataM); 
imem imem(PCF, InstrF); 
dmem dmem(clk, MemWriteM, DataAdrM, WriteDataM, ReadDataM); 

endmodule

module dmem(input logic clk, we, input logic [31:0] a, wd, output logic [31:0] rd);

logic [31:0] RAM[2097151:0];

initial $readmemh("memfile.dat",RAM);

assign rd = RAM[a[22:2]]; // word aligned

always_ff @(posedge clk)

if (we) RAM[a[22:2]] <= wd;

endmodule