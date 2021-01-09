`include "../rtl/finaldata_reg.v"
`include "../rtl/partialproduct_reg.v"
`timescale 1ns/100ps

module tb_registers;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min1='d0,max1='hfffff;
integer count;
//-------------------------------------------------------------------------- global signals
  reg   clk;
  reg   reset_n;
  reg   en;
  reg   [DATA_WIDTH*2:0]       inData_A;
  reg   [(DATA_WIDTH*2)-1:0]   inData_B;
  reg   cin;
  wire  [DATA_WIDTH-1:0]       outData_A;
  wire  [(DATA_WIDTH*2)-1:0]   outData_B;
  wire  cout;
  wire  resultIsInvalid;

//-------------------------------------------------------------------------- DUT 1 instantiation
finaldata_reg #(.DATA_WIDTH (DATA_WIDTH)) FDR(
	.clk             (clk             ),
  .reset_n         (reset_n         ),
  .en_FDReg        (en              ),
  .inData          (inData_A        ),
  .outData         (outData_A       ),
  .resultIsInvalid (resultIsInvalid )
);
//-------------------------------------------------------------------------- DUT 2 instantiation
partialproduct_reg #(.DATA_WIDTH (DATA_WIDTH)) PPR(
	.clk      (clk       ),
  .reset_n  (reset_n   ),
  .en_PPReg (en        ),
  .inData   (inData_B  ),
  .cin      (cin       ),
  .outData  (outData_B ),
  .cout     (cout      )
);

//-------------------------------------------------------------------------- clock generator
always begin
	#(T/2) clk=1'b0;    #(T/2) clk=1'b1;	
end

//-------------------------------------------------------------------------- main loop
initial begin
	$write("-----------------------------------------------------------------\n");
  $write("                     Register Testbench                         \n");
	$write("-----------------------------------------------------------------\n");
  repeat(20)  fdr_tests;
  $write("-----------------------------------------------------------------\n");
  repeat(10)  ppr_tests;
	$write("-----------------------------------------------------------------\n");
  $finish;
end

//-------------------------------------------------------------------------- tasks
task fdr_tests; begin
  @(posedge clk) begin
    reset_n =1'b1; 
    en      =1'b1;
    inData_A =$urandom_range('d200,'d300);
    #1 $write( "Reset= %0b   Enable= %0b   Data_in=%5d   Data_out=%5d   Result_Inv= %0b\n",
            reset_n,en,inData_A,outData_A,resultIsInvalid);
  end
end
endtask

task ppr_tests; begin
  @(posedge clk) begin
    reset_n =1'b1; 
    en      =1'b0;
    inData_B =$urandom_range(min1,max1);
    cin     =1'b0;
    #1 $write( "Reset= %0b   Enable= %0b   Data_in=%5h   C_in= %0b   Data_out=%5h   C_out= %0b\n",
            reset_n,en,inData_B,cin,outData_B,cout);
  end
  @(posedge clk) begin
    reset_n =1'b1; 
    en      =1'b1;
    inData_B =$urandom_range(min1,max1);
    cin     =1'b0;
    #1 $write( "Reset= %0b   Enable= %0b   Data_in=%5h   C_in= %0b   Data_out=%5h   C_out= %0b\n",
            reset_n,en,inData_B,cin,outData_B,cout);
  end
end
endtask

//-------------------------------------------------------------------------- vcd output
initial begin
	$dumpfile("registers.vcd");
	$dumpvars(0,FDR);
  $dumpvars(0,PPR);
end

//-------------------------------------------------------------------------- end of code
endmodule
