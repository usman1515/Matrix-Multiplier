`include "../rtl/data_path.v"
`include "../rtl/control_path.v"
`timescale 1ns/100ps

module top_matrix_multiplier #(parameter DATA_WIDTH=8)(
//-------------------------------------------------------------------------- global signals
	input   wire  clk,
	input   wire  reset_n,
//-------------------------------------------------------------------------- matrix A
	output  wire  en_ReadMat_A,
	output  wire  en_WriteMat_A,
	output  wire  [3:0] rowAddr_A,
	output  wire  [3:0] colAddr_A,
	output  wire  [DATA_WIDTH-1:0] writeData_A,
	input   wire  [DATA_WIDTH-1:0] readData_A,
//-------------------------------------------------------------------------- matrix B
	output  wire  en_ReadMat_B,
	output  wire  en_WriteMat_B,
	output  wire  [3:0] rowAddr_B,
	output  wire  [3:0] colAddr_B,
	output  wire  [DATA_WIDTH-1:0] writeData_B,
	input   wire  [DATA_WIDTH-1:0] readData_B,
//-------------------------------------------------------------------------- matrix C
	output  wire  en_ReadMat_C,
	output  wire  en_WriteMat_C,
	output  wire  [3:0] rowAddr_C,
	output  wire  [3:0] colAddr_C,
	output  wire  [DATA_WIDTH-1:0] writeData_C,
	//input   wire  [DATA_WIDTH-1:0] readData_C,
	output  wire  resultIsInvalid
//-------------------------------------------------------------------------- end of I/O
);
//-------------------------------------------------------------------------- interconnects
	wire en_Mux;
	wire en_PPReg;
	wire en_FDReg;
//-------------------------------------------------------------------------- data path instantiation
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
//-------------------------------------------------------------------------- control path instantiation
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
//-------------------------------------------------------------------------- end of code
endmodule

