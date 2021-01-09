`include "../rtl/vedicmultiplier_4bit.v"
`timescale 1ns/100ps

module vedicmultiplier_8bit #(parameter DATA_WIDTH=8)(
//-------------------------------------------------------------------------- data and control signals
  input   wire  [DATA_WIDTH-1:0]     inData_A,
  input   wire  [DATA_WIDTH-1:0]     inData_B,
  output  wire  [(DATA_WIDTH*2)-1:0] outData_C
//-------------------------------------------------------------------------- end of I/O
);

wire [(DATA_WIDTH*4)-1:0] out0;
wire [11:0] out1,out2;
wire [11:0] result1,result2;

vedicmultiplier_4bit VD0(inData_A[7:4],inData_B[7:4],out0[31:24]);
vedicmultiplier_4bit VD1(inData_A[3:0],inData_B[7:4],out0[23:16]);
vedicmultiplier_4bit VD2(inData_A[7:4],inData_B[3:0],out0[15:8]);
vedicmultiplier_4bit VD3(inData_A[3:0],inData_B[3:0],out0[7:0]);

assign out1={out0[31:24],4'b0};
assign out2={4'b0,out0[23:16]};
assign result1=out1+out2;
assign result2=result1+{4'b0,out0[15:8]}+{8'b0,out0[7:4]};
assign outData_C[15:0]={result2[11:0],out0[3:0]};

endmodule
