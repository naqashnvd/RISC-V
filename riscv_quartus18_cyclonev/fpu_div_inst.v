fpu_div	fpu_div_inst (
	.aclr ( aclr_sig ),
	.clk_en ( clk_en_sig ),
	.clock ( clock_sig ),
	.dataa ( dataa_sig ),
	.datab ( datab_sig ),
	.division_by_zero ( division_by_zero_sig ),
	.nan ( nan_sig ),
	.overflow ( overflow_sig ),
	.result ( result_sig ),
	.underflow ( underflow_sig ),
	.zero ( zero_sig )
	);
