`timescale 1ns/100ps

module tb_datapath;

localparam DATA_WIDTH=8;
localparam T=2;
localparam min='h0,max='ha;

logic   clk;
logic   reset_n;
logic   [DATA_WIDTH-1:0] readData_A;
logic   [DATA_WIDTH-1:0] readData_B;
logic   en_Mux;
logic   en_PPReg;
logic   en_FDReg;
logic   [DATA_WIDTH-1:0] writeData;
logic   resultIsInvalid;

data_path #(.DATA_WIDTH (DATA_WIDTH)) DATA_PATH(
  .clk             (clk             ),
  .reset_n         (reset_n         ),
  .readData_A      (readData_A      ),
  .readData_B      (readData_B      ),
  .en_Mux          (en_Mux          ),
  .en_PPReg        (en_PPReg        ),
  .en_FDReg        (en_FDReg        ),
  .writeData_C     (writeData       ),
  .resultIsInvalid (resultIsInvalid )
);


always begin
    #(T/2) clk=1'b0;    #(T/2) clk=1'b1;
end
initial begin
  @(posedge clk)
    reset_n=1'b0;
  @(posedge clk) begin
    reset_n=1'b1;
    en_PPReg=1'b0;
    en_FDReg=1'b0;
  end
  repeat(3) multiply;
  $stop;
end

task multiply;  
  @(posedge clk) begin
    readData_A=$urandom_range(min,max);
    readData_B=$urandom_range(min,max);
    en_Mux=1'b0;
    en_PPReg=1'b1;
    en_FDReg=1'b0;
    $$display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                readData_A,readData_B,en_Mux,en_PPReg,en_FDReg);
  end
  repeat(8) @(posedge clk) begin
    readData_A=$urandom_range(min,max);
    readData_B=$urandom_range(min,max);
    en_Mux=1'b1;
    en_PPReg=1'b1;
    en_FDReg=1'b0;
    $$display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                readData_A,readData_B,en_Mux,en_PPReg,en_FDReg);
  end
  @(posedge clk) begin
    readData_A=$urandom_range(min,max);
    readData_B=$urandom_range(min,max);
    en_Mux=1'b1;
    en_PPReg=1'b1;
    en_FDReg=1'b1;
    $$display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                readData_A,readData_B,en_Mux,en_PPReg,en_FDReg);
  end
  @(posedge clk) begin
    en_Mux=1'b0;
    en_PPReg=1'b0;
    en_FDReg=1'b0;
    $$display("Num_1= %3d  Num_2= %3d  en_Mux= %1b  en_PPReg= %1b  en_FDReg= %1b",
                readData_A,readData_B,en_Mux,en_PPReg,en_FDReg);
  end
endtask

endmodule
