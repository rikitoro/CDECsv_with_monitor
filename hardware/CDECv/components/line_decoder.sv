//3-8 line_decoder

module line_decoder ( 
	input	logic	[2:0]		num,
	output logic			y0,
	output logic			y1,
	output logic			y2,
	output logic			y3,
	output logic			y4,
	output logic			y5,
	output logic			y6,
	output logic			y7	
);

	logic [7:0] ys;
	
	assign {y7, y6, y5, y4, y3, y2, y1, y0} = ys;
	
	always_comb
		case (num)
			3'b000: ys = 8'b0000_0001;
			3'b001: ys = 8'b0000_0010;
			3'b010: ys = 8'b0000_0100;
			3'b011: ys = 8'b0000_1000;
			3'b100: ys = 8'b0001_0000;
			3'b101: ys = 8'b0010_0000;
			3'b110: ys = 8'b0100_0000;
			3'b111: ys = 8'b1000_0000;			
		endcase

endmodule