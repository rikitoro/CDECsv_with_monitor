module CDECv(
	input logic				clock,
	input logic				reset,
	// IO port
	input logic [7:0]		iport,
	output logic [7:0]	oport,
	// halt
	// debug signal
	input logic [2:0]		dbg_addr, // 000: {PC, A}, 001: {B, C},        010: {MAR, WDR}, 011: {RD, I}
	output logic [15:0]	dbg_data, // 100: {T, R},  101: {Xbus, 8'h00}, 110: control,    100: 16'h0000
											 // control = {1'b0, xsrc, 1'b0, xdst, aluop, 1'b0, Rwe, FLGwe, MEMwe}
	output logic [2:0]	dbg_SZCy,
	output logic 			dbg_F0,
	output logic 			dbg_halt,
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
	
	// dbg_data
	logic [15:0] dbg_data_datapath;
	
	
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
		.dbg_data   (dbg_data_datapath) 	 
	);

	control_unit control_unit(
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
		.dbg_halt	(dbg_halt)
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

	
	//////////////////
	/// debug data ///
	//////////////////
	
	assign dbg_SZCy = SZCy;

	logic [15:0] control;
	assign control 	= {1'b0, xsrc, 1'b0, xdst, aluop, 1'b0, Rwe, FLGwe, MEMwe};
	assign dbg_data 	= (dbg_addr == 3'b110) ? control : dbg_data_datapath;
	
endmodule

