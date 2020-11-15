module vedicmultiplier_2bit(
  input   logic [1:0] inData_A,
  input   logic [1:0] inData_B,
  output  logic [3:0] outData_C
);

logic [3:0] w;

assign outData_C[0] = inData_A[0] & inData_B[0];
assign w[0] = inData_A[1] & inData_B[0];
assign w[1] = inData_A[0] & inData_B[1];
assign w[2] = inData_A[1] & inData_B[1];

half_adder HA0(w[0],w[1],outData_C[1],w[3]);
half_adder HA1(w[2],w[3],outData_C[2],outData_C[3]);

endmodule

