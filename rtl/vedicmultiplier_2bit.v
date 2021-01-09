`timescale 1ns/100ps

module vedicmultiplier_2bit(
//-------------------------------------------------------------------------- data and control signals
  input   wire  [1:0] inData_A,
  input   wire  [1:0] inData_B,
  output  wire  [3:0] outData_C
//-------------------------------------------------------------------------- end of I/O
);

wire [3:0] w;

assign outData_C[0] = inData_A[0] & inData_B[0];
assign w[0] = inData_A[1] & inData_B[0];
assign w[1] = inData_A[0] & inData_B[1];
assign w[2] = inData_A[1] & inData_B[1];
assign outData_C[1] = w[0] ^ w[1];
assign w[3] = w[0] & w[1];
assign outData_C[2] = w[2] ^ w[3];
assign outData_C[3] = w[2] & w[3];

endmodule

