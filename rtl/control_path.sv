module control_path(
//--------------------------------------------------------------------------global signals
  input   logic   clk,
  input   logic   reset_n,
//--------------------------------------------------------------------------matrix A i/o
  output  logic   en_ReadMat_A,
  output  logic   en_WriteMat_A,
  output  logic   [3:0] rowAddr_A,
  output  logic   [3:0] colAddr_A,
  //output  logic   [DATA_WIDTH-1:0] writeData_A,
  //input   logic   [DATA_WIDTH-1:0] readData_A,
//--------------------------------------------------------------------------matrix B i/o
  output  logic   en_ReadMat_B,
  output  logic   en_WriteMat_B,
  output  logic   [3:0] rowAddr_B,
  output  logic   [3:0] colAddr_B,
  //output  logic   [DATA_WIDTH-1:0] writeData_B,
  //input   logic   [DATA_WIDTH-1:0] readData_B,
//--------------------------------------------------------------------------data path i/o
  output  logic   en_Mux,
  output  logic   en_PPReg,
  output  logic   en_FDReg,
//--------------------------------------------------------------------------matrix C i/o
  output  logic   en_ReadMat_C,
  output  logic   en_WriteMat_C,
  output  logic   [3:0] rowAddr_C,
  output  logic   [3:0] colAddr_C
  //output  logic   [DATA_WIDTH-1:0] writeData_C
  //input   logic   [DATA_WIDTH-1:0] readData_C
//--------------------------------------------------------------------------end of I/O
);
//--------------------------------------------------------------------------state parameters
  localparam S_IDLE=3'd0;
  localparam STATE_1=3'd1;
  localparam STATE_2=3'd2;
  localparam STATE_3=3'd3;
  localparam STATE_4=3'd4;
  localparam S_FINISH=3'd5;

  logic   [3:0]   state;
//--------------------------------------------------------------------------address counter registers
  logic   [3:0]   counterI,counterJ,counterK;
//--------------------------------------------------------------------------finite state machine (FSM)
always_ff @(posedge clk,negedge reset_n) begin
  if(reset_n) begin
    case(state)
      S_IDLE: begin
        if(counterK==0)
          state=STATE_1;                
      end
      STATE_1: begin
        if(counterK==1)
          state=STATE_2;
        else
          state=STATE_1; 
      end
      STATE_2: begin
        if(counterK==9)
          state=STATE_3;
        else
          state=STATE_2;
      end
      STATE_3: begin
        if(counterK==10)
          state=STATE_4;
        else
          state=STATE_3;
      end
      STATE_4: begin
        if(counterI==9 && counterJ==9 && counterK==10)
          state=S_FINISH;
        else
          state=STATE_1;
      end
      S_FINISH: begin
        state=S_FINISH;
      end
      default:
        state=S_IDLE;
    endcase
  end
  else
    state=S_IDLE;
end
//--------------------------------------------------------------------------address counter
always_ff @(posedge clk,negedge reset_n) begin
  if(reset_n) begin
    if(en_PPReg==1'b1) begin
      counterK=counterK+1'b1;
			if(counterK==12) begin
        counterK=4'd0;
        counterJ=counterJ+1'b1;
      end
      if(counterJ==10) begin
        counterJ=4'd0;
        counterI=counterI+1'b1;
      end
      if(counterI==10) begin
        counterI=4'd0;
      end
    end
	else;
  end
  else begin
    counterI=4'd0;
    counterJ=4'd0;
    counterK=4'd0;
  end
end
//--------------------------------------------------------------------------current state output
always_comb begin
  case(state)
    S_IDLE: begin
      en_ReadMat_A=1'b0;
      en_WriteMat_A=1'b0;
      rowAddr_A=1'b0;
      colAddr_A=1'b0;
      en_ReadMat_B=1'b0;
      en_WriteMat_B=1'b0;
      rowAddr_B=1'b0;
      colAddr_B=1'b0;
      en_Mux=1'b0;
      en_PPReg=1'b0;
      en_FDReg=1'b0;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b0;
      rowAddr_C=1'b0;
      colAddr_C=1'b0;
    end
    STATE_1: begin
      en_ReadMat_A=1'b1;
      en_WriteMat_A=1'b0;
      rowAddr_A=counterI;
      colAddr_A=counterK;
      en_ReadMat_B=1'b1;
      en_WriteMat_B=1'b0;
      rowAddr_B=counterK;
      colAddr_B=counterJ;
      en_Mux=1'b0;
      en_PPReg=1'b1;
      en_FDReg=1'b0;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b0;
      rowAddr_C=counterI;
      colAddr_C=counterJ;
      end
    STATE_2: begin
      en_ReadMat_A=1'b1;
      en_WriteMat_A=1'b0;
      rowAddr_A=counterI;
      colAddr_A=counterK;
      en_ReadMat_B=1'b1;
      en_WriteMat_B=1'b0;
      rowAddr_B=counterK;
      colAddr_B=counterJ;
      en_Mux=1'b1;
      en_PPReg=1'b1;
      en_FDReg=1'b0;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b0;
      rowAddr_C=counterI;
      colAddr_C=counterJ;
    end
    STATE_3: begin
      en_ReadMat_A=1'b1;
      en_WriteMat_A=1'b0;
      rowAddr_A=counterI;
      colAddr_A=counterK;
      en_ReadMat_B=1'b1;
      en_WriteMat_B=1'b0;
      rowAddr_B=counterK;
      colAddr_B=counterJ;
      en_Mux=1'b1;
      en_PPReg=1'b1;
      en_FDReg=1'b1;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b0;
      rowAddr_C=counterI;
      colAddr_C=counterJ;
    end
    STATE_4: begin
      en_ReadMat_A=1'b1;
      en_WriteMat_A=1'b0;
      rowAddr_A=counterI;
      colAddr_A=counterK;
      en_ReadMat_B=1'b1;
      en_WriteMat_B=1'b0;
      rowAddr_B=counterK;
      colAddr_B=counterJ;
      en_Mux=1'b0;
      en_PPReg=1'b0;
      en_FDReg=1'b0;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b1;
      rowAddr_C=counterI;
      colAddr_C=counterJ;
    end
    S_FINISH: begin
      en_ReadMat_A=1'b0;
      en_WriteMat_A=1'b0;
      rowAddr_A='d0;
      colAddr_A='d0;
      en_ReadMat_B=1'b0;
      en_WriteMat_B=1'b0;
      rowAddr_B='d0;
      colAddr_B='d0;
      en_Mux=1'b0;
      en_PPReg=1'b0;
      en_FDReg=1'b0;
      en_ReadMat_C=1'b0;
      en_WriteMat_C=1'b0;
      rowAddr_C='d0;
      colAddr_C='d0;
    end
  endcase
end
//--------------------------------------------------------------------------end of module
endmodule
