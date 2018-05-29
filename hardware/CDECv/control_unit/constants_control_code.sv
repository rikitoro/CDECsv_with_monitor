// xsrc (Xbus source data)
`define xsrc_PC     3'b000
`define xsrc_A      3'b001
`define xsrc_B      3'b010
`define xsrc_C      3'b011
`define xsrc_R      3'b100
`define xsrc_RD     3'b101
`define xsrc_FLG    3'b110
`define xsrc_FF     3'b111

// xdst (Xbus destination register)
`define xdst_PC     3'b000
`define xdst_A      3'b001
`define xdst_B      3'b010
`define xdst_C      3'b011
`define xdst_MAR    3'b100
`define xdst_WDR    3'b101
`define xdst_T      3'b110
`define xdst_I      3'b111

// aluop (alu operation)
`define aluop_NOT   4'b0010
`define aluop_AND   4'b0100
`define aluop_OR    4'b0101
`define aluop_EOR   4'b0110
`define aluop_ZERO  4'b0111
`define aluop_INC   4'b1000
`define aluop_DEC   4'b1001
`define aluop_ADD   4'b1010
`define aluop_ADC   4'b1100
`define aluop_SUB   4'b1011
`define aluop_SBB   4'b1101
