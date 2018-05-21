module clock_generator(
	input logic 		clock_in_50MHz,	// 50MHz clock source (PIN M9 on DE0-CV)
	input logic 		clock_in_manual, 	// manual clock source (KEY0, PIN U7 on DE0-CV)
	input logic [1:0]	sel,					// 00: manual(toggle) , 01: very low freq (1.5Hz)
	output logic		clock_out			// 10: low freq (50Hz), 11: high freq (1.5kHz)
);

	logic clock_manual, clock_vlf, clock_lf, clock_hf;

	toggle toggle(
		.clock_in	(clock_in_manual),
		.clock_out	(clock_manual)
	);
	
	prescalar prescalar(
		.clock_in		(clock_in_50MHz),
		.clock_out_vlf (clock_vlf),
		.clock_out_lf	(clock_lf),
		.clock_out_hf	(clock_hf)
	);

	mux4 #(1) mux_clock(
		.sel		(sel),
		.d0		(clock_manual),
		.d1		(clock_vlf),
		.d2		(clock_lf),
		.d3		(clock_hf),
		.y			(clock_out)
	);

endmodule
