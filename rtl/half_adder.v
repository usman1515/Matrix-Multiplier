`timescale 1ns/100ps

module half_adder(
//-------------------------------------------------------------------------- data and control signals
  input   wire  a,
  input   wire  b,
  output  wire  sum,
  output  wire  cout
//-------------------------------------------------------------------------- end of I/O
);

assign sum=a^b;
assign cout=a&b;

endmodule

