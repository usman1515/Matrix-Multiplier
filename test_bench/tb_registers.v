`timescale 1ns/100ps

module tb_registers;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min1='d0,max1='hfffff;
integer count;

  logic   clk;
  logic   reset_n;
  logic   en;
  logic   [DATA_WIDTH*2:0]       inData_A;
  logic   [(DATA_WIDTH*2)-1:0]   inData_B;
  logic   cin;
  logic   [DATA_WIDTH-1:0]       outData_A;
  logic   [(DATA_WIDTH*2)-1:0]   outData_B;
  logic   cout;
  logic   resultIsInvalid;

finaldata_reg #(.DATA_WIDTH (DATA_WIDTH)) FDR(
	.clk             (clk             ),
  .reset_n         (reset_n         ),
  .en_FDReg        (en_FDReg        ),
  .inData          (inData_A        ),
  .outData         (outData_A       ),
  .resultIsInvalid (resultIsInvalid )
);

partialproduct_reg #(.DATA_WIDTH (DATA_WIDTH)) PPR(
	.clk      (clk       ),
  .reset_n  (reset_n   ),
  .en_PPReg (en_PPReg  ),
  .inData   (inData_B  ),
  .cin      (cin       ),
  .outData  (outData_B ),
  .cout     (cout      )
);

always begin
	#(T/2) clk=1'b0;    #(T/2) clk=1'b1;	
end

initial begin
	count=0;
  fork
    repeat(20)  fdr_tests;
    repeat(10)  ppr_tests;
  join
  $finish;
end

task fdr_tests; begin
  @(posedge clk) begin
    reset_n =1'b1; 
    en      =1'b1;
    inData_A =$urandom_range('d200,'d300);
    $write( "Reset= %0b   Enable= %0b   Data_in=%5h   Data_out=%5h   Result_Inv= %0b\n",
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
    $write( "Reset= %0b   Enable= %0b   Data_in=%5h   C_in= %0b   Data_out=%5h   C_out= %0b\n",
            reset_n,en,inData_B,cin,outData_B,cout);
  end
  @(posedge clk) begin
    reset_n =1'b1; 
    en      =1'b0;
    inData_B =$urandom_range(min1,max1);
    cin     =1'b0;
    $write( "Reset= %0b   Enable= %0b   Data_in=%5h   C_in= %0b   Data_out=%5h   C_out= %0b\n",
            reset_n,en,inData_B,cin,outData_B,cout);
  end
end
endtask

endmodule
