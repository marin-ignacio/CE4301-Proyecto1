module dp(input logic clk, reset, 
                input logic [1:0] RegSrcD, ImmSrcD, 
                input logic ALUSrcE, BranchTakenE, 
                input logic [1:0] ALUControlE, 
                input logic MemtoRegW, PCSrcW, RegWriteW, 
                output logic [31:0] PCF, 
                input logic [31:0] InstrF, 
                output logic [31:12] InstrD, 
                output logic [31:0] ALUOutM, WriteDataM, 
                input logic [31:0] ReadDataM, 
                output logic [3:0] ALUFlagsE,

                input logic [9:0]ReadDataMv,
                output logic [9:0]WDvec,

                // hazard logic 
                output logic Match_1E_M, Match_1E_W, Match_2E_M, Match_2E_W, Match_12D_E, 
                input logic [1:0] ForwardAE, ForwardBE, 
                input logic StallF, StallD, FlushD);

logic [31:0] PCPlus4F, PCnext1F, PCnextF; 
logic [31:0] ExtImmD, rd1D, rd2D, PCPlus8D; 
logic [31:0] rd1E, rd2E, ExtImmE, SrcAE, SrcBE, WriteDataE, ALUResultE; 
logic [31:0] ReadDataW, ALUOutW, ResultW; 
logic [3:0] RA1D, RA2D, RA1E, RA2E, WA3E, WA3M, WA3W; 
logic Match_1D_E, Match_2D_E;

// vector cables
logic V1, V2, V3;
logic [3:0] ALUVF;
logic [9:0][0] Rv1D, Rv2D, Rv1E, Rv2E, WV3E, WV3M, WV3W;
logic [9:0][15:0] vRA2E, vWA3E, vWA3M, vWA3W;
logic [9:0][15:0] WD3V, VD1, VD2;
logic [9:0][15:0] SrcVAE, SrcVBE, ALUVResultE, ALUVResultM, WriteDataVE, WriteDataVM, WriteDataVW, ReadDataVW, VResultW, ALUVResultW;

// Fetch stage
mux2 #(32) pcnextmux(PCPlus4F, ResultW, PCSrcW, PCnext1F);
mux2 #(32) branchmux(PCnext1F, ALUResultE, BranchTakenE, PCnextF);
flopenr #(32) pcreg(clk, reset, ~StallF, PCnextF, PCF);
adder #(32) pcadd(PCF, 32'h4, PCPlus4F);

// Decode Stage
 assign PCPlus8D = PCPlus4F;
  // skip register 
  flopenrc #(32) instrreg(clk, reset, ~StallD, FlushD, InstrF, InstrD); 
  //WTF CON INSTRD [???]
  mux2 #(4) ra1mux(InstrD[19:16], 4'b1111, RegSrcD[0], RA1D); 
  mux2 #(4) ra2mux(InstrD[3:0], InstrD[15:12], RegSrcD[1], RA2D);


  bankRegisterScalar #(32) rfS(clk, RegWriteW, RA1D, RA2D, WA3W, ResultW, PCPlus8D, rd1D, rd2D);

   bankRegisterArray #(16) rfV (clk, RegWriteW, V1, V2, V3, WD3V, VD1, VD2); 

  extend ext(InstrD[23:0], ImmSrcD, ExtImmD);

  
  // Execute Stage 
flopr #(32) rd1reg(clk, reset, rd1D, rd1E); 
flopr #(32) rd2reg(clk, reset, rd2D, rd2E); 
flopr #(32) immreg(clk, reset, ExtImmD, ExtImmE); 
flopr #(4) wa3ereg(clk, reset, InstrD[15:12], WA3E); 
flopr #(4) ra1reg(clk, reset, RA1D, RA1E); 
flopr #(4) ra2reg(clk, reset, RA2D, RA2E); 

/*
//VEC
flopr #(10) rd1regV(clk, reset, rd1D, rd1E); 
flopr #(10) rd2regV(clk, reset, rd2D, rd2E); 
flopr #(10) immreg(clk, reset, ExtImmD, ExtImmE); 
flopr #(4) wa3ereg(clk, reset, InstrD[15:12], WA3E); 
flopr #(4) ra1reg(clk, reset, RA1D, RA1E); 
flopr #(4) ra2reg(clk, reset, RA2D, RA2E);
*/

mux3 #(32) byp1mux(rd1E, ResultW, ALUOutM, ForwardAE, SrcAE); 
mux3 #(32) byp2mux(rd2E, ResultW, ALUOutM, ForwardBE, WriteDataE); 
mux2 #(32) srcbmux(WriteDataE, ExtImmE, ALUSrcE, SrcBE); 
ALU alu(ALUControlE, SrcAE, SrcBE, ALUFlagsE, ALUResultE);
ALUV #(32) aluv(ALUControlE, SrcVAE, SrcVBE, ALUVF, ALUVResultE);

assign SrcVBE = WriteDataVE;

// Memory Stage 
//No estoy seguro sobre [][]
flopr #(16) aluvreg0(clk, reset, ALUVResultE[0], ALUVResultM[0]);
flopr #(16) aluvreg1(clk, reset, ALUVResultE[1], ALUVResultM[1]);
flopr #(16) aluvreg2(clk, reset, ALUVResultE[2], ALUVResultM[2]);
flopr #(16) aluvreg3(clk, reset, ALUVResultE[3], ALUVResultM[3]);
flopr #(16) aluvreg4(clk, reset, ALUVResultE[4], ALUVResultM[4]);
flopr #(16) aluvreg5(clk, reset, ALUVResultE[5], ALUVResultM[5]);
flopr #(16) aluvreg6(clk, reset, ALUVResultE[6], ALUVResultM[6]);
flopr #(16) aluvreg7(clk, reset, ALUVResultE[7], ALUVResultM[7]);
flopr #(16) aluvreg8(clk, reset, ALUVResultE[8], ALUVResultM[8]);
flopr #(16) aluvreg9(clk, reset, ALUVResultE[9], ALUVResultM[9]);

flopr #(16) wdvereg0(clk, reset, WriteDataVE[0], WriteDataVM[0]);
flopr #(16) wdvereg1(clk, reset, WriteDataVE[1], WriteDataVM[1]);
flopr #(16) wdvereg2(clk, reset, WriteDataVE[2], WriteDataVM[2]);
flopr #(16) wdvereg3(clk, reset, WriteDataVE[3], WriteDataVM[3]);
flopr #(16) wdvereg4(clk, reset, WriteDataVE[4], WriteDataVM[4]);
flopr #(16) wdvereg5(clk, reset, WriteDataVE[5], WriteDataVM[5]);
flopr #(16) wdvereg6(clk, reset, WriteDataVE[6], WriteDataVM[6]);
flopr #(16) wdvereg7(clk, reset, WriteDataVE[7], WriteDataVM[7]);
flopr #(16) wdvereg8(clk, reset, WriteDataVE[8], WriteDataVM[8]);
flopr #(16) wdvereg9(clk, reset, WriteDataVE[9], WriteDataVM[9]);


flopr #(32) aluresreg(clk, reset, ALUResultE, ALUOutM); 
flopr #(32) wdreg(clk, reset, WriteDataE, WriteDataM); 
flopr #(4) wa3mreg(clk, reset, WA3E, WA3M);

// Writeback Stage 
flopr #(32) aluoutreg(clk, reset, ALUOutM, ALUOutW); 
flopr #(32) rdreg(clk, reset, ReadDataM, ReadDataW); 
flopr #(4) wa3wreg(clk, reset, WA3M, WA3W); 
mux2 #(32) resmux(ALUOutW, ReadDataW, MemtoRegW, ResultW);

flopr #(16) aluvreg0(clk, reset, ALUVResultE[0], ALUVResultM[0]);
flopr #(16) aluvreg1(clk, reset, ALUVResultE[1], ALUVResultM[1]);
flopr #(16) aluvreg2(clk, reset, ALUVResultE[2], ALUVResultM[2]);
flopr #(16) aluvreg3(clk, reset, ALUVResultE[3], ALUVResultM[3]);
flopr #(16) aluvreg4(clk, reset, ALUVResultE[4], ALUVResultM[4]);
flopr #(16) aluvreg5(clk, reset, ALUVResultE[5], ALUVResultM[5]);
flopr #(16) aluvreg6(clk, reset, ALUVResultE[6], ALUVResultM[6]);
flopr #(16) aluvreg7(clk, reset, ALUVResultE[7], ALUVResultM[7]);
flopr #(16) aluvreg8(clk, reset, ALUVResultE[8], ALUVResultM[8]);
flopr #(16) aluvreg9(clk, reset, ALUVResultE[9], ALUVResultM[9]);

flopr #(16) wdvereg0(clk, reset, WriteDataVE[0], WriteDataVM[0]);
flopr #(16) wdvereg1(clk, reset, WriteDataVE[1], WriteDataVM[1]);
flopr #(16) wdvereg2(clk, reset, WriteDataVE[2], WriteDataVM[2]);
flopr #(16) wdvereg3(clk, reset, WriteDataVE[3], WriteDataVM[3]);
flopr #(16) wdvereg4(clk, reset, WriteDataVE[4], WriteDataVM[4]);
flopr #(16) wdvereg5(clk, reset, WriteDataVE[5], WriteDataVM[5]);
flopr #(16) wdvereg6(clk, reset, WriteDataVE[6], WriteDataVM[6]);
flopr #(16) wdvereg7(clk, reset, WriteDataVE[7], WriteDataVM[7]);
flopr #(16) wdvereg8(clk, reset, WriteDataVE[8], WriteDataVM[8]);
flopr #(16) wdvereg9(clk, reset, WriteDataVE[9], WriteDataVM[9]);

flopr #(16) readDatavwreg0(clk, reset, ReadDataMv[0], ReadDataVW[0]);
flopr #(16) readDatavwreg1(clk, reset, ReadDataMv[1], ReadDataVW[1]);
flopr #(16) readDatavwreg2(clk, reset, ReadDataMv[2], ReadDataVW[2]);
flopr #(16) readDatavwreg3(clk, reset, ReadDataMv[3], ReadDataVW[3]);
flopr #(16) readDatavwreg4(clk, reset, ReadDataMv[4], ReadDataVW[4]);
flopr #(16) readDatavwreg5(clk, reset, ReadDataMv[5], ReadDataVW[5]);
flopr #(16) readDatavwreg6(clk, reset, ReadDataMv[6], ReadDataVW[6]);
flopr #(16) readDatavwreg7(clk, reset, ReadDataMv[7], ReadDataVW[7]);
flopr #(16) readDatavwreg8(clk, reset, ReadDataMv[8], ReadDataVW[8]);
flopr #(16) readDatavwreg9(clk, reset, ReadDataMv[9], ReadDataVW[9]);

flopr #(16) aluvresmwreg0(clk, reset, ALUVResultM[0], ALUVResultW[0]);
flopr #(16) aluvresmwreg1(clk, reset, ALUVResultM[1], ALUVResultW[1]);
flopr #(16) aluvresmwreg2(clk, reset, ALUVResultM[2], ALUVResultW[2]);
flopr #(16) aluvresmwreg3(clk, reset, ALUVResultM[3], ALUVResultW[3]);
flopr #(16) aluvresmwreg4(clk, reset, ALUVResultM[4], ALUVResultW[4]);
flopr #(16) aluvresmwreg5(clk, reset, ALUVResultM[5], ALUVResultW[5]);
flopr #(16) aluvresmwreg6(clk, reset, ALUVResultM[6], ALUVResultW[6]);
flopr #(16) aluvresmwreg7(clk, reset, ALUVResultM[7], ALUVResultW[7]);
flopr #(16) aluvresmwreg8(clk, reset, ALUVResultM[8], ALUVResultW[8]);
flopr #(16) aluvresmwreg9(clk, reset, ALUVResultM[9], ALUVResultW[9]);

mux2VEC #(16) resmux(ReadDataVW, ALUVResultW, MemtoRegW, VResultW);


// hazard comparison 
eqcmp #(4) m0(WA3M, RA1E, Match_1E_M); 
eqcmp #(4) m1(WA3W, RA1E, Match_1E_W); 
eqcmp #(4) m2(WA3M, RA2E, Match_2E_M); 
eqcmp #(4) m3(WA3W, RA2E, Match_2E_W); 
eqcmp #(4) m4a(WA3E, RA1D, Match_1D_E); 
eqcmp #(4) m4b(WA3E, RA2D, Match_2D_E); 
assign Match_12D_E = Match_1D_E | Match_2D_E;

endmodule