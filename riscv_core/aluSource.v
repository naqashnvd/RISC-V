module aluSource( input[31:0]EX_dataA,dataD,MEM_aluResult,EX_dataB,EX_immGenOut,
input [1:0]forwardA,forwardB,
input aluSourceSel,
output reg [31:0]aluA,aluB,forwardB_dataB
);

always@(*)begin
	case (forwardA)
		2'd0: aluA = EX_dataA;
		2'd1: aluA = dataD;
		2'd2: aluA = MEM_aluResult;
		default: aluA = 32'b0;
	endcase
	
	case(forwardB)
		2'd0: forwardB_dataB = EX_dataB;
		2'd1: forwardB_dataB = dataD;
		2'd2: forwardB_dataB = MEM_aluResult;
		default: forwardB_dataB = 32'b0;
	endcase
	
	case (aluSourceSel)
		1'b0: aluB = forwardB_dataB;
		1'b1: aluB = EX_immGenOut;
		default: aluB = 32'b0;
	endcase
	
end
endmodule


