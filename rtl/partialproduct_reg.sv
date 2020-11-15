module partialproduct_reg #(parameter DATA_WIDTH=8)(
  input   logic clk,
  input   logic reset_n,
  input   logic en_PPReg,
  input   logic [(DATA_WIDTH*2)-1:0] inData,
  input   logic cin,
  output  logic [(DATA_WIDTH*2)-1:0] outData,
  output  logic cout
);

always_ff @(posedge clk,negedge reset_n) begin
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