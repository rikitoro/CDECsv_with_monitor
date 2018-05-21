`include "constants_state_code.sv"

module next_state_function(
	input logic [7:0] 	I,
	input logic [2:0]		SZCy,
	input logic [7:0] 	state,
	output logic [7:0] 	next_state
);

	always_comb
		casex ({state, I, SZCy})
			// Fetch cycle
			{`state_F0,  8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F1;
			{`state_F1,  8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F2;
			// execution cycle: move, MOV
			{`state_F2,  8'b0000_xxxx, 3'bxxx}: next_state = `state_M0;
			{`state_M0,  8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: 2-operand operation, ADD, ADC, SUB, SBB, AND, OR, EOR
			{`state_F2,  8'b001x_xxxx, 3'bxxx}: next_state = `state_P20;
			{`state_P20, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_P21;
			{`state_P21, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_P22;
			{`state_P22, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: 1-operand operation, INC, DEC, NOT
			{`state_F2,  8'b010x_xxxx, 3'bxxx}: next_state = `state_P10;
			{`state_P10, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_P11;
			{`state_P11, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: load, LD
			{`state_F2,  8'b1000_00xx, 3'bxxx}: next_state = `state_LD0;
			{`state_LD0, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_LD1;
			{`state_LD1, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_LD2;
			{`state_LD2, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_LD3;
			{`state_LD3, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_LD4;
			{`state_LD4, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: store, ST
			{`state_F2,  8'b1010_xx00, 3'bxxx}: next_state = `state_ST0;
			{`state_ST0, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_ST1;
			{`state_ST1, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_ST2;
			{`state_ST2, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_ST3;
			{`state_ST3, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_ST4;
			{`state_ST4, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: jump (no condition), JMP
			{`state_F2,  8'b1100_00xx, 3'bxxx}: next_state = `state_JP0;
			{`state_JP0, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_JP1;
			{`state_JP1, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_JP2;
			{`state_JP2, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// execution cycle: jump condition, JS, JZ, JC
			{`state_F2,  8'b111x_xx00, 3'bxxx}: next_state = `state_JC0;
			{`state_JC0, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_JC1;
			{`state_JC1, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_JC2;
			{`state_JC2, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			
			// reset
			{`state_RST, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_F0;
			// halt
			{`state_F2,  8'b1111_1111, 3'bxxx}: next_state = `state_HLT;
			{`state_HLT, 8'bxxxx_xxxx, 3'bxxx}: next_state = `state_HLT;
			
			default: next_state = `state_HLT;
			
		endcase

endmodule
