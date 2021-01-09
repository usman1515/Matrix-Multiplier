`timescale 1ns/100ps

module partialproduct_reg #(parameter DATA_WIDTH=8)(
//-------------------------------------------------------------------------- global signals
  input   wire  clk,
  input   wire  reset_n,
//-------------------------------------------------------------------------- data and control signals
  input   wire  en_PPReg,
  input   wire  [(DATA_WIDTH*2)-1:0] inData,
  input   wire  cin,
  output  reg   [(DATA_WIDTH*2)-1:0] outData,
  output  reg   cout
//-------------------------------------------------------------------------- end of I/O
);

always @(posedge clk,negedge reset_n) begin
	if(reset_n) begin
		if(en_PPReg==1'b1) begin
      outData<=inData;
      cout<=cin;
    end
	end
	else begin //if(en_PPReg==1'bx || reset_n==1'bx)
    outData<='bz;
    cout<='bz;
  end 
end

endmodule 