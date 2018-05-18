// datapath core (datapath unit without memory)


module datapath_core(
	// clock, reset
	input logic 			clock,
	input	logic				reset,
	// Memory interface
	input	logic	[7:0]		RD, 	// read data
	output logic [7:0]	WD,	//	-> to memory unit (write data)
	output logic [7:0]	MA,	// -> to memory unit (memory address)
	// controller interface
	input logic [2:0]		xsrc,
	input logic [2:0]		xdst,
	input logic [3:0]		aluop,
	input logic 			Rwe,
	input logic				FLGwe,
	output logic [7:0]	I,			// -> to controller unit
	output logic [2:0]	SZCy,		// -> to controller unit
	// debug signal
	input logic [2:0] 	dbg_addr,	// 000: {Xbus, PC}, 001: {A, B},  010: {C, FLG},     				 011: {T, R}
	output logic [15:0]	dbg_data 	// 100: {WDR, MAR}, 101: {RD, I}, 110: {1'b0, xsrc, 1'b0,xdst}, 100: {aluop, 8'h00} 
);

	logic [7:0]	Xbus;	// Xbus

	logic [7:0]	PC, A, B, C, FLG; // output of resisters (register set)
	logic [7:0] T, R;					// output of resigsers (non-architecture)

	logic PCwe, Awe, Bwe, Cwe;		// write enable (register set)
	logic MARwe, WDRwe;				// write enable (memory interface)
	logic Twe;							// write enable (alu interface)
	logic Iwe;							// write enabel (instruction reg)

	logic [7:0] alu_result; // output of ALU (result)
	logic [2:0] alu_SZCy;	// output of ALU (Flag)
	
	
	///////////////////
	//// registers ////
	///////////////////
	
	// register set
	
	register_r PCreg(
		.clock	(clock),
		.reset	(reset),
		.we		(PCwe),
		.d			(Xbus),
		.q			(PC)
	);
	
	register Areg(
		.clock	(clock),
		.we		(Awe),
		.d			(Xbus),
		.q			(A)
	);
	
	register Breg(
		.clock	(clock),
		.we		(Bwe),
		.d			(Xbus),
		.q			(A)
	);
	
	register Creg(
		.clock	(clock),
		.we		(Cwe),
		.d			(Xbus),
		.q			(A)
	);
	
	register FLGreg(
		.clock	(clock),
		.we		(FLGwe),
		.d			({4'b0000, alu_SZCy, 1'b0}),
		.q			(FLG)
	);
	
	assign SZCy = FLG[3:1]; // -> to controller unit
	
	// non-architecture registers
	
	//   Memory interface
	register MAR(
		.clock 	(clock),
		.we		(MARwe),
		.d			(Xbus),
		.q			(MA)		// -> to memory unit
	);
	
	register WDR(
		.clock	(clock),
		.we		(WDRwe),
		.d			(Xbus),
		.q			(WD)		// -> to memory unit
	);
	
	//   ALU interface
	register Treg(
		.clock	(clock),
		.we		(Twe),
		.d			(Xbus),
		.q			(T)
	);
	
	register Rreg(
		.clock	(clock),
		.we		(Twe),
		.d			(alu_result),
		.q			(R)
	);
	
	//    Instruction register
	register Ireg(
		.clock	(clock),
		.we		(Iwe),
		.d 		(Xbus),
		.q			(I)			// -> to controller unit
	);
	
	
	
	///////////////////
	////    ALU    ////
	///////////////////

	alu alu(
		.aluop	(aluop),
		.a			(Xbus),
		.b			(T),
		.Cy_in	(FLG[3]),
		.result	(alu_result),
		.SZCy		(alu_SZCy)
	);
	
	
	
	///////////////////
	////   Xbus    ////
	///////////////////
	
	// multiplexer selecting source data
	
	mux8 select_xsrc(
		.sel	(xsrc),
		.d0	(PC),
		.d1	(A),
		.d2	(B),
		.d3	(C),
		.d4	(R),
		.d5	(RD),
		.d6	(FLG),
		.d7	(8'hFF),
		.y		(Xbus)
	);
	
	// line decoder selecting destination register
	
	line_decoder select_xdst(
		.num	(xdst),
		.y0	(PCwe),
		.y1	(Awe),
		.y2	(Bwe),
		.y3	(Cwe),
		.y4	(MARwe),
		.y5	(WDRwe),
		.y6	(Twe),
		.y7	(Iwe)
	);


	/////////////////////////////////////////////////////////////////////////////////////

	///////////////////
	////   debug   ////
	///////////////////

	mux8 select_dbgdata(
		.sel	(dbg_addr),
		.d0	({Xbus, PC}),
		.d1	({A, B}),
		.d2	({C, FLG}),
		.d3	({T, R}),
		.d4	({MAR, WDR}),
		.d5	({RD, I}),
		.d6	({1'b0, xsrc, 1'b0, xdst}),
		.d7	({aluop, 8'h00}),
		.y		(dbg_data)
	);

	
endmodule