module matrix_10x10 #(parameter DATA_WIDTH=8)(
  input   logic clk,
  input   logic en_ReadMat,
  input   logic en_WriteMat,
  input   logic [3:0] rowAddr,
  input   logic [3:0] colAddr,
  input   logic [DATA_WIDTH-1:0] writeData,
  output  logic [DATA_WIDTH-1:0] readData
);

logic [DATA_WIDTH-1:0] matrix_MemBlock [0:9][0:9];

always_ff @(posedge clk) begin
  if(~en_ReadMat && en_WriteMat) begin           //write data
    if(rowAddr<10 && colAddr<10)
      matrix_MemBlock[rowAddr][colAddr] <= writeData;
  end
end

always_ff @(posedge clk) begin
  if(en_ReadMat && ~en_WriteMat) begin           //read data
    if(rowAddr<10 && colAddr<10)
      readData <= matrix_MemBlock[rowAddr][colAddr];
    end
end

endmodule
