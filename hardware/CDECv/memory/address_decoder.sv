module address_decoder(
	input logic				we,
	input logic [7:0]		MA,
	//
	output logic			ram_we,
	output logic 			io_we,
	output logic 			sel_ram_io
);

	always_comb
		case (MA)
			8'hFF:	{ram_we, io_we, sel_ram_io} = {1'b0,   we, 1'b1};
			default:	{ram_we, io_we, sel_ram_io} = {we  , 1'b0, 1'b0};
		endcase

endmodule
