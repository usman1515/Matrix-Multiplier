`include "../rtl/data_path.v"
`timescale 1ns/100ps

module tb_datapath;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min='h0,max='ha;

//-------------------------------------------------------------------------- global signals
reg   clk;
reg   reset_n;
//-------------------------------------------------------------------------- data and control signals
reg   [DATA_WIDTH-1:0] inData_A;
reg   [DATA_WIDTH-1:0] inData_B;
reg   en_Mux;
reg   en_PPReg;
reg   en_FDReg;
wire  [DATA_WIDTH-1:0] outData;
wire  resultIsInvalid;

//-------------------------------------------------------------------------- DUT instantiation
data_path #(.DATA_WIDTH (DATA_WIDTH)) DATA_PATH(
  .clk             (clk             ),
  .reset_n         (reset_n         ),
  .inData_A        (inData_A        ),
  .inData_B        (inData_B        ),
  .en_Mux          (en_Mux          ),
  .en_PPReg        (en_PPReg        ),
  .en_FDReg        (en_FDReg        ),
  .outData         (outData         ),
  .resultIsInvalid (resultIsInvalid )
);

//-------------------------------------------------------------------------- clock generator
always begin
    #(T/2) clk=1'b0;    #(T/2) clk=1'b1;
end

//-------------------------------------------------------------------------- main loop
initial begin
	$write("-----------------------------------------------------------------\n");
  $write("                     Data Path Testbench                         \n");
	$write("-----------------------------------------------------------------\n");
  @(posedge clk)
    reset_n=1'b0;
  @(posedge clk) begin
    reset_n=1'b1;
    en_PPReg=1'b0;
    en_FDReg=1'b0;
  end
  repeat(3) multiply;
	$write("-----------------------------------------------------------------\n");
  $finish;
end

//-------------------------------------------------------------------------- tasks
task multiply; begin  
  @(posedge clk) begin
    inData_A=$urandom_range(min,max);
    inData_B=$urandom_range(min,max);
    en_Mux=1'b0;
    en_PPReg=1'b1;
    en_FDReg=1'b0;
    $display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                inData_A,inData_B,en_Mux,en_PPReg,en_FDReg);
  end
  repeat(8) @(posedge clk) begin
    inData_A=$urandom_range(min,max);
    inData_B=$urandom_range(min,max);
    en_Mux=1'b1;
    en_PPReg=1'b1;
    en_FDReg=1'b0;
    $display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                inData_A,inData_B,en_Mux,en_PPReg,en_FDReg);
  end
  @(posedge clk) begin
    inData_A=$urandom_range(min,max);
    inData_B=$urandom_range(min,max);
    en_Mux=1'b1;
    en_PPReg=1'b1;
    en_FDReg=1'b1;
    $display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                inData_A,inData_B,en_Mux,en_PPReg,en_FDReg);
  end
  @(posedge clk) begin
    en_Mux=1'b0;
    en_PPReg=1'b0;
    en_FDReg=1'b0;
    $display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                inData_A,inData_B,en_Mux,en_PPReg,en_FDReg);
  end
end
endtask

//-------------------------------------------------------------------------- vcd output
initial begin
	$dumpfile("data_path.vcd");
	$dumpvars(0,DATA_PATH);
end

//-------------------------------------------------------------------------- end of code
endmodule
