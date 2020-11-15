`timescale 1ns/100ps

module tb_carrylookahead_adder;

localparam DATA_WIDTH=8;
localparam min0='h0,max0='hffff;

  logic	[(DATA_WIDTH*2)-1:0] inData_A;
  logic	[(DATA_WIDTH*2)-1:0] inData_B;
  logic	cin;
  logic	[(DATA_WIDTH*2)-1:0] outData; 
  logic	cout;

carry_lookaheadadder_16bit CLAA(
	.inData_A (inData_A ),
	.inData_B (inData_B ),
	.cin      (cin      ),
	.outData  (outData  ),
	.cout     (cout     )
);

initial begin
  $write("\n          Carry Look Ahead Adder 16-bit Testbench              \n");
	$write("-----------------------------------------------------------------\n");
	repeat(10) begin
		inData_A=$urandom_range(min0,max0);
		inData_B=$urandom_range(min0,max0);
		cin=1'b0;
		#1;
		$display( "Din_1= %5d   Din_2= %5d   D_out= %5d   Cout=%1b",inData_A,inData_B,outData,cout);
	end
	$write("-----------------------------------------------------------------\n");
	$stop;
end

endmodule
