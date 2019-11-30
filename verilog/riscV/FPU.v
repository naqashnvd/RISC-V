module FPU#(parameter width = 32)(
 input [width-1:0]dataA,
 input [width-1:0]dataB,
 input [2:0]func3,
 input [3:0]fpuOp,
 input EX_Rs1_0,
 output reg [width-1:0]fpuResult
 );

 wire [width-1:0]FADD_S,FSUB_S,FMUL_S,FDIV_S,FSIGNJ_S,FSIGNJN_S,FSIGNJX_S,FMIN_S,FMAX_S;
 wire [width-1:0]FSQRT_S,FLE_S,FLT_S,FEQ_S,FCVT_W_S,FCVT_W_SU,FCVT_S_W,FCVT_S_WU;
 
	always@(*)begin
		case(fpuOp)
			4'b0000:	fpuResult = FADD_S;
			4'b0001:	fpuResult = FSUB_S;
			4'b0010:	fpuResult = FMUL_S;
			4'b0011:	fpuResult = FDIV_S;
			4'b0100:	begin
							case(func3[1:0])
								2'b00:	fpuResult = FSIGNJ_S;
								2'b01:	fpuResult = FSIGNJN_S;
								2'b10:	fpuResult = FSIGNJX_S;
								default fpuResult = 32'b0;
							endcase
						end
			4'b0101:	if(~func3[0]) fpuResult = FMIN_S;
						else fpuResult = FMAX_S;
			4'b0110:	fpuResult = FSQRT_S;
			4'b0111:	begin
							case(func3[1:0])
								2'b00:	fpuResult = FLE_S;
								2'b01:	fpuResult = FLT_S;
								2'b10:	fpuResult = FEQ_S;
								default fpuResult = 32'b0;
							endcase
						end
			4'b1000:	if(~EX_Rs1_0) fpuResult = FCVT_W_S;
						else fpuResult = FCVT_W_SU;
			4'b1001:	if(~EX_Rs1_0) fpuResult = FCVT_S_W;
						else fpuResult = FCVT_S_WU;	
		endcase
	end
endmodule
