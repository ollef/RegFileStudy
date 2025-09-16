module XLSFloatingPointMultiplier_1_core(
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
  wire [10:0] p1_a_bexp__2_comb;
  wire [10:0] p1_literal_590_comb;
  wire [10:0] p1_b_bexp__1_comb;
  wire p1_literal_591_comb;
  wire [52:0] p1_a_fraction_comb;
  wire [52:0] p1_b_fraction_comb;
  wire p1_eq_612_comb;
  wire p1_eq_613_comb;
  wire p1_literal_592_comb;
  wire [53:0] p1_a_fraction__2_comb;
  wire [53:0] p1_b_fraction__2_comb;
  wire p1_nor_616_comb;
  wire [107:0] p1_umul_619_comb;
  wire [11:0] p1_add_621_comb;
  wire [107:0] p1_fraction_comb;
  wire [106:0] p1_literal_594_comb;
  wire [12:0] p1_exp_comb;
  wire [107:0] p1_fraction__1_comb;
  wire [107:0] p1_sticky_comb;
  wire [12:0] p1_exp__1_comb;
  wire [107:0] p1_fraction__2_comb;
  wire [12:0] p1_exp__2_comb;
  wire [12:0] p1_literal_596_comb;
  wire [107:0] p1_fraction__3_comb;
  wire [107:0] p1_sticky__1_comb;
  wire [107:0] p1_fraction__4_comb;
  wire p1_ne_644_comb;
  wire p1_greater_than_half_way_comb;
  wire [52:0] p1_fraction__5_comb;
  wire [52:0] p1_literal_598_comb;
  wire p1_do_round_up_comb;
  wire [53:0] p1_fraction__6_comb;
  wire [53:0] p1_fraction__7_comb;
  wire [12:0] p1_add_655_comb;
  wire [12:0] p1_exp__3_comb;
  wire p1_is_subnormal_comb;
  wire [10:0] p1_high_exp_comb;
  wire [11:0] p1_result_exp_comb;
  wire p1_eq_661_comb;
  wire p1_eq_662_comb;
  wire p1_eq_663_comb;
  wire p1_eq_664_comb;
  wire [11:0] p1_result_exp__1_comb;
  wire p1_has_inf_arg_comb;
  wire p1_and_reduce_671_comb;
  wire p1_has_0_arg_comb;
  wire p1_is_result_nan_comb;
  wire p1_a_sign_comb;
  wire p1_b_sign_comb;
  wire [52:0] p1_result_fraction_comb;
  wire p1_result_sign_comb;
  wire [52:0] p1_result_fraction__3_comb;
  wire [52:0] p1_nan_fraction_comb;
  wire p1_result_sign__1_comb;
  wire [10:0] p1_result_exp__4_comb;
  wire [52:0] p1_result_fraction__4_comb;
  wire [64:0] p1_tuple_692_comb;
  assign p1_a_bexp__2_comb = p0_a[63:53];
  assign p1_literal_590_comb = 11'h000;
  assign p1_b_bexp__1_comb = p0_b[63:53];
  assign p1_literal_591_comb = 1'h1;
  assign p1_a_fraction_comb = p0_a[52:0];
  assign p1_b_fraction_comb = p0_b[52:0];
  assign p1_eq_612_comb = p1_a_bexp__2_comb == p1_literal_590_comb;
  assign p1_eq_613_comb = p1_b_bexp__1_comb == p1_literal_590_comb;
  assign p1_literal_592_comb = 1'h0;
  assign p1_a_fraction__2_comb = {p1_literal_591_comb, p1_a_fraction_comb};
  assign p1_b_fraction__2_comb = {p1_literal_591_comb, p1_b_fraction_comb};
  assign p1_nor_616_comb = ~(p1_eq_612_comb | p1_eq_613_comb);
  assign p1_umul_619_comb = umul108b_54b_x_54b(p1_a_fraction__2_comb, p1_b_fraction__2_comb);
  assign p1_add_621_comb = {p1_literal_592_comb, p1_a_bexp__2_comb} + {p1_literal_592_comb, p1_b_bexp__1_comb};
  assign p1_fraction_comb = p1_umul_619_comb & {108{p1_nor_616_comb}};
  assign p1_literal_594_comb = 107'h000_0000_0000_0000_0000_0000_0000;
  assign p1_exp_comb = {p1_literal_592_comb, p1_add_621_comb} + 13'h1c01;
  assign p1_fraction__1_comb = p1_fraction_comb >> p1_fraction_comb[107];
  assign p1_sticky_comb = {p1_literal_594_comb, p1_fraction_comb[0]};
  assign p1_exp__1_comb = p1_exp_comb & {13{p1_nor_616_comb}};
  assign p1_fraction__2_comb = p1_fraction__1_comb | p1_sticky_comb;
  assign p1_exp__2_comb = p1_exp__1_comb + {12'h000, p1_fraction_comb[107]};
  assign p1_literal_596_comb = 13'h0000;
  assign p1_fraction__3_comb = $signed(p1_exp__2_comb) <= $signed(p1_literal_596_comb) ? {p1_literal_592_comb, p1_fraction__2_comb[107:1]} : p1_fraction__2_comb;
  assign p1_sticky__1_comb = {p1_literal_594_comb, p1_fraction__2_comb[0]};
  assign p1_fraction__4_comb = p1_fraction__3_comb | p1_sticky__1_comb;
  assign p1_ne_644_comb = p1_fraction__4_comb[51:0] != 52'h0_0000_0000_0000;
  assign p1_greater_than_half_way_comb = p1_fraction__4_comb[52] & p1_ne_644_comb;
  assign p1_fraction__5_comb = p1_fraction__4_comb[105:53];
  assign p1_literal_598_comb = 53'h00_0000_0000_0000;
  assign p1_do_round_up_comb = p1_greater_than_half_way_comb | ~(~p1_fraction__4_comb[52] | p1_ne_644_comb | ~p1_fraction__4_comb[53]);
  assign p1_fraction__6_comb = {p1_literal_592_comb, p1_fraction__5_comb};
  assign p1_fraction__7_comb = p1_fraction__6_comb + {p1_literal_598_comb, p1_do_round_up_comb};
  assign p1_add_655_comb = p1_exp__2_comb + 13'h0001;
  assign p1_exp__3_comb = p1_fraction__7_comb[53] ? p1_add_655_comb : p1_exp__2_comb;
  assign p1_is_subnormal_comb = $signed(p1_exp__3_comb) <= $signed(p1_literal_596_comb);
  assign p1_high_exp_comb = 11'h7ff;
  assign p1_result_exp_comb = p1_exp__3_comb[11:0];
  assign p1_eq_661_comb = p1_a_bexp__2_comb == p1_high_exp_comb;
  assign p1_eq_662_comb = p1_a_fraction_comb == p1_literal_598_comb;
  assign p1_eq_663_comb = p1_b_bexp__1_comb == p1_high_exp_comb;
  assign p1_eq_664_comb = p1_b_fraction_comb == p1_literal_598_comb;
  assign p1_result_exp__1_comb = p1_result_exp_comb & {12{~p1_is_subnormal_comb}};
  assign p1_has_inf_arg_comb = p1_eq_661_comb & p1_eq_662_comb | p1_eq_663_comb & p1_eq_664_comb;
  assign p1_and_reduce_671_comb = &p1_result_exp__1_comb[10:0];
  assign p1_has_0_arg_comb = p1_eq_612_comb | p1_eq_613_comb;
  assign p1_is_result_nan_comb = ~(~p1_eq_661_comb | p1_eq_662_comb) | ~(~p1_eq_663_comb | p1_eq_664_comb) | p1_has_0_arg_comb & p1_has_inf_arg_comb;
  assign p1_a_sign_comb = p0_a[64:64];
  assign p1_b_sign_comb = p0_b[64:64];
  assign p1_result_fraction_comb = p1_fraction__7_comb[52:0];
  assign p1_result_sign_comb = p1_a_sign_comb ^ p1_b_sign_comb;
  assign p1_result_fraction__3_comb = p1_result_fraction_comb & {53{~(p1_has_inf_arg_comb | p1_result_exp__1_comb[11] | p1_and_reduce_671_comb | p1_is_subnormal_comb)}};
  assign p1_nan_fraction_comb = 53'h10_0000_0000_0000;
  assign p1_result_sign__1_comb = ~p1_is_result_nan_comb & p1_result_sign_comb;
  assign p1_result_exp__4_comb = p1_is_result_nan_comb | p1_has_inf_arg_comb | p1_result_exp__1_comb[11] | p1_and_reduce_671_comb ? p1_high_exp_comb : p1_result_exp__1_comb[10:0];
  assign p1_result_fraction__4_comb = p1_is_result_nan_comb ? p1_nan_fraction_comb : p1_result_fraction__3_comb;
  assign p1_tuple_692_comb = {p1_result_sign__1_comb, p1_result_exp__4_comb, p1_result_fraction__4_comb};

  // Registers for pipe stage 1:
  reg [64:0] p1_tuple_692;
  always_ff @ (posedge clk) begin
    p1_tuple_692 <= p1_tuple_692_comb;
  end
  assign out = p1_tuple_692;
endmodule
