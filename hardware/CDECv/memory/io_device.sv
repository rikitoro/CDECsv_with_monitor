module io_device(
	input logic				clock,
	input logic				we,
	input logic	[7:0]		d,
	output logic [7:0]	q,
	//
	input logic	[7:0]		iport,
	output logic [7:0]	oport
);

	register iport_reg(
		.clock 		(clock),
		.we			(1'b1),
		.d				(iport),
		.q				(q)
	);
	
	register oport_reg(
		.clock		(clock),
		.we			(we),
		.d				(d),
		.q				(oport)
	);

	
endmodule
