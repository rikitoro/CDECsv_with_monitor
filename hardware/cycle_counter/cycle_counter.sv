module cycle_counter(
	input logic				clock,
	input logic				reset,
	input logic				pause,
	output logic [15:0]	count
);

	always_ff @ (posedge clock, posedge reset)
		if (reset) 			count <= 15'h00;
		else if (pause)	count <= count;
		else					count <= count + 1'b1;

endmodule
