`timescale 1ns/100ps

module mux_2x1 #(parameter DATA_WIDTH=8)(
//-------------------------------------------------------------------------- data and control signals
  input		wire  [DATA_WIDTH-1:0] inData_A,
  input		wire  [DATA_WIDTH-1:0] inData_B,
  input		wire  sel,
  output 	reg   [DATA_WIDTH-1:0] outData
//-------------------------------------------------------------------------- end of I/O
);

always@(*) begin
  case(sel)
    1'd0:     outData=inData_A;
    1'd1:     outData=inData_B;
    default:  outData='bz;
  endcase
end

endmodule
