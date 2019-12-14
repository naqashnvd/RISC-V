// megafunction wizard: %ALTFP_CONVERT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_CONVERT 

// ============================================================
// File Name: fpu_convert.v
// Megafunction Name(s):
// 			ALTFP_CONVERT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altfp_convert CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Cyclone II" OPERATION="INT2FLOAT" ROUNDING="TO_NEAREST" WIDTH_DATA=32 WIDTH_EXP_INPUT=8 WIDTH_EXP_OUTPUT=8 WIDTH_INT=32 WIDTH_MAN_INPUT=23 WIDTH_MAN_OUTPUT=23 WIDTH_RESULT=32 aclr clk_en clock dataa result
//VERSION_BEGIN 13.0 cbx_altbarrel_shift 2013:06:12:18:03:43:SJ cbx_altfp_convert 2013:06:12:18:03:43:SJ cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_altsyncram 2013:06:12:18:03:43:SJ cbx_cycloneii 2013:06:12:18:03:43:SJ cbx_lpm_abs 2013:06:12:18:03:43:SJ cbx_lpm_add_sub 2013:06:12:18:03:43:SJ cbx_lpm_compare 2013:06:12:18:03:43:SJ cbx_lpm_decode 2013:06:12:18:03:43:SJ cbx_lpm_divide 2013:06:12:18:03:43:SJ cbx_lpm_mux 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ cbx_stratix 2013:06:12:18:03:43:SJ cbx_stratixii 2013:06:12:18:03:43:SJ cbx_stratixiii 2013:06:12:18:03:43:SJ cbx_stratixv 2013:06:12:18:03:43:SJ cbx_util_mgl 2013:06:12:18:03:43:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



//altbarrel_shift CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Cyclone II" PIPELINE=2 SHIFTDIR="LEFT" SHIFTTYPE="LOGICAL" WIDTH=32 WIDTHDIST=5 aclr clk_en clock data distance result
//VERSION_BEGIN 13.0 cbx_altbarrel_shift 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END

//synthesis_resources = reg 68 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altbarrel_shift_brf
	( 
	aclr,
	clk_en,
	clock,
	data,
	distance,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  data;
	input   [4:0]  distance;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[1:0]	dir_pipe;
	reg	[31:0]	sbit_piper1d;
	reg	[31:0]	sbit_piper2d;
	reg	sel_pipec3r1d;
	reg	sel_pipec4r1d;
	wire  [5:0]  dir_w;
	wire  direction_w;
	wire  [15:0]  pad_w;
	wire  [191:0]  sbit_w;
	wire  [4:0]  sel_w;
	wire  [159:0]  smux_w;

	// synopsys translate_off
	initial
		dir_pipe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dir_pipe <= 2'b0;
		else if  (clk_en == 1'b1)   dir_pipe <= {dir_w[4], dir_w[2]};
	// synopsys translate_off
	initial
		sbit_piper1d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper1d <= 32'b0;
		else if  (clk_en == 1'b1)   sbit_piper1d <= smux_w[95:64];
	// synopsys translate_off
	initial
		sbit_piper2d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper2d <= 32'b0;
		else if  (clk_en == 1'b1)   sbit_piper2d <= smux_w[159:128];
	// synopsys translate_off
	initial
		sel_pipec3r1d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipec3r1d <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipec3r1d <= distance[3];
	// synopsys translate_off
	initial
		sel_pipec4r1d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipec4r1d <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipec4r1d <= distance[4];
	assign
		dir_w = {dir_pipe[1], dir_w[3], dir_pipe[0], dir_w[1:0], direction_w},
		direction_w = 1'b0,
		pad_w = {16{1'b0}},
		result = sbit_w[191:160],
		sbit_w = {sbit_piper2d, smux_w[127:96], sbit_piper1d, smux_w[63:0], data},
		sel_w = {sel_pipec4r1d, sel_pipec3r1d, distance[2:0]},
		smux_w = {((({32{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[143:128], pad_w[15:0]}) | ({32{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[159:144]})) | ({32{(~ sel_w[4])}} & sbit_w[159:128])), ((({32{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[119:96], pad_w[7:0]}) | ({32{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[127:104]})) | ({32{(~ sel_w[3])}} & sbit_w[127:96])), ((({32{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[91:64], pad_w[3:0]}) | ({32{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[95:68]})) | ({32{(~ sel_w[2])}} & sbit_w[95:64])), ((({32{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[61:32], pad_w[1:0]}) | ({32{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[63:34]})) | ({32{(~ sel_w[1])}} & sbit_w[63:32])), ((({32{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[30:0], pad_w[0]}) | ({32{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[31:1]})) | ({32{(~ sel_w[0])}} & sbit_w[31:0]))};
endmodule //fpu_convert_altbarrel_shift_brf


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" WIDTH=32 WIDTHAD=5 data q
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=16 WIDTHAD=4 data q zero
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=8 WIDTHAD=3 data q zero
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=4 WIDTHAD=2 data q zero
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=2 WIDTHAD=1 data q zero
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_3e8
	( 
	data,
	q,
	zero) ;
	input   [1:0]  data;
	output   [0:0]  q;
	output   zero;


	assign
		q = {data[1]},
		zero = (~ (data[0] | data[1]));
endmodule //fpu_convert_altpriority_encoder_3e8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_6e8
	( 
	data,
	q,
	zero) ;
	input   [3:0]  data;
	output   [1:0]  q;
	output   zero;

	wire  [0:0]   wire_altpriority_encoder15_q;
	wire  wire_altpriority_encoder15_zero;
	wire  [0:0]   wire_altpriority_encoder16_q;
	wire  wire_altpriority_encoder16_zero;

	fpu_convert_altpriority_encoder_3e8   altpriority_encoder15
	( 
	.data(data[1:0]),
	.q(wire_altpriority_encoder15_q),
	.zero(wire_altpriority_encoder15_zero));
	fpu_convert_altpriority_encoder_3e8   altpriority_encoder16
	( 
	.data(data[3:2]),
	.q(wire_altpriority_encoder16_q),
	.zero(wire_altpriority_encoder16_zero));
	assign
		q = {(~ wire_altpriority_encoder16_zero), ((wire_altpriority_encoder16_zero & wire_altpriority_encoder15_q) | ((~ wire_altpriority_encoder16_zero) & wire_altpriority_encoder16_q))},
		zero = (wire_altpriority_encoder15_zero & wire_altpriority_encoder16_zero);
endmodule //fpu_convert_altpriority_encoder_6e8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_be8
	( 
	data,
	q,
	zero) ;
	input   [7:0]  data;
	output   [2:0]  q;
	output   zero;

	wire  [1:0]   wire_altpriority_encoder13_q;
	wire  wire_altpriority_encoder13_zero;
	wire  [1:0]   wire_altpriority_encoder14_q;
	wire  wire_altpriority_encoder14_zero;

	fpu_convert_altpriority_encoder_6e8   altpriority_encoder13
	( 
	.data(data[3:0]),
	.q(wire_altpriority_encoder13_q),
	.zero(wire_altpriority_encoder13_zero));
	fpu_convert_altpriority_encoder_6e8   altpriority_encoder14
	( 
	.data(data[7:4]),
	.q(wire_altpriority_encoder14_q),
	.zero(wire_altpriority_encoder14_zero));
	assign
		q = {(~ wire_altpriority_encoder14_zero), (({2{wire_altpriority_encoder14_zero}} & wire_altpriority_encoder13_q) | ({2{(~ wire_altpriority_encoder14_zero)}} & wire_altpriority_encoder14_q))},
		zero = (wire_altpriority_encoder13_zero & wire_altpriority_encoder14_zero);
endmodule //fpu_convert_altpriority_encoder_be8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_rf8
	( 
	data,
	q,
	zero) ;
	input   [15:0]  data;
	output   [3:0]  q;
	output   zero;

	wire  [2:0]   wire_altpriority_encoder11_q;
	wire  wire_altpriority_encoder11_zero;
	wire  [2:0]   wire_altpriority_encoder12_q;
	wire  wire_altpriority_encoder12_zero;

	fpu_convert_altpriority_encoder_be8   altpriority_encoder11
	( 
	.data(data[7:0]),
	.q(wire_altpriority_encoder11_q),
	.zero(wire_altpriority_encoder11_zero));
	fpu_convert_altpriority_encoder_be8   altpriority_encoder12
	( 
	.data(data[15:8]),
	.q(wire_altpriority_encoder12_q),
	.zero(wire_altpriority_encoder12_zero));
	assign
		q = {(~ wire_altpriority_encoder12_zero), (({3{wire_altpriority_encoder12_zero}} & wire_altpriority_encoder11_q) | ({3{(~ wire_altpriority_encoder12_zero)}} & wire_altpriority_encoder12_q))},
		zero = (wire_altpriority_encoder11_zero & wire_altpriority_encoder12_zero);
endmodule //fpu_convert_altpriority_encoder_rf8


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=16 WIDTHAD=4 data q
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=8 WIDTHAD=3 data q
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=4 WIDTHAD=2 data q
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=2 WIDTHAD=1 data q
//VERSION_BEGIN 13.0 cbx_altpriority_encoder 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_3v7
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;


	assign
		q = {data[1]};
endmodule //fpu_convert_altpriority_encoder_3v7

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_6v7
	( 
	data,
	q) ;
	input   [3:0]  data;
	output   [1:0]  q;

	wire  [0:0]   wire_altpriority_encoder21_q;
	wire  [0:0]   wire_altpriority_encoder22_q;
	wire  wire_altpriority_encoder22_zero;

	fpu_convert_altpriority_encoder_3v7   altpriority_encoder21
	( 
	.data(data[1:0]),
	.q(wire_altpriority_encoder21_q));
	fpu_convert_altpriority_encoder_3e8   altpriority_encoder22
	( 
	.data(data[3:2]),
	.q(wire_altpriority_encoder22_q),
	.zero(wire_altpriority_encoder22_zero));
	assign
		q = {(~ wire_altpriority_encoder22_zero), ((wire_altpriority_encoder22_zero & wire_altpriority_encoder21_q) | ((~ wire_altpriority_encoder22_zero) & wire_altpriority_encoder22_q))};
endmodule //fpu_convert_altpriority_encoder_6v7

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_bv7
	( 
	data,
	q) ;
	input   [7:0]  data;
	output   [2:0]  q;

	wire  [1:0]   wire_altpriority_encoder19_q;
	wire  [1:0]   wire_altpriority_encoder20_q;
	wire  wire_altpriority_encoder20_zero;

	fpu_convert_altpriority_encoder_6v7   altpriority_encoder19
	( 
	.data(data[3:0]),
	.q(wire_altpriority_encoder19_q));
	fpu_convert_altpriority_encoder_6e8   altpriority_encoder20
	( 
	.data(data[7:4]),
	.q(wire_altpriority_encoder20_q),
	.zero(wire_altpriority_encoder20_zero));
	assign
		q = {(~ wire_altpriority_encoder20_zero), (({2{wire_altpriority_encoder20_zero}} & wire_altpriority_encoder19_q) | ({2{(~ wire_altpriority_encoder20_zero)}} & wire_altpriority_encoder20_q))};
endmodule //fpu_convert_altpriority_encoder_bv7

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_r08
	( 
	data,
	q) ;
	input   [15:0]  data;
	output   [3:0]  q;

	wire  [2:0]   wire_altpriority_encoder17_q;
	wire  [2:0]   wire_altpriority_encoder18_q;
	wire  wire_altpriority_encoder18_zero;

	fpu_convert_altpriority_encoder_bv7   altpriority_encoder17
	( 
	.data(data[7:0]),
	.q(wire_altpriority_encoder17_q));
	fpu_convert_altpriority_encoder_be8   altpriority_encoder18
	( 
	.data(data[15:8]),
	.q(wire_altpriority_encoder18_q),
	.zero(wire_altpriority_encoder18_zero));
	assign
		q = {(~ wire_altpriority_encoder18_zero), (({3{wire_altpriority_encoder18_zero}} & wire_altpriority_encoder17_q) | ({3{(~ wire_altpriority_encoder18_zero)}} & wire_altpriority_encoder18_q))};
endmodule //fpu_convert_altpriority_encoder_r08

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altpriority_encoder_qb6
	( 
	data,
	q) ;
	input   [31:0]  data;
	output   [4:0]  q;

	wire  [3:0]   wire_altpriority_encoder10_q;
	wire  wire_altpriority_encoder10_zero;
	wire  [3:0]   wire_altpriority_encoder9_q;

	fpu_convert_altpriority_encoder_rf8   altpriority_encoder10
	( 
	.data(data[31:16]),
	.q(wire_altpriority_encoder10_q),
	.zero(wire_altpriority_encoder10_zero));
	fpu_convert_altpriority_encoder_r08   altpriority_encoder9
	( 
	.data(data[15:0]),
	.q(wire_altpriority_encoder9_q));
	assign
		q = {(~ wire_altpriority_encoder10_zero), (({4{wire_altpriority_encoder10_zero}} & wire_altpriority_encoder9_q) | ({4{(~ wire_altpriority_encoder10_zero)}} & wire_altpriority_encoder10_q))};
endmodule //fpu_convert_altpriority_encoder_qb6

//synthesis_resources = lpm_add_sub 5 lpm_compare 1 reg 247 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpu_convert_altfp_convert_hvn
	( 
	aclr,
	clk_en,
	clock,
	dataa,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  dataa;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [31:0]   wire_altbarrel_shift5_result;
	wire  [4:0]   wire_altpriority_encoder2_q;
	reg	add_1_adder1_cout_reg;
	reg	[11:0]	add_1_adder1_reg;
	reg	add_1_adder2_cout_reg;
	reg	[11:0]	add_1_adder2_reg;
	reg	add_1_reg;
	reg	[7:0]	exponent_bus_pre_reg;
	reg	[7:0]	exponent_bus_pre_reg2;
	reg	[7:0]	exponent_bus_pre_reg3;
	reg	[30:0]	mag_int_a_reg;
	reg	[30:0]	mag_int_a_reg2;
	reg	[23:0]	mantissa_pre_round_reg;
	reg	[4:0]	priority_encoder_reg;
	reg	[31:0]	result_reg;
	reg	sign_int_a_reg1;
	reg	sign_int_a_reg2;
	reg	sign_int_a_reg3;
	reg	sign_int_a_reg4;
	reg	sign_int_a_reg5;
	wire  [30:0]   wire_add_sub1_result;
	wire  [7:0]   wire_add_sub3_result;
	wire  wire_add_sub6_cout;
	wire  [11:0]   wire_add_sub6_result;
	wire  wire_add_sub7_cout;
	wire  [11:0]   wire_add_sub7_result;
	wire  [7:0]   wire_add_sub8_result;
	wire  wire_cmpr4_alb;
	wire  [11:0]  add_1_adder1_w;
	wire  [11:0]  add_1_adder2_w;
	wire  [23:0]  add_1_adder_w;
	wire  add_1_w;
	wire  [7:0]  bias_value_w;
	wire  [7:0]  const_bias_value_add_width_int_w;
	wire  [7:0]  exceptions_value;
	wire  [7:0]  exponent_bus;
	wire  [7:0]  exponent_bus_pre;
	wire  [7:0]  exponent_output_w;
	wire  [7:0]  exponent_rounded;
	wire  [7:0]  exponent_zero_w;
	wire  guard_bit_w;
	wire  [30:0]  int_a;
	wire  [30:0]  int_a_2s;
	wire  [30:0]  invert_int_a;
	wire  [4:0]  leading_zeroes;
	wire  [30:0]  mag_int_a;
	wire  [22:0]  mantissa_bus;
	wire  mantissa_overflow;
	wire  [23:0]  mantissa_post_round;
	wire  [23:0]  mantissa_pre_round;
	wire  [23:0]  mantissa_rounded;
	wire  max_neg_value_selector;
	wire  [7:0]  max_neg_value_w;
	wire  [7:0]  minus_leading_zero;
	wire  [31:0]  prio_mag_int_a;
	wire  [31:0]  result_w;
	wire  round_bit_w;
	wire  [30:0]  shifted_mag_int_a;
	wire  sign_bus;
	wire  sign_int_a;
	wire  [5:0]  sticky_bit_bus;
	wire  [5:0]  sticky_bit_or_w;
	wire  sticky_bit_w;
	wire  [2:0]  zero_padding_w;

	fpu_convert_altbarrel_shift_brf   altbarrel_shift5
	( 
	.aclr(aclr),
	.clk_en(clk_en),
	.clock(clock),
	.data({1'b0, mag_int_a_reg2}),
	.distance(leading_zeroes),
	.result(wire_altbarrel_shift5_result));
	fpu_convert_altpriority_encoder_qb6   altpriority_encoder2
	( 
	.data(prio_mag_int_a),
	.q(wire_altpriority_encoder2_q));
	// synopsys translate_off
	initial
		add_1_adder1_cout_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) add_1_adder1_cout_reg <= 1'b0;
		else if  (clk_en == 1'b1)   add_1_adder1_cout_reg <= wire_add_sub6_cout;
	// synopsys translate_off
	initial
		add_1_adder1_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) add_1_adder1_reg <= 12'b0;
		else if  (clk_en == 1'b1)   add_1_adder1_reg <= wire_add_sub6_result;
	// synopsys translate_off
	initial
		add_1_adder2_cout_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) add_1_adder2_cout_reg <= 1'b0;
		else if  (clk_en == 1'b1)   add_1_adder2_cout_reg <= wire_add_sub7_cout;
	// synopsys translate_off
	initial
		add_1_adder2_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) add_1_adder2_reg <= 12'b0;
		else if  (clk_en == 1'b1)   add_1_adder2_reg <= wire_add_sub7_result;
	// synopsys translate_off
	initial
		add_1_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) add_1_reg <= 1'b0;
		else if  (clk_en == 1'b1)   add_1_reg <= add_1_w;
	// synopsys translate_off
	initial
		exponent_bus_pre_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exponent_bus_pre_reg <= 8'b0;
		else if  (clk_en == 1'b1)   exponent_bus_pre_reg <= exponent_bus_pre_reg2;
	// synopsys translate_off
	initial
		exponent_bus_pre_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exponent_bus_pre_reg2 <= 8'b0;
		else if  (clk_en == 1'b1)   exponent_bus_pre_reg2 <= exponent_bus_pre_reg3;
	// synopsys translate_off
	initial
		exponent_bus_pre_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exponent_bus_pre_reg3 <= 8'b0;
		else if  (clk_en == 1'b1)   exponent_bus_pre_reg3 <= exponent_bus_pre;
	// synopsys translate_off
	initial
		mag_int_a_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) mag_int_a_reg <= 31'b0;
		else if  (clk_en == 1'b1)   mag_int_a_reg <= mag_int_a;
	// synopsys translate_off
	initial
		mag_int_a_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) mag_int_a_reg2 <= 31'b0;
		else if  (clk_en == 1'b1)   mag_int_a_reg2 <= mag_int_a_reg;
	// synopsys translate_off
	initial
		mantissa_pre_round_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) mantissa_pre_round_reg <= 24'b0;
		else if  (clk_en == 1'b1)   mantissa_pre_round_reg <= mantissa_pre_round;
	// synopsys translate_off
	initial
		priority_encoder_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) priority_encoder_reg <= 5'b0;
		else if  (clk_en == 1'b1)   priority_encoder_reg <= wire_altpriority_encoder2_q;
	// synopsys translate_off
	initial
		result_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) result_reg <= 32'b0;
		else if  (clk_en == 1'b1)   result_reg <= result_w;
	// synopsys translate_off
	initial
		sign_int_a_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_int_a_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_int_a_reg1 <= sign_int_a;
	// synopsys translate_off
	initial
		sign_int_a_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_int_a_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_int_a_reg2 <= sign_int_a_reg1;
	// synopsys translate_off
	initial
		sign_int_a_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_int_a_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_int_a_reg3 <= sign_int_a_reg2;
	// synopsys translate_off
	initial
		sign_int_a_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_int_a_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_int_a_reg4 <= sign_int_a_reg3;
	// synopsys translate_off
	initial
		sign_int_a_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_int_a_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_int_a_reg5 <= sign_int_a_reg4;
	lpm_add_sub   add_sub1
	( 
	.cout(),
	.dataa(invert_int_a),
	.datab(31'b0000000000000000000000000000001),
	.overflow(),
	.result(wire_add_sub1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub1.lpm_direction = "ADD",
		add_sub1.lpm_width = 31,
		add_sub1.lpm_type = "lpm_add_sub",
		add_sub1.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES";
	lpm_add_sub   add_sub3
	( 
	.cout(),
	.dataa(const_bias_value_add_width_int_w),
	.datab(minus_leading_zero),
	.overflow(),
	.result(wire_add_sub3_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub3.lpm_direction = "SUB",
		add_sub3.lpm_width = 8,
		add_sub3.lpm_type = "lpm_add_sub",
		add_sub3.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES";
	lpm_add_sub   add_sub6
	( 
	.cout(wire_add_sub6_cout),
	.dataa(mantissa_pre_round[11:0]),
	.datab(12'b000000000001),
	.overflow(),
	.result(wire_add_sub6_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub6.lpm_direction = "ADD",
		add_sub6.lpm_width = 12,
		add_sub6.lpm_type = "lpm_add_sub",
		add_sub6.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES";
	lpm_add_sub   add_sub7
	( 
	.cout(wire_add_sub7_cout),
	.dataa(mantissa_pre_round[23:12]),
	.datab(12'b000000000001),
	.overflow(),
	.result(wire_add_sub7_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub7.lpm_direction = "ADD",
		add_sub7.lpm_width = 12,
		add_sub7.lpm_type = "lpm_add_sub",
		add_sub7.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES";
	lpm_add_sub   add_sub8
	( 
	.cout(),
	.dataa(exponent_bus_pre_reg),
	.datab(8'b00000001),
	.overflow(),
	.result(wire_add_sub8_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub8.lpm_direction = "ADD",
		add_sub8.lpm_width = 8,
		add_sub8.lpm_type = "lpm_add_sub",
		add_sub8.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES";
	lpm_compare   cmpr4
	( 
	.aeb(),
	.agb(),
	.ageb(),
	.alb(wire_cmpr4_alb),
	.aleb(),
	.aneb(),
	.dataa(exponent_output_w),
	.datab(bias_value_w)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		cmpr4.lpm_representation = "UNSIGNED",
		cmpr4.lpm_width = 8,
		cmpr4.lpm_type = "lpm_compare";
	assign
		add_1_adder1_w = add_1_adder1_reg,
		add_1_adder2_w = (({12{(~ add_1_adder1_cout_reg)}} & mantissa_pre_round_reg[23:12]) | ({12{add_1_adder1_cout_reg}} & add_1_adder2_reg)),
		add_1_adder_w = {add_1_adder2_w, add_1_adder1_w},
		add_1_w = ((((~ guard_bit_w) & round_bit_w) & sticky_bit_w) | (guard_bit_w & round_bit_w)),
		bias_value_w = 8'b01111111,
		const_bias_value_add_width_int_w = 8'b10011101,
		exceptions_value = (({8{(~ max_neg_value_selector)}} & exponent_zero_w) | ({8{max_neg_value_selector}} & max_neg_value_w)),
		exponent_bus = exponent_rounded,
		exponent_bus_pre = (({8{(~ wire_cmpr4_alb)}} & exponent_output_w) | ({8{wire_cmpr4_alb}} & exceptions_value)),
		exponent_output_w = wire_add_sub3_result,
		exponent_rounded = (({8{(~ mantissa_overflow)}} & exponent_bus_pre_reg) | ({8{mantissa_overflow}} & wire_add_sub8_result)),
		exponent_zero_w = {8{1'b0}},
		guard_bit_w = shifted_mag_int_a[7],
		int_a = dataa[30:0],
		int_a_2s = wire_add_sub1_result,
		invert_int_a = (~ int_a),
		leading_zeroes = (~ priority_encoder_reg),
		mag_int_a = (({31{(~ sign_int_a)}} & int_a) | ({31{sign_int_a}} & int_a_2s)),
		mantissa_bus = mantissa_rounded[22:0],
		mantissa_overflow = ((add_1_reg & add_1_adder1_cout_reg) & add_1_adder2_cout_reg),
		mantissa_post_round = add_1_adder_w,
		mantissa_pre_round = shifted_mag_int_a[30:7],
		mantissa_rounded = (({24{(~ add_1_reg)}} & mantissa_pre_round_reg) | ({24{add_1_reg}} & mantissa_post_round)),
		max_neg_value_selector = (wire_cmpr4_alb & sign_int_a_reg2),
		max_neg_value_w = 8'b10011110,
		minus_leading_zero = {zero_padding_w, leading_zeroes},
		prio_mag_int_a = {mag_int_a_reg, 1'b1},
		result = result_reg,
		result_w = {sign_bus, exponent_bus, mantissa_bus},
		round_bit_w = shifted_mag_int_a[6],
		shifted_mag_int_a = wire_altbarrel_shift5_result[30:0],
		sign_bus = sign_int_a_reg5,
		sign_int_a = dataa[31],
		sticky_bit_bus = shifted_mag_int_a[5:0],
		sticky_bit_or_w = {(sticky_bit_or_w[4] | sticky_bit_bus[5]), (sticky_bit_or_w[3] | sticky_bit_bus[4]), (sticky_bit_or_w[2] | sticky_bit_bus[3]), (sticky_bit_or_w[1] | sticky_bit_bus[2]), (sticky_bit_or_w[0] | sticky_bit_bus[1]), sticky_bit_bus[0]},
		sticky_bit_w = sticky_bit_or_w[5],
		zero_padding_w = {3{1'b0}};
endmodule //fpu_convert_altfp_convert_hvn
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module fpu_convert (
	aclr,
	clk_en,
	clock,
	dataa,
	result);

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa;
	output	[31:0]  result;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	fpu_convert_altfp_convert_hvn	fpu_convert_altfp_convert_hvn_component (
				.aclr (aclr),
				.clk_en (clk_en),
				.clock (clock),
				.dataa (dataa),
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_convert"
// Retrieval info: CONSTANT: OPERATION STRING "INT2FLOAT"
// Retrieval info: CONSTANT: ROUNDING STRING "TO_NEAREST"
// Retrieval info: CONSTANT: WIDTH_DATA NUMERIC "32"
// Retrieval info: CONSTANT: WIDTH_EXP_INPUT NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_EXP_OUTPUT NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_INT NUMERIC "32"
// Retrieval info: CONSTANT: WIDTH_MAN_INPUT NUMERIC "23"
// Retrieval info: CONSTANT: WIDTH_MAN_OUTPUT NUMERIC "23"
// Retrieval info: CONSTANT: WIDTH_RESULT NUMERIC "32"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL "aclr"
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: USED_PORT: clk_en 0 0 0 0 INPUT NODEFVAL "clk_en"
// Retrieval info: CONNECT: @clk_en 0 0 0 0 clk_en 0 0 0 0
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: dataa 0 0 32 0 INPUT NODEFVAL "dataa[31..0]"
// Retrieval info: CONNECT: @dataa 0 0 32 0 dataa 0 0 32 0
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert.bsf FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert.inc FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert.cmp FALSE TRUE
// Retrieval info: LIB_FILE: lpm
