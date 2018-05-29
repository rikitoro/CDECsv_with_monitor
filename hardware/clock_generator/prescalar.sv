module prescalar(
  input   logic   clock_in,       // 50 MHz
  output  logic   clock_out_vlf,  // 1.5 Hz   (very low freq)
  output  logic   clock_out_lf,   // 50 Hz    (low freq)
  output  logic   clock_out_hf    // 1.5 kHz  (high freq)
);

  logic [24:0] cnt;

  assign clock_out_vlf = cnt[24];
  assign clock_out_lf  = cnt[19];
  assign clock_out_hf  = cnt[14];

  always_ff @ (posedge clock_in)
    cnt <= cnt + 1'b1;

endmodule
