module alu(
  input   logic [3:0]   aluop,
  input   logic [7:0]   a,
  input   logic [7:0]   b,
  input   logic         Cy_in,
  output  logic [7:0]   result,
  output  logic [2:0]   SZCy
);

  logic [8:0] result1;  // {carry, result}
  logic S, Zero, Cy;    // Sign, Zero, Carry Flag

  assign result   = result1[7:0];
  assign S        = result1[7];
  assign Zero     = (result1[7:0] == 8'h00) ? 1'b1 : 1'b0;
  assign Cy       = result1[8];
  assign SZCy     = {S, Zero, Cy};

  always_comb
    case (aluop)
      4'b0000:  result1 = a;
      4'b0001:  result1 = b;
      4'b0010:  result1 = ~a;
      4'b0011:  result1 = ~b;
      4'b0100:  result1 = a & b;
      4'b0101:  result1 = a | b;
      4'b0110:  result1 = a ^ b;
      4'b0111:  result1 = 8'b0000_0000;
      4'b1000:  result1 = a + 1'b1;
      4'b1001:  result1 = a - 1'b1;
      4'b1010:  result1 = a + b;
      4'b1011:  result1 = a - b;
      4'b1100:  result1 = a + b + Cy_in;
      4'b1101:  result1 = a - b - Cy_in;
      4'b1110:  result1 = {a, 1'b0};
      4'b1111:  result1 = {2'b00, a[7:1]};
    endcase

endmodule
