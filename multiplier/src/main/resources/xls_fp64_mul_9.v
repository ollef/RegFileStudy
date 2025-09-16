module XLSFloatingPointMultiplier_9_core(
  input wire clk,
  input wire [64:0] a,
  input wire [64:0] b,
  output wire [64:0] out
);
  // lint_off MULTIPLY
  function automatic [107:0] umul108b_54b_x_54b (input reg [53:0] lhs, input reg [53:0] rhs);
    begin
      umul108b_54b_x_54b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY

  // ===== Pipe stage 0:

  // Registers for pipe stage 0:
  reg [64:0] p0_a;
  reg [64:0] p0_b;
  always_ff @ (posedge clk) begin
    p0_a <= a;
    p0_b <= b;
  end

  // ===== Pipe stage 1:
  wire p1_literal_592_comb;
  wire [10:0] p1_a_bexp__2_comb;
  wire [10:0] p1_high_exp_comb;
  wire [52:0] p1_a_fraction_comb;
  wire [52:0] p1_literal_598_comb;
  wire [10:0] p1_b_bexp__1_comb;
  wire [52:0] p1_b_fraction_comb;
  wire [10:0] p1_literal_590_comb;
  wire p1_eq_621_comb;
  wire p1_eq_622_comb;
  wire p1_eq_623_comb;
  wire p1_eq_624_comb;
  wire p1_eq_612_comb;
  wire p1_eq_613_comb;
  wire p1_has_0_arg_comb;
  wire p1_has_inf_arg_comb;
  wire p1_literal_591_comb;
  wire p1_is_result_nan_comb;
  wire p1_a_sign_comb;
  wire p1_b_sign_comb;
  wire [53:0] p1_a_fraction__2_comb;
  wire [53:0] p1_b_fraction__2_comb;
  wire p1_result_sign_comb;
  wire p1_nor_616_comb;
  wire [107:0] p1_umul_619_comb;
  wire [11:0] p1_add_620_comb;
  wire p1_result_sign__1_comb;
  assign p1_literal_592_comb = 1'h0;
  assign p1_a_bexp__2_comb = p0_a[63:53];
  assign p1_high_exp_comb = 11'h7ff;
  assign p1_a_fraction_comb = p0_a[52:0];
  assign p1_literal_598_comb = 53'h00_0000_0000_0000;
  assign p1_b_bexp__1_comb = p0_b[63:53];
  assign p1_b_fraction_comb = p0_b[52:0];
  assign p1_literal_590_comb = 11'h000;
  assign p1_eq_621_comb = p1_a_bexp__2_comb == p1_high_exp_comb;
  assign p1_eq_622_comb = p1_a_fraction_comb == p1_literal_598_comb;
  assign p1_eq_623_comb = p1_b_bexp__1_comb == p1_high_exp_comb;
  assign p1_eq_624_comb = p1_b_fraction_comb == p1_literal_598_comb;
  assign p1_eq_612_comb = p1_a_bexp__2_comb == p1_literal_590_comb;
  assign p1_eq_613_comb = p1_b_bexp__1_comb == p1_literal_590_comb;
  assign p1_has_0_arg_comb = p1_eq_612_comb | p1_eq_613_comb;
  assign p1_has_inf_arg_comb = p1_eq_621_comb & p1_eq_622_comb | p1_eq_623_comb & p1_eq_624_comb;
  assign p1_literal_591_comb = 1'h1;
  assign p1_is_result_nan_comb = ~(~p1_eq_621_comb | p1_eq_622_comb) | ~(~p1_eq_623_comb | p1_eq_624_comb) | p1_has_0_arg_comb & p1_has_inf_arg_comb;
  assign p1_a_sign_comb = p0_a[64:64];
  assign p1_b_sign_comb = p0_b[64:64];
  assign p1_a_fraction__2_comb = {p1_literal_591_comb, p1_a_fraction_comb};
  assign p1_b_fraction__2_comb = {p1_literal_591_comb, p1_b_fraction_comb};
  assign p1_result_sign_comb = p1_a_sign_comb ^ p1_b_sign_comb;
  assign p1_nor_616_comb = ~(p1_eq_612_comb | p1_eq_613_comb);
  assign p1_umul_619_comb = umul108b_54b_x_54b(p1_a_fraction__2_comb, p1_b_fraction__2_comb);
  assign p1_add_620_comb = {p1_literal_592_comb, p1_a_bexp__2_comb} + {p1_literal_592_comb, p1_b_bexp__1_comb};
  assign p1_result_sign__1_comb = ~p1_is_result_nan_comb & p1_result_sign_comb;

  // Registers for pipe stage 1:
  reg p1_nor_616;
  reg [107:0] p1_umul_619;
  reg [11:0] p1_add_620;
  reg p1_has_inf_arg;
  reg p1_is_result_nan;
  reg p1_result_sign__1;
  always_ff @ (posedge clk) begin
    p1_nor_616 <= p1_nor_616_comb;
    p1_umul_619 <= p1_umul_619_comb;
    p1_add_620 <= p1_add_620_comb;
    p1_has_inf_arg <= p1_has_inf_arg_comb;
    p1_is_result_nan <= p1_is_result_nan_comb;
    p1_result_sign__1 <= p1_result_sign__1_comb;
  end

  // ===== Pipe stage 2:
  wire [107:0] p2_fraction_comb;
  wire [106:0] p2_literal_594_comb;
  wire [12:0] p2_exp_comb;
  wire [107:0] p2_fraction__1_comb;
  wire [107:0] p2_sticky_comb;
  wire [12:0] p2_exp__1_comb;
  wire [107:0] p2_fraction__2_comb;
  wire [12:0] p2_exp__2_comb;
  wire [12:0] p2_literal_596_comb;
  wire [107:0] p2_fraction__3_comb;
  wire [107:0] p2_sticky__1_comb;
  wire [107:0] p2_fraction__4_comb;
  wire p2_ne_675_comb;
  wire p2_greater_than_half_way_comb;
  wire [52:0] p2_fraction__5_comb;
  wire p2_do_round_up_comb;
  wire [53:0] p2_fraction__6_comb;
  wire [53:0] p2_fraction__7_comb;
  wire [12:0] p2_add_686_comb;
  wire [12:0] p2_exp__3_comb;
  wire [52:0] p2_result_fraction_comb;
  assign p2_fraction_comb = p1_umul_619 & {108{p1_nor_616}};
  assign p2_literal_594_comb = 107'h000_0000_0000_0000_0000_0000_0000;
  assign p2_exp_comb = {p1_literal_592_comb, p1_add_620} + 13'h1c01;
  assign p2_fraction__1_comb = p2_fraction_comb >> p2_fraction_comb[107];
  assign p2_sticky_comb = {p2_literal_594_comb, p2_fraction_comb[0]};
  assign p2_exp__1_comb = p2_exp_comb & {13{p1_nor_616}};
  assign p2_fraction__2_comb = p2_fraction__1_comb | p2_sticky_comb;
  assign p2_exp__2_comb = p2_exp__1_comb + {12'h000, p2_fraction_comb[107]};
  assign p2_literal_596_comb = 13'h0000;
  assign p2_fraction__3_comb = $signed(p2_exp__2_comb) <= $signed(p2_literal_596_comb) ? {p1_literal_592_comb, p2_fraction__2_comb[107:1]} : p2_fraction__2_comb;
  assign p2_sticky__1_comb = {p2_literal_594_comb, p2_fraction__2_comb[0]};
  assign p2_fraction__4_comb = p2_fraction__3_comb | p2_sticky__1_comb;
  assign p2_ne_675_comb = p2_fraction__4_comb[51:0] != 52'h0_0000_0000_0000;
  assign p2_greater_than_half_way_comb = p2_fraction__4_comb[52] & p2_ne_675_comb;
  assign p2_fraction__5_comb = p2_fraction__4_comb[105:53];
  assign p2_do_round_up_comb = p2_greater_than_half_way_comb | ~(~p2_fraction__4_comb[52] | p2_ne_675_comb | ~p2_fraction__4_comb[53]);
  assign p2_fraction__6_comb = {p1_literal_592_comb, p2_fraction__5_comb};
  assign p2_fraction__7_comb = p2_fraction__6_comb + {p1_literal_598_comb, p2_do_round_up_comb};
  assign p2_add_686_comb = p2_exp__2_comb + 13'h0001;
  assign p2_exp__3_comb = p2_fraction__7_comb[53] ? p2_add_686_comb : p2_exp__2_comb;
  assign p2_result_fraction_comb = p2_fraction__7_comb[52:0];

  // Registers for pipe stage 2:
  reg [12:0] p2_exp__3;
  reg p2_has_inf_arg;
  reg p2_is_result_nan;
  reg [52:0] p2_result_fraction;
  reg p2_result_sign__1;
  always_ff @ (posedge clk) begin
    p2_exp__3 <= p2_exp__3_comb;
    p2_has_inf_arg <= p1_has_inf_arg;
    p2_is_result_nan <= p1_is_result_nan;
    p2_result_fraction <= p2_result_fraction_comb;
    p2_result_sign__1 <= p1_result_sign__1;
  end

  // ===== Pipe stage 3:
  wire p3_is_subnormal_comb;
  wire [11:0] p3_result_exp_comb;
  wire [11:0] p3_result_exp__1_comb;
  wire p3_and_reduce_706_comb;
  wire [52:0] p3_result_fraction__3_comb;
  wire [52:0] p3_nan_fraction_comb;
  wire [10:0] p3_result_exp__4_comb;
  wire [52:0] p3_result_fraction__4_comb;
  assign p3_is_subnormal_comb = $signed(p2_exp__3) <= $signed(p2_literal_596_comb);
  assign p3_result_exp_comb = p2_exp__3[11:0];
  assign p3_result_exp__1_comb = p3_result_exp_comb & {12{~p3_is_subnormal_comb}};
  assign p3_and_reduce_706_comb = &p3_result_exp__1_comb[10:0];
  assign p3_result_fraction__3_comb = p2_result_fraction & {53{~(p2_has_inf_arg | p3_result_exp__1_comb[11] | p3_and_reduce_706_comb | p3_is_subnormal_comb)}};
  assign p3_nan_fraction_comb = 53'h10_0000_0000_0000;
  assign p3_result_exp__4_comb = p2_is_result_nan | p2_has_inf_arg | p3_result_exp__1_comb[11] | p3_and_reduce_706_comb ? p1_high_exp_comb : p3_result_exp__1_comb[10:0];
  assign p3_result_fraction__4_comb = p2_is_result_nan ? p3_nan_fraction_comb : p3_result_fraction__3_comb;

  // Registers for pipe stage 3:
  reg p3_result_sign__1;
  reg [10:0] p3_result_exp__4;
  reg [52:0] p3_result_fraction__4;
  always_ff @ (posedge clk) begin
    p3_result_sign__1 <= p2_result_sign__1;
    p3_result_exp__4 <= p3_result_exp__4_comb;
    p3_result_fraction__4 <= p3_result_fraction__4_comb;
  end

  // ===== Pipe stage 4:

  // Registers for pipe stage 4:
  reg p4_result_sign__1;
  reg [10:0] p4_result_exp__4;
  reg [52:0] p4_result_fraction__4;
  always_ff @ (posedge clk) begin
    p4_result_sign__1 <= p3_result_sign__1;
    p4_result_exp__4 <= p3_result_exp__4;
    p4_result_fraction__4 <= p3_result_fraction__4;
  end

  // ===== Pipe stage 5:

  // Registers for pipe stage 5:
  reg p5_result_sign__1;
  reg [10:0] p5_result_exp__4;
  reg [52:0] p5_result_fraction__4;
  always_ff @ (posedge clk) begin
    p5_result_sign__1 <= p4_result_sign__1;
    p5_result_exp__4 <= p4_result_exp__4;
    p5_result_fraction__4 <= p4_result_fraction__4;
  end

  // ===== Pipe stage 6:

  // Registers for pipe stage 6:
  reg p6_result_sign__1;
  reg [10:0] p6_result_exp__4;
  reg [52:0] p6_result_fraction__4;
  always_ff @ (posedge clk) begin
    p6_result_sign__1 <= p5_result_sign__1;
    p6_result_exp__4 <= p5_result_exp__4;
    p6_result_fraction__4 <= p5_result_fraction__4;
  end

  // ===== Pipe stage 7:

  // Registers for pipe stage 7:
  reg p7_result_sign__1;
  reg [10:0] p7_result_exp__4;
  reg [52:0] p7_result_fraction__4;
  always_ff @ (posedge clk) begin
    p7_result_sign__1 <= p6_result_sign__1;
    p7_result_exp__4 <= p6_result_exp__4;
    p7_result_fraction__4 <= p6_result_fraction__4;
  end

  // ===== Pipe stage 8:

  // Registers for pipe stage 8:
  reg p8_result_sign__1;
  reg [10:0] p8_result_exp__4;
  reg [52:0] p8_result_fraction__4;
  always_ff @ (posedge clk) begin
    p8_result_sign__1 <= p7_result_sign__1;
    p8_result_exp__4 <= p7_result_exp__4;
    p8_result_fraction__4 <= p7_result_fraction__4;
  end

  // ===== Pipe stage 9:
  wire [64:0] p9_tuple_750_comb;
  assign p9_tuple_750_comb = {p8_result_sign__1, p8_result_exp__4, p8_result_fraction__4};

  // Registers for pipe stage 9:
  reg [64:0] p9_tuple_750;
  always_ff @ (posedge clk) begin
    p9_tuple_750 <= p9_tuple_750_comb;
  end
  assign out = p9_tuple_750;
endmodule
