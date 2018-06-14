`include "constants_state_code.sv"
`include "constants_control_code.sv"

module instruction_decoder(
  input   logic [7:0]   state,
  input   logic [7:0]   I,
  input   logic [2:0]   SZCy,
  output  logic [2:0]   xsrc,
  output  logic [2:0]   xdst,
  output  logic [3:0]   aluop,
  output  logic         Rwe,
  output  logic         FLGwe,
  output  logic         MEMwe
);

  logic [12:0]  control;
  assign {xsrc, xdst, aluop, Rwe, FLGwe, MEMwe} = control;

  always_comb
    casex({state, I, SZCy})
      // Fetch cycle
      {`state_F0,  8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_MAR, `aluop_INC,  3'b100};
      {`state_F1,  8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_R,  `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_F2,  8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_RD, `xdst_I,   `aluop_ZERO, 3'b000};

      // move: MOV sreg, dreg
      {`state_M0,   8'bxxxx_0101, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_ZERO, 3'b000}; // MOV A, A
      {`state_M0,   8'bxxxx_0110, 3'bxxx}: control = {`xsrc_A,  `xdst_B,   `aluop_ZERO, 3'b000}; // MOV A, B
      {`state_M0,   8'bxxxx_0111, 3'bxxx}: control = {`xsrc_A,  `xdst_C,   `aluop_ZERO, 3'b000}; // MOV A, C
      {`state_M0,   8'bxxxx_1001, 3'bxxx}: control = {`xsrc_B,  `xdst_A,   `aluop_ZERO, 3'b000}; // MOV B, A
      {`state_M0,   8'bxxxx_1010, 3'bxxx}: control = {`xsrc_B,  `xdst_B,   `aluop_ZERO, 3'b000}; // MOV B, B
      {`state_M0,   8'bxxxx_1011, 3'bxxx}: control = {`xsrc_B,  `xdst_C,   `aluop_ZERO, 3'b000}; // MOV B, C
      {`state_M0,   8'bxxxx_1101, 3'bxxx}: control = {`xsrc_C,  `xdst_A,   `aluop_ZERO, 3'b000}; // MOV C, A
      {`state_M0,   8'bxxxx_1110, 3'bxxx}: control = {`xsrc_C,  `xdst_B,   `aluop_ZERO, 3'b000}; // MOV C, B
      {`state_M0,   8'bxxxx_1111, 3'bxxx}: control = {`xsrc_C,  `xdst_C,   `aluop_ZERO, 3'b000}; // MOV C, C

      // 2-op: ADD reg, ADC reg, SUB reg, SBB reg, AND reg, OR reg, EOR reg
      {`state_P20, 8'bxxxx_xx01, 3'bxxx}: control = {`xsrc_A,  `xdst_T,   `aluop_ZERO, 3'b000}; // reg = A
      {`state_P20, 8'bxxxx_xx10, 3'bxxx}: control = {`xsrc_B,  `xdst_T,   `aluop_ZERO, 3'b000}; // reg = B
      {`state_P20, 8'bxxxx_xx11, 3'bxxx}: control = {`xsrc_C,  `xdst_T,   `aluop_ZERO, 3'b000}; // reg = C
      {`state_P21, 8'bxx10_00xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_ADD,  3'b110}; // ADD reg
      {`state_P21, 8'bxx10_01xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_ADC,  3'b110}; // ADC reg
      {`state_P21, 8'bxx10_10xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_SUB,  3'b110}; // SUB reg
      {`state_P21, 8'bxx10_11xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_SBB,  3'b110}; // SUB reg
      {`state_P21, 8'bxx11_00xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_AND,  3'b110}; // AND reg
      {`state_P21, 8'bxx11_01xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_OR,   3'b110}; // OR reg
      {`state_P21, 8'bxx11_11xx, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_EOR,  3'b110}; // EOR reg
      //
      {`state_P22, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_R,  `xdst_A,   `aluop_ZERO, 3'b000};

      // 1-op: INC reg, DEC reg, NOT reg
      {`state_P10, 8'bxx00_0001, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_INC,  3'b110}; // INC A
      {`state_P10, 8'bxx00_0010, 3'bxxx}: control = {`xsrc_B,  `xdst_B,   `aluop_INC,  3'b110}; // INC B
      {`state_P10, 8'bxx00_0011, 3'bxxx}: control = {`xsrc_C,  `xdst_C,   `aluop_INC,  3'b110}; // INC C
      {`state_P10, 8'bxx00_0101, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_DEC,  3'b110}; // DEC A
      {`state_P10, 8'bxx00_0110, 3'bxxx}: control = {`xsrc_B,  `xdst_B,   `aluop_DEC,  3'b110}; // DEC B
      {`state_P10, 8'bxx00_0111, 3'bxxx}: control = {`xsrc_C,  `xdst_C,   `aluop_DEC,  3'b110}; // DEC C
      {`state_P10, 8'bxx01_0101, 3'bxxx}: control = {`xsrc_A,  `xdst_A,   `aluop_NOT,  3'b110}; // NOT A
      {`state_P10, 8'bxx01_0110, 3'bxxx}: control = {`xsrc_B,  `xdst_B,   `aluop_NOT,  3'b110}; // NOT B
      {`state_P10, 8'bxx01_0111, 3'bxxx}: control = {`xsrc_C,  `xdst_C,   `aluop_NOT,  3'b110}; // NOT C
      {`state_P11, 8'bxxxx_xx01, 3'bxxx}: control = {`xsrc_R,  `xdst_A,   `aluop_ZERO, 3'b000}; // reg = A
      {`state_P11, 8'bxxxx_xx10, 3'bxxx}: control = {`xsrc_R,  `xdst_B,   `aluop_ZERO, 3'b000}; // reg = B
      {`state_P11, 8'bxxxx_xx11, 3'bxxx}: control = {`xsrc_R,  `xdst_C,   `aluop_ZERO, 3'b000}; // reg = C

      // load: LD ards, dreg
      {`state_LD0, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_MAR, `aluop_INC,  3'b100};
      {`state_LD1, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_R,  `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_LD2, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_RD, `xdst_MAR, `aluop_ZERO, 3'b000};
      {`state_LD3, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_LD4, 8'bxxxx_xx01, 3'bxxx}: control = {`xsrc_RD, `xdst_A,   `aluop_ZERO, 3'b000}; // LD ards, A
      {`state_LD4, 8'bxxxx_xx10, 3'bxxx}: control = {`xsrc_RD, `xdst_B,   `aluop_ZERO, 3'b000}; // LD ards, B
      {`state_LD4, 8'bxxxx_xx11, 3'bxxx}: control = {`xsrc_RD, `xdst_C,   `aluop_ZERO, 3'b000}; // LD ards, C

      // store: ST sreg, adrs
      {`state_ST0, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_MAR, `aluop_INC,  3'b100};
      {`state_ST1, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_R,  `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_ST2, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_RD, `xdst_MAR, `aluop_ZERO, 3'b000};
      {`state_ST3, 8'bxxxx_01xx, 3'bxxx}: control = {`xsrc_A,  `xdst_WDR, `aluop_ZERO, 3'b000}; // ST A, adrs
      {`state_ST3, 8'bxxxx_10xx, 3'bxxx}: control = {`xsrc_B,  `xdst_WDR, `aluop_ZERO, 3'b000}; // ST B, adrs
      {`state_ST3, 8'bxxxx_11xx, 3'bxxx}: control = {`xsrc_C,  `xdst_WDR, `aluop_ZERO, 3'b000}; // ST C, adrs
      {`state_ST4, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b001};

      // jump: JMP adrs
      {`state_JP0, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_MAR, `aluop_INC,  3'b100};
      {`state_JP1, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_JP2, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_RD, `xdst_PC,  `aluop_ZERO, 3'b000};

      // jump condition: JS adrs, JZ adrs, JC adrs
      {`state_JC0, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_PC, `xdst_MAR, `aluop_INC,  3'b100};
      {`state_JC1, 8'bxxxx_xxxx, 3'bxxx}: control = {`xsrc_R,  `xdst_PC,  `aluop_ZERO, 3'b000};
      {`state_JC2, 8'bxxx1_0000, 3'b1xx}: control = {`xsrc_RD, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 1)
      {`state_JC2, 8'bxxx1_0000, 3'b0xx}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 0)
      {`state_JC2, 8'bxxx0_1000, 3'bx1x}: control = {`xsrc_RD, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 1)
      {`state_JC2, 8'bxxx0_1000, 3'bx0x}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 0)
      {`state_JC2, 8'bxxx0_0100, 3'bxx1}: control = {`xsrc_RD, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 1)
      {`state_JC2, 8'bxxx0_0100, 3'bxx0}: control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000}; // JS adrs (S == 0)

      //
      default:                            control = {`xsrc_PC, `xdst_PC,  `aluop_ZERO, 3'b000};

    endcase

endmodule
