//`include "../rtl/vedicmultiplier_2bit.v"
//`include "../rtl/vedicmultiplier_4bit.v"
`include "../rtl/vedicmultiplier_8bit.v"
`timescale 1ns/100ps

module tb_vedicmultiplier;

localparam min1='h0,max1='hff;
localparam DATA_WIDTH=8;

//-------------------------------------------------------------------------- data and control signals
reg [(DATA_WIDTH/4)-1:0]	inData_1;
reg [(DATA_WIDTH/4)-1:0]	inData_2;
wire [(DATA_WIDTH/2)-1:0]	outData_A;

reg [(DATA_WIDTH/2)-1:0] 	inData_3;
reg [(DATA_WIDTH/2)-1:0]	inData_4;
wire [DATA_WIDTH-1:0] 		outData_B;

reg [DATA_WIDTH-1:0] 			inData_5;
reg [DATA_WIDTH-1:0]			inData_6;
wire [(DATA_WIDTH*2)-1:0]	outData_C;

//-------------------------------------------------------------------------- DUT 1 instantiation
vedicmultiplier_2bit #(.DATA_WIDTH (DATA_WIDTH)) VDM_2bit(
	.inData_A  (inData_1  ),
	.inData_B  (inData_2  ),
	.outData_C (outData_A )
);
//-------------------------------------------------------------------------- DUT 2 instantiation
vedicmultiplier_4bit #(.DATA_WIDTH (DATA_WIDTH)) VDM_4bit(
	.inData_A  (inData_3  ),
	.inData_B  (inData_4  ),
	.outData_C (outData_B )
);
//-------------------------------------------------------------------------- DUT 3 instantiation
vedicmultiplier_8bit #(.DATA_WIDTH (DATA_WIDTH)) VDM_8bit(
	.inData_A  (inData_5  ),
	.inData_B  (inData_6  ),
	.outData_C (outData_C )
);

//-------------------------------------------------------------------------- main loop
initial begin
	$write("-----------------------------------------------------------------\n");
  $write("                 Vedic Multiplier Testbench                         \n");
	$write("-----------------------------------------------------------------\n");
	fork
		repeat(10)  multiply_2bit;
		repeat(10)  multiply_4bit;
		repeat(10)  multiply_8bit;
	join
	$write("\n-----------------------------------------------------------------\n");
	$finish;
end

//-------------------------------------------------------------------------- tasks
task multiply_2bit; begin
	inData_1=$urandom_range(min1,max1);
	inData_2=$urandom_range(min1,max1);
	#1 $write("\nVedic Multiplier 2-bit  Din_1= %3d  Din_2= %3d  D_out= %3d",
								inData_1,inData_2,outData_A);
end
endtask

task multiply_4bit; begin
	inData_3=$urandom_range(min1,max1);
	inData_4=$urandom_range(min1,max1);
	#1 $write("\nVedic Multiplier 4-bit  Din_1= %3d  Din_2= %3d  D_out= %3d",
								inData_3,inData_4,outData_B);
end
endtask

task multiply_8bit; begin
	inData_5=$urandom_range(min1,max1);
	inData_6=$urandom_range(min1,max1);
	#1 $write("\nVedic Multiplier 8-bit  Din_1= %3d  Din_2= %3d  D_out= %3d",
								inData_5,inData_6,outData_C);
end
endtask

//-------------------------------------------------------------------------- vcd output
initial begin
	$dumpfile("vedic_multipliers.vcd");
	$dumpvars(0,VDM_2bit);
	$dumpvars(0,VDM_4bit);
	$dumpvars(0,VDM_8bit);
end

//-------------------------------------------------------------------------- end of code
endmodule
