// state codes of controller

// fetch cycle
`define state_F0    8'b0001_0000
`define state_F1    8'b0001_0001
`define state_F2    8'b0001_0010
`define state_F3    8'b0001_0011

// execution cycle: move
`define state_M0    8'b0010_0000

// execution cycle: 2-operand operation
`define state_P20   8'b0011_0000
`define state_P21   8'b0011_0001
`define state_P22   8'b0011_0010

// execution cycle: 1-operand operation
`define state_P10   8'b0100_0000
`define state_P11   8'b0100_0001

// execution cycle: load
`define state_LD0   8'b0101_0000
`define state_LD1   8'b0101_0001
`define state_LD2   8'b0101_0010
`define state_LD3   8'b0101_0011
`define state_LD4   8'b0101_0100

// execution cycle: store
`define state_ST0   8'b0110_0000
`define state_ST1   8'b0110_0001
`define state_ST2   8'b0110_0010
`define state_ST3   8'b0110_0011
`define state_ST4   8'b0110_0100

// execution cycle: jump (no condition)
`define state_JP0   8'b0111_0000
`define state_JP1   8'b0111_0001
`define state_JP2   8'b0111_0010

// execution cycle: jump condition
`define state_JC0   8'b1000_0000
`define state_JC1   8'b1000_0001
`define state_JC2   8'b1000_0010

// reset state
`define state_RST   8'b0000_0000
// halt state
`define state_HLT   8'b1111_1111
