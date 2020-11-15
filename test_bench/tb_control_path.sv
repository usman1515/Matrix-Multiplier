`timescale 1ns/100ps

module tb_control_path;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min='h0,max='hf;
//-------------------------------------------------------------------------- ------------------- global signals
  logic   clk;
  logic   reset_n;
//-------------------------------------------------------------------------- ------------------- matrix A i/o
  logic   en_ReadMat_A;
  logic   en_WriteMat_A;
  logic   [3:0] rowAddr_A;
  logic   [3:0] colAddr_A;
  logic   [DATA_WIDTH-1:0] writeData_A;
  logic   [DATA_WIDTH-1:0] readData_A;
//-------------------------------------------------------------------------- ------------------- matrix B i/o
  logic   en_ReadMat_B;
  logic   en_WriteMat_B;
  logic   [3:0] rowAddr_B;
  logic   [3:0] colAddr_B;
  logic   [DATA_WIDTH-1:0] writeData_B;
  logic   [DATA_WIDTH-1:0] readData_B;
//-------------------------------------------------------------------------- ------------------- data path i/o
  logic   en_Mux;
  logic   en_PPReg;
  logic   en_FDReg;
//-------------------------------------------------------------------------- ------------------- matrix C i/o
  logic   en_ReadMat_C;
  logic   en_WriteMat_C;
  logic   [3:0] rowAddr_C;
  logic   [3:0] colAddr_C;
  logic   [DATA_WIDTH-1:0] writeData_C;
  logic   [DATA_WIDTH-1:0] readData_C;
//-------------------------------------------------------------------------- ------------------- 
control_path CONTROL_PATH(
	.clk           (clk           ),
  .reset_n       (reset_n       ),
  .en_ReadMat_A  (en_ReadMat_A  ),
  .en_WriteMat_A (en_WriteMat_A ),
  .rowAddr_A     (rowAddr_A     ),
  .colAddr_A     (colAddr_A     ),
  .writeData_A   (writeData_A   ),
  .readData_A    (readData_A    ),
  .en_ReadMat_B  (en_ReadMat_B  ),
  .en_WriteMat_B (en_WriteMat_B ),
  .rowAddr_B     (rowAddr_B     ),
  .colAddr_B     (colAddr_B     ),
  .writeData_B   (writeData_B   ),
  .readData_B    (readData_B    ),
  .en_Mux        (en_Mux        ),
  .en_PPReg      (en_PPReg      ),
  .en_FDReg      (en_FDReg      ),
  .en_ReadMat_C  (en_ReadMat_C  ),
  .en_WriteMat_C (en_WriteMat_C ),
  .rowAddr_C     (rowAddr_C     ),
  .colAddr_C     (colAddr_C     ),
  .writeData_C   (writeData_C   ),
  .readData_C    (readData_C    )
);

always begin
  #(T/2) clk=1'b0;    #(T/2) clk=1'b1;
end
initial begin
  repeat(5) @(posedge clk)
    reset_n=1'b0;
  repeat(1200) @(posedge clk)
    reset_n=1'b1;
  $stop;
end

endmodule
