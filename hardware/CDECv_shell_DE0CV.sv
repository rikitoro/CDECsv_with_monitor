module CDECv_shell_DE0CV(
  // clock
  input   logic         clock_50MHz,

  // reset CDECv and clock generator
  input   logic        n_reset_key,

  // clock generator
  input   logic         clock_manual_key,
  input   logic [1:0]   sel_clock_sw,

  // IO port
  input   logic [3:0]   iport_sw,
  output  logic [7:0]   oport_led,

  // debug signal
  input   logic [2:0]   dbg_addr_sw,
  output  logic [6:0]   dbg_data_hex3,
  output  logic [6:0]   dbg_data_hex2,
  output  logic [6:0]   dbg_data_hex1,
  output  logic [6:0]   dbg_data_hex0,
  output  logic [2:0]   dbg_SZCy_led,
  output  logic         dbg_clock_led,
  output  logic         dbg_F0_led,

  // monitor
  input   logic         n_reset_monitor_key,
  input   logic         uart_rxd,
  output  logic         uart_txd
);

  logic         clock;
  logic         reset;
  logic [15:0]  dbg_data, dbg_data_CDECv;
  logic [2:0]   dbg_SZCy;
  logic         dbg_halt;
  logic         prg_clock, prg_we;
  logic [7:0]   prg_MA, prg_WD, prg_RD;
  logic [15:0]  cycle_count;

  assign reset = ~n_reset_key;


  CDECv CDECv(
  .clock      (clock),
  .reset      (reset),
  // IO port
  .iport      ({4'b0000, iport_sw}),
  .oport      (oport_led),
  // debug signal
  .dbg_addr   (dbg_addr_sw),
  .dbg_data   (dbg_data_CDECv),
  .dbg_SZCy   (dbg_SZCy),
  .dbg_F0     (dbg_F0_led),
  .dbg_halt   (dbg_halt),
  // programmer (monitor) interface
  .prg_clock  (prg_clock),
  .prg_we     (prg_we),
  .prg_MA     (prg_MA),
  .prg_WD     (prg_WD),
  .prg_RD     (prg_RD)
  );


  clock_generator clock_generator(
  .clock_in_50MHz   (clock_50MHz),
  .clock_in_manual  (clock_manual_key),
  .sel              (sel_clock_sw),
  .clock_out        (clock)
  );


  cycle_counter cycle_counter(
  .clock      (clock),
  .reset      (reset),
  .pause      (dbg_halt),
  .count      (cycle_count)
  );

  monitor monitor(
  .clk_clk          (clock_50MHz),          //       clk.clk
  .reset_reset_n    (n_reset_monitor_key),  //     reset.reset_n
  .prg_rd_export    (prg_RD),               //    prg_rd.export
  .prg_wd_export    (prg_WD),               //    prg_wd.export
  .prg_ma_export    (prg_MA),               //    prg_ma.export
  .prg_clock_export (prg_clock),            // prg_clock.export
  .prg_we_export    (prg_we),               //    prg_we.export
  .uart_0_rxd       (uart_rxd),             //    uart_0.rxd
  .uart_0_txd       (uart_txd)              //          .txd
  );


  //// debug

  assign dbg_clock_led = clock;
  assign dbg_SZCy_led = ~ dbg_SZCy;
  assign dbg_data = (dbg_addr_sw == 3'b111) ? cycle_count : dbg_data_CDECv;

  hex_decoder hex_decoder3(
  .num    (dbg_data[15:12]),
  .y      (dbg_data_hex3)
  );

  hex_decoder hex_decoder2(
  .num    (dbg_data[11:8]),
  .y      (dbg_data_hex2)
  );

  hex_decoder hex_decoder1(
  .num    (dbg_data[7:4]),
  .y      (dbg_data_hex1)
  );

  hex_decoder hex_decoder0(
  .num    (dbg_data[3:0]),
  .y      (dbg_data_hex0)
  );

endmodule
