module FPU#(parameter width = 32)(
 input clock,
 input clear,
 input fpu_sel,
 input [width-1:0]dataA,
 input [width-1:0]dataB,
 input [2:0]func3,
 input [3:0]fpuOp,
 input EX_Rs1_0,
 output reg [width-1:0]fpuResult,
 output reg fpu_inprogress
 );

 wire [width-1:0]FADD_SUB_S,FMUL_S,FDIV_S,FSIGNJ_S,FSIGNJN_S,FSIGNJX_S,FMIN_S,FMAX_S;
 wire [width-1:0]FSQRT_S,FLE_S,FLT_S,FEQ_S,FCVT_W_S,FCVT_W_SU,FCVT_S_W,FCVT_S_WU;
 wire nan_add,overflow_add,underflow_add,zero_add;
 wire nan_mult,overflow_mult,zero_mult,underflow_mult;
 wire division_by_zero,nan_div,overflow_div,underflow_div,zero_div;
 wire nan_sqrt,overflow_sqrt,zero_sqrt;
 wire nan_convert,overflow_convert,underflow_convert;
 
 ///////////////////////////////////////////////////////////// Altera IP's///////////////////////////////////////////////////////////////////////////////
 fpu_add_sub	fpu_add_sub_inst ( // 7 Clock Cycles
	.add_sub ( fpuOp[0] ),
	.clock ( clock ),
	.dataa ( dataA ),
	.datab ( dataB ),
	.nan ( nan_add ),
	.overflow ( overflow_add ),
	.result ( FADD_SUB_S ),
	.underflow ( underflow_add ),
	.zero ( zero_add )
	);
	
	fpu_mult	fpu_mult_inst (  // 5 Clock Cycles
	.clock ( clock ),
	.dataa ( dataA ),
	.datab ( dataB ),
	.nan ( nan_mult ),
	.overflow ( overflow_mult ),
	.result ( FMUL_S ),
	.underflow ( underflow_mult ),
	.zero ( zero_mult )
	);

	fpu_div	fpu_div_inst (	// 6 Clock Cycles
	.clock ( clock ),
	.dataa ( dataA ),
	.datab ( dataB ),
	.division_by_zero ( division_by_zero ),
	.nan ( nan_div ),
	.overflow ( overflow_div ),
	.result ( FDIV_S ),
	.underflow ( underflow_div ),
	.zero ( zero_div )
	);
	
	fpu_compare	fpu_compare_inst ( // 1 Clock Cycle
	.clock ( clock ),
	.dataa ( dataA ),
	.datab ( dataB ),
	.aeb ( FEQ_S[0] ),
	.alb ( FLT_S[0] ),
	.aleb ( FLE_S[0] )
	);
	
	fpu_sqrt	fpu_sqrt_inst ( // 16 Clock Cycles
	.clock ( clock ),
	.data ( dataA ),
	.nan ( nan_sqrt ),
	.overflow ( overflow_sqrt ),
	.result ( FSQRT_S ),
	.zero ( zero_sqrt )
	);
	
	fpu_convert	fpu_convert_inst ( //Integer to Floating Point 6 clock cycles
	.clock ( clock ),
	.dataa ( dataA ),
	.result ( FCVT_W_S )
	);
	
	fpu_convert_float_integer	fpu_convert_float_integer_inst ( //Floating point to Integer 6 clock cycles
	.clock ( clock ),
	.dataa ( dataA ),
	.nan ( nan_convert ),
	.overflow ( overflow_convert ),
	.result ( FCVT_S_W ),
	.underflow ( underflow_convert )
	);
	
	
	
	assign FSIGNJ_S	=	{dataB[31],dataA[30:0]};
	assign FSIGNJN_S	=	{~(dataB[31]),dataA[30:0]};
	assign FSIGNJX_S	=	{(dataB[31]^dataA[31]),dataA[30:0]};
	
	assign FMIN_S = (FLE_S)? dataA : dataB;
	assign FMAX_S = (FLE_S)? dataB : dataA;
	
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
	reg [4:0]cycles; 
	always@(*)begin
		case(fpuOp)
			4'b0000:	begin
							fpuResult = FADD_SUB_S;
							cycles = 5'd7;
						end
			4'b0001:	begin
							fpuResult = FADD_SUB_S;
							cycles = 5'd7;
						end
			4'b0010:	begin	
							fpuResult = FMUL_S;
							cycles = 5'd5;
						end
			4'b0011:	begin	
							fpuResult = FDIV_S;
							cycles = 5'd6;
						end
			4'b0100:	begin
							cycles = 5'd0;
							case(func3[1:0])
								2'b00:	fpuResult = FSIGNJ_S;	
								2'b01:	fpuResult = FSIGNJN_S;	
								2'b10:	fpuResult = FSIGNJX_S;	
								default fpuResult = 32'b0;			
							endcase
						end
			4'b0101: begin
							cycles = 5'd1;
							if(~func3[0]) fpuResult = FMIN_S;		
							else fpuResult = FMAX_S;
						end		
			4'b0110:	begin
							fpuResult = FSQRT_S;
							cycles = 5'd16;
						end
			4'b0111:	begin
							cycles = 5'd1;	
							case(func3[1:0])
								2'b00:	fpuResult = FLE_S;		
								2'b01:	fpuResult = FLT_S;			
								2'b10:	fpuResult = FEQ_S;		
								default fpuResult = 32'b0;			
							endcase
						end
			4'b1000:	begin	
							cycles = 5'd6;
							if(~EX_Rs1_0) fpuResult = FCVT_W_S;		
							else fpuResult = FCVT_W_SU;
						end
			4'b1001:	begin 
							cycles = 5'd6;
							if(~EX_Rs1_0) fpuResult = FCVT_S_W;		
							else fpuResult = FCVT_S_WU;	
						end
			default:	begin
							fpuResult = 32'b0;
							cycles = 5'b0;
						end
		endcase
	end
	
	////////////////////////////////////////////////// FPU Controller ///////////////////////////////////////////////////////////////////////////////////////////////
	
	reg [4:0]count;
	wire temp_clock_reset;
	wire clock_reset;
	always@(*)begin
		if(fpu_sel) begin
			if(count < cycles)	begin
				fpu_inprogress	=	1'b1;
				temp_clock_reset=	1'b1;
			end	
			else begin 
				fpu_inprogress	=	1'b0;
				temp_clock_reset=	1'b0;
			end	
		end
		else 
			fpu_inprogress	=	1'b0;
			temp_clock_reset=	1'b0;
	end
	
	wire clock_reset = clear & temp_clock_reset ;

	always@(posedge clock or negedge clock_reset)begin
		if(~clock_reset) count <= 5'b0;
		else begin
			count <= count+5'b1;
		end
	end
endmodule
