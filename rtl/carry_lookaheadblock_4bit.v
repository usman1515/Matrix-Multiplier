`timescale 1ns/100ps

module carry_lookaheadblock_4bit(
//-------------------------------------------------------------------------- data and control signals
  input   wire  cin,
  input   wire  [3:0] p,g,
  output  wire  [3:0] c,
  output  wire  cout
//-------------------------------------------------------------------------- end of I/O
);

assign c[0]=cin;
assign c[1]=g[0] | c[0]&p[0];
assign c[2]=g[1] | p[1]&g[0] | p[1]&p[0]&c[0];
assign c[3]=g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout=g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];

endmodule
