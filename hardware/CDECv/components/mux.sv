
module mux2 # (parameter N = 8) (
  input   logic           sel,
  input   logic [N-1:0]   d0,
  input   logic [N-1:0]   d1,
  output  logic [N-1:0]   y
);

  assign y = sel ?  d1 : d0;

endmodule

//

module mux4 # (parameter N = 8) (
  input   logic [1:0]     sel,
  input   logic [N-1:0]   d0,
  input   logic [N-1:0]   d1,
  input   logic [N-1:0]   d2,
  input   logic [N-1:0]   d3,
  output  logic [N-1:0]   y
);

  always_comb
    case (sel)
      2'b00:  y = d0;
      2'b01:  y = d1;
      2'b10:  y = d2;
      2'b11:  y = d3;
    endcase

endmodule

//

module mux8 # (parameter N = 8) (
  input   logic   [2:0]     sel,
  input   logic   [N-1:0]   d0,
  input   logic   [N-1:0]   d1,
  input   logic   [N-1:0]   d2,
  input   logic   [N-1:0]   d3,
  input   logic   [N-1:0]   d4,
  input   logic   [N-1:0]   d5,
  input   logic   [N-1:0]   d6,
  input   logic   [N-1:0]   d7,
  output  logic   [N-1:0]   y
);

  always_comb
    case (sel)
      3'b000:  y = d0;
      3'b001:  y = d1;
      3'b010:  y = d2;
      3'b011:  y = d3;
      3'b100:  y = d4;
      3'b101:  y = d5;
      3'b110:  y = d6;
      3'b111:  y = d7;
    endcase

endmodule

//

module mux16 # (parameter N = 8) (
  input   logic   [3:0]     sel,
  input   logic   [N-1:0]   d0,
  input   logic   [N-1:0]   d1,
  input   logic   [N-1:0]   d2,
  input   logic   [N-1:0]   d3,
  input   logic   [N-1:0]   d4,
  input   logic   [N-1:0]   d5,
  input   logic   [N-1:0]   d6,
  input   logic   [N-1:0]   d7,
  input   logic   [N-1:0]   d8,
  input   logic   [N-1:0]   d9,
  input   logic   [N-1:0]   d10,
  input   logic   [N-1:0]   d11,
  input   logic   [N-1:0]   d12,
  input   logic   [N-1:0]   d13,
  input   logic   [N-1:0]   d14,
  input   logic   [N-1:0]   d15,
  output  logic   [N-1:0]   y
);

  always_comb
    case (sel)
      4'b0000:  y = d0;
      4'b0001:  y = d1;
      4'b0010:  y = d2;
      4'b0011:  y = d3;
      4'b0100:  y = d4;
      4'b0101:  y = d5;
      4'b0110:  y = d6;
      4'b0111:  y = d7;
      4'b1000:  y = d8;
      4'b1001:  y = d9;
      4'b1010:  y = d10;
      4'b1011:  y = d11;
      4'b1100:  y = d12;
      4'b1101:  y = d13;
      4'b1110:  y = d14;
      4'b1111:  y = d15;
    endcase

endmodule
