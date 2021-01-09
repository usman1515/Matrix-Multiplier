`timescale 1ns/100ps

module finaldata_reg #(parameter DATA_WIDTH=8)(
//-------------------------------------------------------------------------- global signals
	input		wire	clk,
	input		wire	reset_n,
//-------------------------------------------------------------------------- data and control signals
	input		wire	en_FDReg,
	input		wire	[DATA_WIDTH*2:0] inData,
	output	reg		[DATA_WIDTH-1:0] outData,
	output	reg		resultIsInvalid
//-------------------------------------------------------------------------- end of I/O
);

always @(posedge clk,negedge reset_n) begin
	if(reset_n) begin
		if(en_FDReg) begin
			resultIsInvalid=(inData>8'hff)? 1:0;
			outData=(inData<8'hff)? inData[DATA_WIDTH-1:0]:8'bz;
		end
	end
	else begin
		outData=8'dz;
		resultIsInvalid=1'bz;
	end
end

endmodule 