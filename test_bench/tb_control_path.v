`include "../rtl/control_path.v"
`timescale 1ns/100ps

module tb_control_path;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min='h0,max='hf;
//-------------------------------------------------------------------------- global signals
  reg   clk;
  reg   reset_n;
//-------------------------------------------------------------------------- matrix A i/o
  wire  en_ReadMat_A;
  wire  en_WriteMat_A;
  wire  [3:0] rowAddr_A;
  wire  [3:0] colAddr_A;
//-------------------------------------------------------------------------- matrix B i/o
  wire  en_ReadMat_B;
  wire  en_WriteMat_B;
  wire  [3:0] rowAddr_B;
  wire  [3:0] colAddr_B;
//-------------------------------------------------------------------------- data path i/o
  wire  en_Mux;
  wire  en_PPReg;
  wire  en_FDReg;
//-------------------------------------------------------------------------- matrix C i/o
  wire  en_ReadMat_C;
  wire  en_WriteMat_C;
  wire  [3:0] rowAddr_C;
  wire  [3:0] colAddr_C;

//-------------------------------------------------------------------------- DUT instantiated
control_path CONTROL_PATH(
	.clk           (clk           ),
  .reset_n       (reset_n       ),
  .en_ReadMat_A  (en_ReadMat_A  ),
  .en_WriteMat_A (en_WriteMat_A ),
  .rowAddr_A     (rowAddr_A     ),
  .colAddr_A     (colAddr_A     ),
  .en_ReadMat_B  (en_ReadMat_B  ),
  .en_WriteMat_B (en_WriteMat_B ),
  .rowAddr_B     (rowAddr_B     ),
  .colAddr_B     (colAddr_B     ),
  .en_Mux        (en_Mux        ),
  .en_PPReg      (en_PPReg      ),
  .en_FDReg      (en_FDReg      ),
  .en_ReadMat_C  (en_ReadMat_C  ),
  .en_WriteMat_C (en_WriteMat_C ),
  .rowAddr_C     (rowAddr_C     ),
  .colAddr_C     (colAddr_C     )
);

//-------------------------------------------------------------------------- clock generator
always begin
  #(T/2) clk=1'b0;    #(T/2) clk=1'b1;
end

//-------------------------------------------------------------------------- main loop
initial begin
  repeat(5) @(posedge clk)
    reset_n=1'b0;
  repeat(1200) @(posedge clk)
    reset_n=1'b1;
  $finish;
end

//-------------------------------------------------------------------------- vcd output
initial begin
	$dumpfile("control_path.vcd");
	$dumpvars(0,CONTROL_PATH);
end

//-------------------------------------------------------------------------- end of code
endmodule
