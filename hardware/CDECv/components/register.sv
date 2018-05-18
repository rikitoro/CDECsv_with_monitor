
// register (positive edge clock, async reset)

module register_r #(parameter N = 8) (
	input 	logic				clock,
	input		logic 			reset,
	input		logic				we,
	input 	logic	[N-1:0]	d,
	output	logic [N-1:0]	q
);

	always_ff @ (posedge clock, posedge reset)
		if (reset)		q <= 0;
		else if (we)	q <= d;

endmodule

// register (positive edge clock, no reset)

module register #(parameter N = 8) (
	input		logic				clock,
	input		logic 			we,		// write enable
	input		logic	[N-1:0] 	d,
	output	logic	[N-1:0]	q
);
	
	register_r register_r(
		.clock	(clock),
		.reset	(1'b0),
		.we		(we),
		.d			(d),
		.q			(q)
	);

endmodule


// register (negative edge clock, async reset)

module register_nr #(parameter N = 8) (
	input 	logic				clock,
	input		logic 			reset,
	input		logic				we,
	input 	logic	[N-1:0]	d,
	output	logic [N-1:0]	q
);

	always_ff @ (negedge clock, posedge reset)
		if (reset)		q <= 0;
		else if (we)	q <= d;

endmodule


// register

module register_n #(parameter N = 8) (
	input		logic				clock,
	input		logic 			we,		// write enable
	input		logic	[N-1:0] 	d,
	output	logic	[N-1:0]	q
);
	
	register_nr register_nr(
		.clock	(clock),
		.reset	(1'b0),
		.we		(we),
		.d			(d),
		.q			(q)
	);

endmodule
