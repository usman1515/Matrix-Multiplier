module matrix_multiplier #(parameter DATA_WIDTH=8)(
//--------------------------------------------------------------------------global signals
  input   logic clk,
  input   logic reset_n,
//--------------------------------------------------------------------------matrix A
  output  logic en_ReadMat_A,
  output  logic en_WriteMat_A,
  output  logic [3:0] rowAddr_A,
  output  logic [3:0] colAddr_A,
  output  logic [DATA_WIDTH-1:0] writeData_A,
  input   logic [DATA_WIDTH-1:0] readData_A,
//--------------------------------------------------------------------------matrix B
  output  logic en_ReadMat_B,
  output  logic en_WriteMat_B,
  output  logic [3:0] rowAddr_B,
  output  logic [3:0] colAddr_B,
  output  logic [DATA_WIDTH-1:0] writeData_B,
  input   logic [DATA_WIDTH-1:0] readData_B,
//--------------------------------------------------------------------------matrix C
  output  logic en_ReadMat_C,
  output  logic en_WriteMat_C,
  output  logic [3:0] rowAddr_C,
  output  logic [3:0] colAddr_C,
  output  logic [DATA_WIDTH-1:0] writeData_C,
  //input   logic [DATA_WIDTH-1:0] readData_C,
  output  logic resultIsInvalid
//--------------------------------------------------------------------------end of I/O
);
//--------------------------------------------------------------------------interconnects
  logic en_Mux;
  logic en_PPReg;
  logic en_FDReg;
//--------------------------------------------------------------------------data path instantiation
data_path #(.DATA_WIDTH (DATA_WIDTH)) DATA_PATH(
	.clk             (clk             ),
  .reset_n         (reset_n         ),
  .inData_A        (readData_A      ),
  .inData_B        (readData_B      ),
  .en_Mux          (en_Mux          ),
  .en_PPReg        (en_PPReg        ),
  .en_FDReg        (en_FDReg        ),
  .outData         (writeData_C     ),
  .resultIsInvalid (resultIsInvalid )
);
//--------------------------------------------------------------------------control path instantiation
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
//--------------------------------------------------------------------------end of code
endmodule

