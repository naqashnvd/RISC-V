module riscv#(parameter width = 32)(
 input [width-1:0]dataA,
 input [width-1:0]dataB,
 input [3:0]func,
 input [2:0]aluOp,
 output reg [width-1:0]aluResult,
 output reg branchFromAlu
);
	wire [width-1:0]add;
	wire [width-1:0]sub;
   wire [width-1:0]andd;
	wire [width-1:0]orr;
	wire [width-1:0]xorr;
	
	assign add = dataA + dataB;
	assign sub = dataA - dataB;
	assign andd = dataA & dataB;
	assign orr = dataA | dataB;
	assign xorr = dataA ^ dataB;
	
	always@(*)begin
	
	case(aluOp)
	3'b000: aluResult = add;
	3'b001: aluResult = sub;
	3'b010: begin
		case(func)
		4'b0000: aluResult = add;
		4'b1000:	aluResult = sub;
		4'h4:	aluResult = orr;
		4'h6:	aluResult = xorr;
		4'h7:	aluResult = andd;
		default: aluResult = 32'b0;
		endcase
	end
	default: aluResult = 32'b0;
	
	
	endcase



end



endmodule