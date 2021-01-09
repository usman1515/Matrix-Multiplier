`include "../rtl/top_matrix_multiplier.v"
`timescale 1ns/100ps

module tb_matrix_multiplier;

//-------------------------------------------------------------------------- constants
localparam DATA_WIDTH=8;
localparam T=2;
localparam CYCLES=12*10*10*T;
localparam min1='h0,max1='h5;
integer i1,j1,k1;
integer i2,j2,k2;

reg	[DATA_WIDTH-1:0] matrix_A [0:9][0:9];
reg	[DATA_WIDTH-1:0] matrix_B [0:9][0:9];
reg	[DATA_WIDTH-1:0] matrix_C [0:9][0:9];

reg [DATA_WIDTH-1:0] val_C;
//-------------------------------------------------------------------------- global signals
reg   clk;
reg   reset_n;
//-------------------------------------------------------------------------- matrix A i/o
wire	en_ReadMat_A;
wire	en_WriteMat_A;
wire	[3:0] rowAddr_A;
wire	[3:0] colAddr_A;
wire	[DATA_WIDTH-1:0] writeData_A;
reg		[DATA_WIDTH-1:0] readData_A;
//-------------------------------------------------------------------------- matrix B i/o
wire	en_ReadMat_B;
wire	en_WriteMat_B;
wire	[3:0] rowAddr_B;
wire	[3:0] colAddr_B;
wire	[DATA_WIDTH-1:0] writeData_B;
reg		[DATA_WIDTH-1:0] readData_B;
//-------------------------------------------------------------------------- matrix C i/o
wire	en_ReadMat_C;
wire	en_WriteMat_C;
wire	[3:0] rowAddr_C;
wire	[3:0] colAddr_C;
wire	[DATA_WIDTH-1:0] writeData_C;
wire	resultIsInvalid;

//-------------------------------------------------------------------------- DUT instantiation
top_matrix_multiplier #(.DATA_WIDTH (DATA_WIDTH)) DUT_MatMultiplier(
	.clk             (clk             ),
	.reset_n         (reset_n         ),
	.en_ReadMat_A    (en_ReadMat_A    ),
	.en_WriteMat_A   (en_WriteMat_A   ),
	.rowAddr_A       (rowAddr_A       ),
	.colAddr_A       (colAddr_A       ),
	.readData_A      (readData_A      ),
	.en_ReadMat_B    (en_ReadMat_B    ),
	.en_WriteMat_B   (en_WriteMat_B   ),
	.rowAddr_B       (rowAddr_B       ),
	.colAddr_B       (colAddr_B       ),
	.readData_B      (readData_B      ),
	.en_ReadMat_C    (en_ReadMat_C    ),
	.en_WriteMat_C   (en_WriteMat_C   ),
	.rowAddr_C       (rowAddr_C       ),
	.colAddr_C       (colAddr_C       ),
	.writeData_C     (writeData_C     ),
	.resultIsInvalid (resultIsInvalid )
);

//-------------------------------------------------------------------------- clock generator
always begin
	#(T/2) clk=1'b0;    #(T/2) clk=1'b1;
end

//-------------------------------------------------------------------------- main loop
initial begin
	fork
		write_matrix_A;
		write_matrix_B;
	join
	fork
		print_matrix_A;
		print_matrix_B;
	join

	repeat(3) @(posedge clk)
		reset_n=1'b0;
	repeat(1) @(posedge clk)
		reset_n=1'b1;
	
	compute_matrix_C;

	repeat(2) @(posedge clk)
		reset_n=1'b0;
	read_matrix_C;
	
	repeat(5) @(posedge clk);
	$finish;
end

//-------------------------------------------------------------------------- tasks
task compute_matrix_C;
	repeat(CYCLES) @(posedge clk) begin
		readData_A=matrix_A [rowAddr_A][colAddr_A];
		readData_B=matrix_B [rowAddr_B][colAddr_B];
		matrix_C [rowAddr_A][colAddr_B]=writeData_C;
	end
endtask

task read_matrix_C; begin
	$write("-------------------------- Reading matrix C --------------------------\n");
	$write("----------------------------------------------------------------------\n");
	for(i1=0;i1<10;i1=i1+1) begin
		for(j1=0;j1<10;j1=j1+1) begin
			val_C= matrix_C [i1][j1];
		#1 $write("[%0d,%0d]=%4d ",i1,j1,val_C);
		end
		$write("\n");
	end
	$write("----------------------------------------------------------------------\n");
end
endtask

task print_matrix_A; begin
	$write("-------------------------- Reading matrix A --------------------------\n");
	$write("----------------------------------------------------------------------\n");

	for(i1=0;i1<10;i1=i1+1) begin
		$write("[ ");
		for(j1=0;j1<10;j1=j1+1)
			$write("%d, ",matrix_A[i1][j1]);
		$write("]; \n");
	end
	$write("----------------------------------------------------------------------\n");
end
endtask

task print_matrix_B; begin
	$write("-------------------------- Reading matrix B --------------------------\n");
	$write("----------------------------------------------------------------------\n");
	for(i2=0;i2<10;i2=i2+1) begin
		$write("[ ");
		for(j2=0;j2<10;j2=j2+1)
			$write("%d, ",matrix_B[i2][j2]);
		$write("]; \n");
	end
	$write("----------------------------------------------------------------------\n");
end
endtask

task write_matrix_A; begin
	for(i1=0;i1<10;i1=i1+1) begin
		for(j1=0;j1<10;j1=j1+1) begin
			matrix_A[i1][j1]=min1+{$random}%(max1-min1);
		//#1 $write("[%0d,%0d]=%0d ",i1,j1,matrix_A[i1][j1]);
		end
		//$write("\n");
	end
end
endtask

task write_matrix_B; begin
	for(i2=0;i2<10;i2=i2+1) begin
		for(j2=0;j2<10;j2=j2+1) begin
			matrix_B[i2][j2]=min1+{$random}%(max1-min1);
		//#1 $write("[%0d,%0d]=%0d ",i2,j2,matrix_B[i2][j2]);
		end
		//$write("\n");
	end
end
endtask

initial begin
	$dumpfile("top_matrix_multiplier.vcd");
	$dumpvars(0,DUT_MatMultiplier);
end
//-------------------------------------------------------------------------- end of code
endmodule
