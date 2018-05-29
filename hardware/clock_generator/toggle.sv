module toggle(
  input   logic   clock_in,
  output  logic   clock_out
);

  always_ff @ (posedge clock_in)
    clock_out <= ~ clock_out;

endmodule
