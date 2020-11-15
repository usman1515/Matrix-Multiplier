module carry_lookaheadadder_16bit #(parameter DATA_WIDTH=8)(
  input   logic   [(DATA_WIDTH*2)-1:0] inData_A,
  input   logic   [(DATA_WIDTH*2)-1:0] inData_B,     
  input   logic   cin,                                
  output  logic   [(DATA_WIDTH*2)-1:0] outData,       
  output  logic   cout                                
);

logic [(DATA_WIDTH*2)-1:0] p,g,c;
logic c1,c2,c3;

half_adder  ha0  (inData_A[0],inData_B[0],p[0],g[0]);
half_adder  ha1  (inData_A[1],inData_B[1],p[1],g[1]);
half_adder  ha2  (inData_A[2],inData_B[2],p[2],g[2]);
half_adder  ha3  (inData_A[3],inData_B[3],p[3],g[3]);
half_adder  ha4  (inData_A[4],inData_B[4],p[4],g[4]);
half_adder  ha5  (inData_A[5],inData_B[5],p[5],g[5]);
half_adder  ha6  (inData_A[6],inData_B[6],p[6],g[6]);
half_adder  ha7  (inData_A[7],inData_B[7],p[7],g[7]);
half_adder  ha8  (inData_A[8],inData_B[8],p[8],g[8]);
half_adder  ha9  (inData_A[9],inData_B[9],p[9],g[9]);
half_adder  ha10 (inData_A[10],inData_B[10],p[10],g[10]);
half_adder  ha11 (inData_A[11],inData_B[11],p[11],g[11]);
half_adder  ha12 (inData_A[12],inData_B[12],p[12],g[12]);
half_adder  ha13 (inData_A[13],inData_B[13],p[13],g[13]);
half_adder  ha14 (inData_A[14],inData_B[14],p[14],g[14]);
half_adder  ha15 (inData_A[15],inData_B[15],p[15],g[15]);

carry_lookaheadblock_4bit clab0(cin,p[3:0],g[3:0],c[3:0],c1);
carry_lookaheadblock_4bit clab1(c1,p[7:4],g[7:4],c[7:4],c2);
carry_lookaheadblock_4bit clab2(c2,p[11:8],g[11:8],c[11:8],c3);
carry_lookaheadblock_4bit clab3(c3,p[15:12],g[15:12],c[15:12],cout);

assign outData[15:0]=p[15:0] ^ c[15:0];

endmodule
