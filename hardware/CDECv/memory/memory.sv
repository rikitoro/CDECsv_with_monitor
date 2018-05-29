module memory(
  // datapath_core interface
  input   logic         clock,
  input   logic         we,
  input   logic [7:0]   MA,
  input   logic [7:0]   WD,
  output  logic [7:0]   RD,
  // ioport interface
  input   logic [7:0]   iport,
  output  logic [7:0]   oport,
  // programmer (monitor) interface
  input   logic         prg_clock,
  input   logic         prg_we,
  input   logic [7:0]   prg_MA,
  input   logic [7:0]   prg_WD,
  output  logic [7:0]   prg_RD
);


  //// RAM area $0x00~0xFE
  logic  ram_we;
  logic [7:0] ram_RD;


  dualportram dualportram( // On Chip Memory RAM: 2-PORT from IP Library
    .clock_a    (clock),
    .wren_a     (ram_we),
    .address_a  (MA),
    .data_a     (WD),
    .q_a        (ram_RD),
    //
    .clock_b    (prg_clock),
    .wren_b     (prg_we),
    .address_b  (prg_MA),
    .data_b     (prg_WD),
    .q_b        (prg_RD)
  );


  //// IOport $0xFF
  logic io_we;
  logic [7:0] io_RD;

  io_device io_device(
    .clock  (clock),
    .we     (io_we),
    .d      (WD),
    .q      (io_RD),
    .iport  (iport),
    .oport  (oport)
  );


  //// adress decoder
  ////   $0x00-$0xFE : RAM area
  ////   $0xFF       : IOport
  logic  sel_ram_io;

  address_decoder address_decoder(
    .we         (we),
    .MA         (MA),
    .ram_we     (ram_we),
    .io_we      (io_we),
    .sel_ram_io (sel_ram_io)
  );

  mux2 mux_ram_io(
    .sel        (sel_ram_io),
    .d0         (ram_RD),
    .d1         (io_RD),
    .y          (RD)
  );

endmodule
