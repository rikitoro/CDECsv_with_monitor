// monitor.v

// Generated using ACDS version 17.1 590

`timescale 1 ps / 1 ps
module monitor (
		input  wire       clk_clk,          //       clk.clk
		output wire       prg_clock_export, // prg_clock.export
		output wire [7:0] prg_ma_export,    //    prg_ma.export
		input  wire [7:0] prg_rd_export,    //    prg_rd.export
		output wire [7:0] prg_wd_export,    //    prg_wd.export
		output wire       prg_we_export,    //    prg_we.export
		input  wire       reset_reset_n,    //     reset.reset_n
		input  wire       uart_0_rxd,       //    uart_0.rxd
		output wire       uart_0_txd        //          .txd
	);

	wire  [31:0] nios2_processor_data_master_readdata;                          // mm_interconnect_0:nios2_processor_data_master_readdata -> nios2_processor:d_readdata
	wire         nios2_processor_data_master_waitrequest;                       // mm_interconnect_0:nios2_processor_data_master_waitrequest -> nios2_processor:d_waitrequest
	wire         nios2_processor_data_master_debugaccess;                       // nios2_processor:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_processor_data_master_debugaccess
	wire  [14:0] nios2_processor_data_master_address;                           // nios2_processor:d_address -> mm_interconnect_0:nios2_processor_data_master_address
	wire   [3:0] nios2_processor_data_master_byteenable;                        // nios2_processor:d_byteenable -> mm_interconnect_0:nios2_processor_data_master_byteenable
	wire         nios2_processor_data_master_read;                              // nios2_processor:d_read -> mm_interconnect_0:nios2_processor_data_master_read
	wire         nios2_processor_data_master_write;                             // nios2_processor:d_write -> mm_interconnect_0:nios2_processor_data_master_write
	wire  [31:0] nios2_processor_data_master_writedata;                         // nios2_processor:d_writedata -> mm_interconnect_0:nios2_processor_data_master_writedata
	wire  [31:0] nios2_processor_instruction_master_readdata;                   // mm_interconnect_0:nios2_processor_instruction_master_readdata -> nios2_processor:i_readdata
	wire         nios2_processor_instruction_master_waitrequest;                // mm_interconnect_0:nios2_processor_instruction_master_waitrequest -> nios2_processor:i_waitrequest
	wire  [14:0] nios2_processor_instruction_master_address;                    // nios2_processor:i_address -> mm_interconnect_0:nios2_processor_instruction_master_address
	wire         nios2_processor_instruction_master_read;                       // nios2_processor:i_read -> mm_interconnect_0:nios2_processor_instruction_master_read
	wire  [31:0] mm_interconnect_0_sysid_control_slave_readdata;                // sysid:readdata -> mm_interconnect_0:sysid_control_slave_readdata
	wire   [0:0] mm_interconnect_0_sysid_control_slave_address;                 // mm_interconnect_0:sysid_control_slave_address -> sysid:address
	wire  [31:0] mm_interconnect_0_nios2_processor_debug_mem_slave_readdata;    // nios2_processor:debug_mem_slave_readdata -> mm_interconnect_0:nios2_processor_debug_mem_slave_readdata
	wire         mm_interconnect_0_nios2_processor_debug_mem_slave_waitrequest; // nios2_processor:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_processor_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_nios2_processor_debug_mem_slave_debugaccess; // mm_interconnect_0:nios2_processor_debug_mem_slave_debugaccess -> nios2_processor:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_processor_debug_mem_slave_address;     // mm_interconnect_0:nios2_processor_debug_mem_slave_address -> nios2_processor:debug_mem_slave_address
	wire         mm_interconnect_0_nios2_processor_debug_mem_slave_read;        // mm_interconnect_0:nios2_processor_debug_mem_slave_read -> nios2_processor:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_nios2_processor_debug_mem_slave_byteenable;  // mm_interconnect_0:nios2_processor_debug_mem_slave_byteenable -> nios2_processor:debug_mem_slave_byteenable
	wire         mm_interconnect_0_nios2_processor_debug_mem_slave_write;       // mm_interconnect_0:nios2_processor_debug_mem_slave_write -> nios2_processor:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_nios2_processor_debug_mem_slave_writedata;   // mm_interconnect_0:nios2_processor_debug_mem_slave_writedata -> nios2_processor:debug_mem_slave_writedata
	wire  [31:0] mm_interconnect_0_prg_rd_s1_readdata;                          // prg_RD:readdata -> mm_interconnect_0:prg_RD_s1_readdata
	wire   [1:0] mm_interconnect_0_prg_rd_s1_address;                           // mm_interconnect_0:prg_RD_s1_address -> prg_RD:address
	wire         mm_interconnect_0_prg_wd_s1_chipselect;                        // mm_interconnect_0:prg_WD_s1_chipselect -> prg_WD:chipselect
	wire  [31:0] mm_interconnect_0_prg_wd_s1_readdata;                          // prg_WD:readdata -> mm_interconnect_0:prg_WD_s1_readdata
	wire   [1:0] mm_interconnect_0_prg_wd_s1_address;                           // mm_interconnect_0:prg_WD_s1_address -> prg_WD:address
	wire         mm_interconnect_0_prg_wd_s1_write;                             // mm_interconnect_0:prg_WD_s1_write -> prg_WD:write_n
	wire  [31:0] mm_interconnect_0_prg_wd_s1_writedata;                         // mm_interconnect_0:prg_WD_s1_writedata -> prg_WD:writedata
	wire         mm_interconnect_0_prg_ma_s1_chipselect;                        // mm_interconnect_0:prg_MA_s1_chipselect -> prg_MA:chipselect
	wire  [31:0] mm_interconnect_0_prg_ma_s1_readdata;                          // prg_MA:readdata -> mm_interconnect_0:prg_MA_s1_readdata
	wire   [1:0] mm_interconnect_0_prg_ma_s1_address;                           // mm_interconnect_0:prg_MA_s1_address -> prg_MA:address
	wire         mm_interconnect_0_prg_ma_s1_write;                             // mm_interconnect_0:prg_MA_s1_write -> prg_MA:write_n
	wire  [31:0] mm_interconnect_0_prg_ma_s1_writedata;                         // mm_interconnect_0:prg_MA_s1_writedata -> prg_MA:writedata
	wire         mm_interconnect_0_prg_clock_s1_chipselect;                     // mm_interconnect_0:prg_clock_s1_chipselect -> prg_clock:chipselect
	wire  [31:0] mm_interconnect_0_prg_clock_s1_readdata;                       // prg_clock:readdata -> mm_interconnect_0:prg_clock_s1_readdata
	wire   [1:0] mm_interconnect_0_prg_clock_s1_address;                        // mm_interconnect_0:prg_clock_s1_address -> prg_clock:address
	wire         mm_interconnect_0_prg_clock_s1_write;                          // mm_interconnect_0:prg_clock_s1_write -> prg_clock:write_n
	wire  [31:0] mm_interconnect_0_prg_clock_s1_writedata;                      // mm_interconnect_0:prg_clock_s1_writedata -> prg_clock:writedata
	wire         mm_interconnect_0_prg_we_s1_chipselect;                        // mm_interconnect_0:prg_we_s1_chipselect -> prg_we:chipselect
	wire  [31:0] mm_interconnect_0_prg_we_s1_readdata;                          // prg_we:readdata -> mm_interconnect_0:prg_we_s1_readdata
	wire   [1:0] mm_interconnect_0_prg_we_s1_address;                           // mm_interconnect_0:prg_we_s1_address -> prg_we:address
	wire         mm_interconnect_0_prg_we_s1_write;                             // mm_interconnect_0:prg_we_s1_write -> prg_we:write_n
	wire  [31:0] mm_interconnect_0_prg_we_s1_writedata;                         // mm_interconnect_0:prg_we_s1_writedata -> prg_we:writedata
	wire         mm_interconnect_0_onchip_memory2_0_s1_chipselect;              // mm_interconnect_0:onchip_memory2_0_s1_chipselect -> onchip_memory2_0:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory2_0_s1_readdata;                // onchip_memory2_0:readdata -> mm_interconnect_0:onchip_memory2_0_s1_readdata
	wire  [10:0] mm_interconnect_0_onchip_memory2_0_s1_address;                 // mm_interconnect_0:onchip_memory2_0_s1_address -> onchip_memory2_0:address
	wire   [3:0] mm_interconnect_0_onchip_memory2_0_s1_byteenable;              // mm_interconnect_0:onchip_memory2_0_s1_byteenable -> onchip_memory2_0:byteenable
	wire         mm_interconnect_0_onchip_memory2_0_s1_write;                   // mm_interconnect_0:onchip_memory2_0_s1_write -> onchip_memory2_0:write
	wire  [31:0] mm_interconnect_0_onchip_memory2_0_s1_writedata;               // mm_interconnect_0:onchip_memory2_0_s1_writedata -> onchip_memory2_0:writedata
	wire         mm_interconnect_0_onchip_memory2_0_s1_clken;                   // mm_interconnect_0:onchip_memory2_0_s1_clken -> onchip_memory2_0:clken
	wire         mm_interconnect_0_uart_0_s1_chipselect;                        // mm_interconnect_0:uart_0_s1_chipselect -> uart_0:chipselect
	wire  [15:0] mm_interconnect_0_uart_0_s1_readdata;                          // uart_0:readdata -> mm_interconnect_0:uart_0_s1_readdata
	wire   [2:0] mm_interconnect_0_uart_0_s1_address;                           // mm_interconnect_0:uart_0_s1_address -> uart_0:address
	wire         mm_interconnect_0_uart_0_s1_read;                              // mm_interconnect_0:uart_0_s1_read -> uart_0:read_n
	wire         mm_interconnect_0_uart_0_s1_begintransfer;                     // mm_interconnect_0:uart_0_s1_begintransfer -> uart_0:begintransfer
	wire         mm_interconnect_0_uart_0_s1_write;                             // mm_interconnect_0:uart_0_s1_write -> uart_0:write_n
	wire  [15:0] mm_interconnect_0_uart_0_s1_writedata;                         // mm_interconnect_0:uart_0_s1_writedata -> uart_0:writedata
	wire  [31:0] nios2_processor_irq_irq;                                       // irq_mapper:sender_irq -> nios2_processor:irq
	wire         rst_controller_reset_out_reset;                                // rst_controller:reset_out -> [irq_mapper:reset, mm_interconnect_0:nios2_processor_reset_reset_bridge_in_reset_reset, nios2_processor:reset_n, onchip_memory2_0:reset, prg_MA:reset_n, prg_RD:reset_n, prg_WD:reset_n, prg_clock:reset_n, prg_we:reset_n, rst_translator:in_reset, sysid:reset_n, uart_0:reset_n]
	wire         rst_controller_reset_out_reset_req;                            // rst_controller:reset_req -> [nios2_processor:reset_req, onchip_memory2_0:reset_req, rst_translator:reset_req_in]

	monitor_nios2_processor nios2_processor (
		.clk                                 (clk_clk),                                                       //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                               //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                            //                          .reset_req
		.d_address                           (nios2_processor_data_master_address),                           //               data_master.address
		.d_byteenable                        (nios2_processor_data_master_byteenable),                        //                          .byteenable
		.d_read                              (nios2_processor_data_master_read),                              //                          .read
		.d_readdata                          (nios2_processor_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (nios2_processor_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (nios2_processor_data_master_write),                             //                          .write
		.d_writedata                         (nios2_processor_data_master_writedata),                         //                          .writedata
		.debug_mem_slave_debugaccess_to_roms (nios2_processor_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (nios2_processor_instruction_master_address),                    //        instruction_master.address
		.i_read                              (nios2_processor_instruction_master_read),                       //                          .read
		.i_readdata                          (nios2_processor_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (nios2_processor_instruction_master_waitrequest),                //                          .waitrequest
		.irq                                 (nios2_processor_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (),                                                              //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_nios2_processor_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_nios2_processor_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_nios2_processor_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_nios2_processor_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_nios2_processor_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_nios2_processor_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_nios2_processor_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_nios2_processor_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                               // custom_instruction_master.readra
	);

	monitor_onchip_memory2_0 onchip_memory2_0 (
		.clk        (clk_clk),                                          //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory2_0_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory2_0_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory2_0_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory2_0_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory2_0_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory2_0_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory2_0_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                   // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),               //       .reset_req
		.freeze     (1'b0)                                              // (terminated)
	);

	monitor_prg_MA prg_ma (
		.clk        (clk_clk),                                //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),        //               reset.reset_n
		.address    (mm_interconnect_0_prg_ma_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_prg_ma_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_prg_ma_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_prg_ma_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_prg_ma_s1_readdata),   //                    .readdata
		.out_port   (prg_ma_export)                           // external_connection.export
	);

	monitor_prg_RD prg_rd (
		.clk      (clk_clk),                              //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),      //               reset.reset_n
		.address  (mm_interconnect_0_prg_rd_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_prg_rd_s1_readdata), //                    .readdata
		.in_port  (prg_rd_export)                         // external_connection.export
	);

	monitor_prg_MA prg_wd (
		.clk        (clk_clk),                                //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),        //               reset.reset_n
		.address    (mm_interconnect_0_prg_wd_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_prg_wd_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_prg_wd_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_prg_wd_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_prg_wd_s1_readdata),   //                    .readdata
		.out_port   (prg_wd_export)                           // external_connection.export
	);

	monitor_prg_clock prg_clock (
		.clk        (clk_clk),                                   //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),           //               reset.reset_n
		.address    (mm_interconnect_0_prg_clock_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_prg_clock_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_prg_clock_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_prg_clock_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_prg_clock_s1_readdata),   //                    .readdata
		.out_port   (prg_clock_export)                           // external_connection.export
	);

	monitor_prg_clock prg_we (
		.clk        (clk_clk),                                //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),        //               reset.reset_n
		.address    (mm_interconnect_0_prg_we_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_prg_we_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_prg_we_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_prg_we_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_prg_we_s1_readdata),   //                    .readdata
		.out_port   (prg_we_export)                           // external_connection.export
	);

	monitor_sysid sysid (
		.clock    (clk_clk),                                        //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),                //         reset.reset_n
		.readdata (mm_interconnect_0_sysid_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_sysid_control_slave_address)   //              .address
	);

	monitor_uart_0 uart_0 (
		.clk           (clk_clk),                                   //                 clk.clk
		.reset_n       (~rst_controller_reset_out_reset),           //               reset.reset_n
		.address       (mm_interconnect_0_uart_0_s1_address),       //                  s1.address
		.begintransfer (mm_interconnect_0_uart_0_s1_begintransfer), //                    .begintransfer
		.chipselect    (mm_interconnect_0_uart_0_s1_chipselect),    //                    .chipselect
		.read_n        (~mm_interconnect_0_uart_0_s1_read),         //                    .read_n
		.write_n       (~mm_interconnect_0_uart_0_s1_write),        //                    .write_n
		.writedata     (mm_interconnect_0_uart_0_s1_writedata),     //                    .writedata
		.readdata      (mm_interconnect_0_uart_0_s1_readdata),      //                    .readdata
		.rxd           (uart_0_rxd),                                // external_connection.export
		.txd           (uart_0_txd),                                //                    .export
		.irq           ()                                           //                 irq.irq
	);

	monitor_mm_interconnect_0 mm_interconnect_0 (
		.clk_clk_clk                                       (clk_clk),                                                       //                                     clk_clk.clk
		.nios2_processor_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                                // nios2_processor_reset_reset_bridge_in_reset.reset
		.nios2_processor_data_master_address               (nios2_processor_data_master_address),                           //                 nios2_processor_data_master.address
		.nios2_processor_data_master_waitrequest           (nios2_processor_data_master_waitrequest),                       //                                            .waitrequest
		.nios2_processor_data_master_byteenable            (nios2_processor_data_master_byteenable),                        //                                            .byteenable
		.nios2_processor_data_master_read                  (nios2_processor_data_master_read),                              //                                            .read
		.nios2_processor_data_master_readdata              (nios2_processor_data_master_readdata),                          //                                            .readdata
		.nios2_processor_data_master_write                 (nios2_processor_data_master_write),                             //                                            .write
		.nios2_processor_data_master_writedata             (nios2_processor_data_master_writedata),                         //                                            .writedata
		.nios2_processor_data_master_debugaccess           (nios2_processor_data_master_debugaccess),                       //                                            .debugaccess
		.nios2_processor_instruction_master_address        (nios2_processor_instruction_master_address),                    //          nios2_processor_instruction_master.address
		.nios2_processor_instruction_master_waitrequest    (nios2_processor_instruction_master_waitrequest),                //                                            .waitrequest
		.nios2_processor_instruction_master_read           (nios2_processor_instruction_master_read),                       //                                            .read
		.nios2_processor_instruction_master_readdata       (nios2_processor_instruction_master_readdata),                   //                                            .readdata
		.nios2_processor_debug_mem_slave_address           (mm_interconnect_0_nios2_processor_debug_mem_slave_address),     //             nios2_processor_debug_mem_slave.address
		.nios2_processor_debug_mem_slave_write             (mm_interconnect_0_nios2_processor_debug_mem_slave_write),       //                                            .write
		.nios2_processor_debug_mem_slave_read              (mm_interconnect_0_nios2_processor_debug_mem_slave_read),        //                                            .read
		.nios2_processor_debug_mem_slave_readdata          (mm_interconnect_0_nios2_processor_debug_mem_slave_readdata),    //                                            .readdata
		.nios2_processor_debug_mem_slave_writedata         (mm_interconnect_0_nios2_processor_debug_mem_slave_writedata),   //                                            .writedata
		.nios2_processor_debug_mem_slave_byteenable        (mm_interconnect_0_nios2_processor_debug_mem_slave_byteenable),  //                                            .byteenable
		.nios2_processor_debug_mem_slave_waitrequest       (mm_interconnect_0_nios2_processor_debug_mem_slave_waitrequest), //                                            .waitrequest
		.nios2_processor_debug_mem_slave_debugaccess       (mm_interconnect_0_nios2_processor_debug_mem_slave_debugaccess), //                                            .debugaccess
		.onchip_memory2_0_s1_address                       (mm_interconnect_0_onchip_memory2_0_s1_address),                 //                         onchip_memory2_0_s1.address
		.onchip_memory2_0_s1_write                         (mm_interconnect_0_onchip_memory2_0_s1_write),                   //                                            .write
		.onchip_memory2_0_s1_readdata                      (mm_interconnect_0_onchip_memory2_0_s1_readdata),                //                                            .readdata
		.onchip_memory2_0_s1_writedata                     (mm_interconnect_0_onchip_memory2_0_s1_writedata),               //                                            .writedata
		.onchip_memory2_0_s1_byteenable                    (mm_interconnect_0_onchip_memory2_0_s1_byteenable),              //                                            .byteenable
		.onchip_memory2_0_s1_chipselect                    (mm_interconnect_0_onchip_memory2_0_s1_chipselect),              //                                            .chipselect
		.onchip_memory2_0_s1_clken                         (mm_interconnect_0_onchip_memory2_0_s1_clken),                   //                                            .clken
		.prg_clock_s1_address                              (mm_interconnect_0_prg_clock_s1_address),                        //                                prg_clock_s1.address
		.prg_clock_s1_write                                (mm_interconnect_0_prg_clock_s1_write),                          //                                            .write
		.prg_clock_s1_readdata                             (mm_interconnect_0_prg_clock_s1_readdata),                       //                                            .readdata
		.prg_clock_s1_writedata                            (mm_interconnect_0_prg_clock_s1_writedata),                      //                                            .writedata
		.prg_clock_s1_chipselect                           (mm_interconnect_0_prg_clock_s1_chipselect),                     //                                            .chipselect
		.prg_MA_s1_address                                 (mm_interconnect_0_prg_ma_s1_address),                           //                                   prg_MA_s1.address
		.prg_MA_s1_write                                   (mm_interconnect_0_prg_ma_s1_write),                             //                                            .write
		.prg_MA_s1_readdata                                (mm_interconnect_0_prg_ma_s1_readdata),                          //                                            .readdata
		.prg_MA_s1_writedata                               (mm_interconnect_0_prg_ma_s1_writedata),                         //                                            .writedata
		.prg_MA_s1_chipselect                              (mm_interconnect_0_prg_ma_s1_chipselect),                        //                                            .chipselect
		.prg_RD_s1_address                                 (mm_interconnect_0_prg_rd_s1_address),                           //                                   prg_RD_s1.address
		.prg_RD_s1_readdata                                (mm_interconnect_0_prg_rd_s1_readdata),                          //                                            .readdata
		.prg_WD_s1_address                                 (mm_interconnect_0_prg_wd_s1_address),                           //                                   prg_WD_s1.address
		.prg_WD_s1_write                                   (mm_interconnect_0_prg_wd_s1_write),                             //                                            .write
		.prg_WD_s1_readdata                                (mm_interconnect_0_prg_wd_s1_readdata),                          //                                            .readdata
		.prg_WD_s1_writedata                               (mm_interconnect_0_prg_wd_s1_writedata),                         //                                            .writedata
		.prg_WD_s1_chipselect                              (mm_interconnect_0_prg_wd_s1_chipselect),                        //                                            .chipselect
		.prg_we_s1_address                                 (mm_interconnect_0_prg_we_s1_address),                           //                                   prg_we_s1.address
		.prg_we_s1_write                                   (mm_interconnect_0_prg_we_s1_write),                             //                                            .write
		.prg_we_s1_readdata                                (mm_interconnect_0_prg_we_s1_readdata),                          //                                            .readdata
		.prg_we_s1_writedata                               (mm_interconnect_0_prg_we_s1_writedata),                         //                                            .writedata
		.prg_we_s1_chipselect                              (mm_interconnect_0_prg_we_s1_chipselect),                        //                                            .chipselect
		.sysid_control_slave_address                       (mm_interconnect_0_sysid_control_slave_address),                 //                         sysid_control_slave.address
		.sysid_control_slave_readdata                      (mm_interconnect_0_sysid_control_slave_readdata),                //                                            .readdata
		.uart_0_s1_address                                 (mm_interconnect_0_uart_0_s1_address),                           //                                   uart_0_s1.address
		.uart_0_s1_write                                   (mm_interconnect_0_uart_0_s1_write),                             //                                            .write
		.uart_0_s1_read                                    (mm_interconnect_0_uart_0_s1_read),                              //                                            .read
		.uart_0_s1_readdata                                (mm_interconnect_0_uart_0_s1_readdata),                          //                                            .readdata
		.uart_0_s1_writedata                               (mm_interconnect_0_uart_0_s1_writedata),                         //                                            .writedata
		.uart_0_s1_begintransfer                           (mm_interconnect_0_uart_0_s1_begintransfer),                     //                                            .begintransfer
		.uart_0_s1_chipselect                              (mm_interconnect_0_uart_0_s1_chipselect)                         //                                            .chipselect
	);

	monitor_irq_mapper irq_mapper (
		.clk        (clk_clk),                        //       clk.clk
		.reset      (rst_controller_reset_out_reset), // clk_reset.reset
		.sender_irq (nios2_processor_irq_irq)         //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
