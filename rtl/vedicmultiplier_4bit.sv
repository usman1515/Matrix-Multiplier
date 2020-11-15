module vedicmultiplier_4bit #(parameter DATA_WIDTH=8)(
  input   logic [(DATA_WIDTH/2)-1:0] inData_A,
  input   logic [(DATA_WIDTH/2)-1:0] inData_B,
  output  logic [DATA_WIDTH-1:0]     outData_C
);

logic [(DATA_WIDTH*2)-1:0] out0;
logic [5:0] out1,out2;
logic [5:0] result1;
logic [5:0] result2;

vedicmultiplier_2bit VD0(inData_A[3:2],inData_B[3:2],out0[15:12]);
vedicmultiplier_2bit VD1(inData_A[1:0],inData_B[3:2],out0[11:8]);
vedicmultiplier_2bit VD2(inData_A[3:2],inData_B[1:0],out0[7:4]);
vedicmultiplier_2bit VD3(inData_A[1:0],inData_B[1:0],out0[3:0]);

assign out1     = {out0[15:12],2'b0};
assign out2     = {2'b0,out0[11:8]};
assign result1  = out1 + out2;
assign result2  = result1 + {2'b0,out0[7:4]}+{4'b0,out0[3:2]};
assign outData_C[7:0] = {result2[5:0],out0[1:0]};

endmodule

