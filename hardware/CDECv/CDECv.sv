module CDECv(
	input logic				clock,
	input logic				reset,
	// IO port
	input logic [7:0]		iport,
	output logic [7:0]	oport,
	// halt
	output logic 			halt,
	// debug signal
	input logic [2:0]		dbg_addr, // 000: {PC, A}, 001: {B, C},        010: {MAR, WDR},              011: {RD, I}
	output logic [15:0]	dbg_data, // 100: {T, R},  101: {Xbus, aluop}, 110: {1'b0, xsrc, 1'b0,xdst}, 100: 16'h0000
	output logic [2:0]	dbg_SZCy,
	output logic 			dbg_F0,
	// programmer (monitor) interface
	input logic				prg_clock,
	input logic 			prg_we,
	input logic [7:0]		prg_MA,
	input logic [7:0]		prg_WD,
	output logic [7:0]	prg_RD
);


	// datapath core <-> memory
	logic [7:0] MA, WD, RD;

	// datapath core <-> controller
	logic [2:0] xsrc, xdst;
	logic [3:0] aluop;
	logic 		Rwe, FLGwe;
	logic [7:0] I;
	logic [2:0] SZCy;
	// memory <- controller
	logic 		MEMwe;
	
	
	datapath_core datapath_core(
		.clock		(clock),
		.reset		(reset),
		// Memory interface
		.MA			(MA),
		.WD			(WD),
		.RD			(RD),
		// controller interface
		.xsrc			(xsrc),
		.xdst			(xdst),
		.aluop		(aluop),
		.Rwe			(Rwe),
		.FLGwe		(FLGwe),
		.I				(I),
		.SZCy			(SZCy),
		// debug signal
		.dbg_addr   (dbg_addr),
		.dbg_data   (dbg_data) 	 
	);

	controller controller(
		.clock		(clock),
		.reset		(reset),
		// to datapath
		.xsrc			(xsrc),
		.xdst			(xdst),
		.aluop		(aluop),
		.Rwe			(Rwe),
		.FLGwe		(FLGwe),
		.MEMwe		(MEMwe),
		// form datapath
		.I				(I),
		.SZCy			(SZCy),
		// debug signal
		.dbg_F0		(dbg_F0),
		.halt			(halt)
	);

	memory memory(
		// datapath_core interface
		.clock		(clock),
		.we			(MEMwe),
		.MA			(MA),
		.WD			(WD),
		.RD			(RD),
		// ioport interface
		.iport		(iport),
		.oport		(oport),
		// programmer (monitor) interface
		.prg_clock	(prg_clock),
		.prg_we		(prg_we),
		.prg_MA		(prg_MA),
		.prg_WD		(prg_WD),
		.prg_RD		(prg_RD)	
	);


endmodule

