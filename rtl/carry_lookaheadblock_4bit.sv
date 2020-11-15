module carry_lookaheadblock_4bit(
  input   logic   cin,
  input   logic   [3:0] p,g,
  output  logic   [3:0] c,
  output  logic   cout
);

always_comb begin
  c[0]=cin;
  c[1]=g[0] | c[0]&p[0];
  c[2]=g[1] | p[1]&g[0] | p[1]&p[0]&c[0];
  c[3]=g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
  cout=g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
end

endmodule
