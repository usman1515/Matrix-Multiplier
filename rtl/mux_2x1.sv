module mux_2x1 #(parameter DATA_WIDTH=8)(
  input		logic	[DATA_WIDTH-1:0] inData_A,
  input		logic	[DATA_WIDTH-1:0] inData_B,
  input		logic	sel,
  output 	logic [DATA_WIDTH-1:0] outData
);

always_comb begin
  case(sel)
    1'd0:     outData=inData_A;
    1'd1:     outData=inData_B;
    default:  outData='bz;
  endcase
end

endmodule
