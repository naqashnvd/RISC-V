// megafunction wizard: %ALTFP_MULT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_MULT 

// ============================================================
// File Name: fpu_mult.v
// Megafunction Name(s):
// 			ALTFP_MULT
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

module fpu_mult (
	clock,
	dataa,
	datab,
	nan,
	overflow,
	result,
	underflow,
	zero)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	[31:0]  dataa;
	input	[31:0]  datab;
	output	  nan;
	output	  overflow;
	output	[31:0]  result;
	output	  underflow;
	output	  zero;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: FPM_FORMAT STRING "Single"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: DEDICATED_MULTIPLIER_CIRCUITRY STRING "YES"
// Retrieval info: CONSTANT: DENORMAL_SUPPORT STRING "NO"
// Retrieval info: CONSTANT: EXCEPTION_HANDLING STRING "NO"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_mult"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "5"
// Retrieval info: CONSTANT: REDUCED_FUNCTIONALITY STRING "NO"
// Retrieval info: CONSTANT: ROUNDING STRING "TO_NEAREST"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "23"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: dataa 0 0 32 0 INPUT NODEFVAL "dataa[31..0]"
// Retrieval info: CONNECT: @dataa 0 0 32 0 dataa 0 0 32 0
// Retrieval info: USED_PORT: datab 0 0 32 0 INPUT NODEFVAL "datab[31..0]"
// Retrieval info: CONNECT: @datab 0 0 32 0 datab 0 0 32 0
// Retrieval info: USED_PORT: nan 0 0 0 0 OUTPUT NODEFVAL "nan"
// Retrieval info: CONNECT: nan 0 0 0 0 @nan 0 0 0 0
// Retrieval info: USED_PORT: overflow 0 0 0 0 OUTPUT NODEFVAL "overflow"
// Retrieval info: CONNECT: overflow 0 0 0 0 @overflow 0 0 0 0
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: USED_PORT: underflow 0 0 0 0 OUTPUT NODEFVAL "underflow"
// Retrieval info: CONNECT: underflow 0 0 0 0 @underflow 0 0 0 0
// Retrieval info: USED_PORT: zero 0 0 0 0 OUTPUT NODEFVAL "zero"
// Retrieval info: CONNECT: zero 0 0 0 0 @zero 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult.bsf FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult.inc FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpu_mult.cmp FALSE TRUE
// Retrieval info: LIB_FILE: lpm