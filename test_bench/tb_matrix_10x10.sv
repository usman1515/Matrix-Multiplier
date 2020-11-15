`timescale 1ns/100ps

module tb_matrix_10x10;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min1='h0,max1='hff;
integer i,j,k;

logic   clk;
logic   en_ReadMat,en_WriteMat;
logic   [3:0] rowAddr,colAddr;
logic   [DATA_WIDTH-1:0] writeData;
logic   [DATA_WIDTH-1:0] readData;

matrix_10x10 #(.DATA_WIDTH (DATA_WIDTH)) MATRIX(
  .clk         (clk         ),
  .en_ReadMat  (en_ReadMat  ),
  .en_WriteMat (en_WriteMat ),
  .rowAddr     (rowAddr     ),
  .colAddr     (colAddr     ),
  .writeData   (writeData   ),
  .readData    (readData    )
);

//--------------------------------------------------------------------------  clock generator
always begin
  #(T/2) clk=1'b1;    #(T/2) clk=1'b0;
end
//--------------------------------------------------------------------------  main loop
initial begin

  repeat(1)   write_matrix();
  repeat(1)   write_entry(3,3,'d100);
  repeat(1)   read_matrix();
  repeat(1)   read_entry(4,5);
  repeat(1)   clear_matrix();
  repeat(1)   read_matrix();

  $stop;
end

//--------------------------------------------------------------------------  tasks
task write_entry(input logic [3:0] row, input logic [3:0] col, input logic [DATA_WIDTH-1:0] value); begin
  @(posedge clk) begin
    en_ReadMat=1'b0;
    en_WriteMat=1'b1;
    rowAddr=row;
    colAddr=col;
    writeData=value;
  end
  #1 $display("\t Write at entry [%0d,%0d] Data=%4d",rowAddr,colAddr,writeData);
end
endtask

task read_entry(input logic [3:0] row, input logic [3:0] col); begin
  @(posedge clk) begin
    en_ReadMat=1'b1;
    en_WriteMat=1'b0;
    rowAddr=row;
    colAddr=col;
  end
  #1 $display("\t Read at entry [%0d,%0d] Data=%4d",rowAddr,colAddr,readData);
end
endtask

task write_matrix; begin
  $write("---------------------------------- Writing data to whole matrix ----------------------------------\n");
  for(i=0;i<10;i=i+1) begin
    for(j=0;j<10;j=j+1) begin
      @(posedge clk) begin
        en_ReadMat=1'b0;
        en_WriteMat=1'b1;
        rowAddr=i;
        colAddr=j;
        writeData=$urandom_range(min1,max1);
      end
      #1 $write("[%0d,%0d]=%4d\t",rowAddr,colAddr,writeData);
    end
    $write("\n");
  end
  $write("--------------------------------------------------------------------------------------------------\n");
end
endtask

task read_matrix; begin
  $write("---------------------------------- Reading data from whole matrix ----------------------------------\n");
  for(i=0;i<10;i=i+1) begin
    for(j=0;j<10;j=j+1) begin
      @(posedge clk) begin
        en_ReadMat=1'b1;
        en_WriteMat=1'b0;
        rowAddr=i;
        colAddr=j;
      end
      #1 $write("[%0d,%0d]=%4d\t",rowAddr,colAddr,readData);
    end
    $write("\n");
  end
  $write("----------------------------------------------------------------------------------------------------\n");
end
endtask

task clear_matrix; begin
  $write("---------------------------------- Clearing whole matrix ----------------------------------\n");
  for(i=0;i<10;i=i+1) begin
    for(j=0;j<10;j=j+1) begin
      @(posedge clk) begin
        en_ReadMat=1'b0;
        en_WriteMat=1'b1;
        rowAddr=i;
        colAddr=j;
        writeData='bz;
      end
      #1 $write("[%0d,%0d]=%4d\t",rowAddr,colAddr,writeData);
    end
    $write("\n");
  end
  $write("-------------------------------------------------------------------------------------------\n");
end
endtask

endmodule