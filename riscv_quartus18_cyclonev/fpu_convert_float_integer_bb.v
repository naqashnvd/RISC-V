// megafunction wizard: %ALTFP_CONVERT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_CONVERT 

// ============================================================
// File Name: fpu_convert_float_integer.v
// Megafunction Name(s):
// 			ALTFP_CONVERT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.0.0 Build 614 04/24/2018 SJ Lite Edition
// ************************************************************

//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.

module fpu_convert_float_integer (
	aclr,
	clk_en,
	clock,
	dataa,
	nan,
	overflow,
	result,
	underflow)/* synthesis synthesis_clearbox = 1 */;

	input	  aclr;
	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa;
	output	  nan;
	output	  overflow;
	output	[31:0]  result;
	output	  underflow;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_convert"
// Retrieval info: CONSTANT: OPERATION STRING "FLOAT2INT"
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
// Retrieval info: USED_PORT: nan 0 0 0 0 OUTPUT NODEFVAL "nan"
// Retrieval info: CONNECT: nan 0 0 0 0 @nan 0 0 0 0
// Retrieval info: USED_PORT: overflow 0 0 0 0 OUTPUT NODEFVAL "overflow"
// Retrieval info: CONNECT: overflow 0 0 0 0 @overflow 0 0 0 0
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: USED_PORT: underflow 0 0 0 0 OUTPUT NODEFVAL "underflow"
// Retrieval info: CONNECT: underflow 0 0 0 0 @underflow 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer.bsf FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer.inc FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_convert_float_integer.cmp FALSE TRUE
// Retrieval info: LIB_FILE: lpm
