module data_path #(parameter DATA_WIDTH=8)(
  input		logic	clk,
  input		logic	reset_n,
  input		logic	[DATA_WIDTH-1:0] inData_A,
  input		logic	[DATA_WIDTH-1:0] inData_B,
  input		logic	en_Mux,
  input		logic	en_PPReg,
  input		logic	en_FDReg,
  output 	logic	[DATA_WIDTH-1:0] outData,
  output 	logic	resultIsInvalid
);

logic	[(DATA_WIDTH*2)-1:0]	outData_vdm;
logic	[(DATA_WIDTH*2)-1:0]	outData_ppreg;
logic	[(DATA_WIDTH*2)-1:0]	outData_muxsum;
logic	                     	cout_ppreg;
logic	                     	outData_muxcout;
logic	[(DATA_WIDTH*2)-1:0]	outData_claa_sum;
logic	                     	outData_claa_cout;
logic	[(DATA_WIDTH*2):0]  	inData_fdreg;

vedicmultiplier_8bit #(.DATA_WIDTH (DATA_WIDTH)) VDM0(
	.inData_A  (inData_A    ),
  .inData_B  (inData_B    ),
  .outData_C (outData_vdm )
);

mux_2x1 #(.DATA_WIDTH(16)) PPSUM_MUX(
	.inData_A (16'h0            ),
  .inData_B (outData_ppreg    ),
  .sel      (en_Mux           ),
  .outData  (outData_muxsum   )
);
mux_2x1 #(.DATA_WIDTH(1)) PPCOUT_MUX(
	.inData_A (1'h0             ),
  .inData_B (cout_ppreg       ),
  .sel      (en_Mux           ),
  .outData  (outData_muxcout  )
);
carry_lookaheadadder_16bit #(.DATA_WIDTH (DATA_WIDTH)) CLAA0(
	.inData_A (outData_vdm          ),
  .inData_B (outData_muxsum       ),
  .cin      (outData_muxcout      ),
  .outData  (outData_claa_sum     ),
  .cout     (outData_claa_cout    )
);
partialproduct_reg #(.DATA_WIDTH (DATA_WIDTH)) PP_REG(
	.clk      (clk                  ),
  .reset_n  (reset_n              ),
  .en_PPReg (en_PPReg             ),
  .inData   (outData_claa_sum     ),
  .cin      (outData_claa_cout    ),
  .outData  (outData_ppreg        ),
  .cout     (cout_ppreg           )
);
assign inData_fdreg={outData_claa_cout,outData_claa_sum};

finaldata_reg #(.DATA_WIDTH (DATA_WIDTH)) FD_REG(
	.clk             (clk             ),
  .reset_n         (reset_n         ),
  .en_FDReg        (en_FDReg        ),
  .inData          (inData_fdreg    ),
  .outData         (outData     		),
  .resultIsInvalid (resultIsInvalid )
);

endmodule