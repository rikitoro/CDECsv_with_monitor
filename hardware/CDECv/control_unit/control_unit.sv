`include "constants_state_code.sv"

module control_unit(
	input logic 			clock,
	input logic				reset,
	// to datapath
	output logic [2:0]	xdst,
	output logic [2:0]	xsrc,
	output logic [3:0]	aluop,
	output logic 			Rwe,
	output logic 			FLGwe,
	output logic			MEMwe,
	// from datapath
	input logic [7:0]		I,
	input logic [2:0]		SZCy,
	// debug
	output logic			dbg_F0,
	output logic			dbg_halt
);

	logic [7:0] state;
	logic [7:0] next_state;

	register_nr state_register( // negative edge driven
		.clock	(clock),
		.reset	(reset),
		.we		(1'b1),
		.d			(next_state),
		.q			(state)
	);

	next_state_function next_state_function(
		.state		(state),
		.I				(I),
		.SZCy			(SZCy),
		.next_state (next_state)
	);
	
	output_function instruction_decoder(
		.state		(state),
		.I				(I),
		.SZCy			(SZCy),
		.xsrc			(xsrc),
		.xdst			(xdst),
		.aluop		(aluop),
		.Rwe			(Rwe),
		.FLGwe		(FLGwe),
		.MEMwe		(MEMwe)
	);

	
	
	
	////////////////////
	/// debug signal ///
	////////////////////
	
	assign dbg_F0 		= (state == `state_F0)	? 1'b1 : 1'b0;
	assign dbg_halt 	= (state == `state_HLT) ? 1'b1 : 1'b0;
	
endmodule
