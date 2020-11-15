module finaldata_reg #(parameter DATA_WIDTH=8)(
	input		logic	clk,
	input		logic	reset_n,
	input		logic	en_FDReg,
	input		logic	[DATA_WIDTH*2:0] inData,
	output 	logic [DATA_WIDTH-1:0] outData,
	output 	logic resultIsInvalid
);

always_ff @(posedge clk,negedge reset_n) begin
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