module alu#(parameter width = 32)(
 input [width-1:0]dataA,
 input [width-1:0]dataB,
 input [3:0]func,
 input [2:0]aluOp,
 output reg [width-1:0]aluResult,
 output reg branchFromAlu
);

	wire signed [width-1:0]signDataA = dataA;
	wire signed [width-1:0]signDataB = dataB;
	wire [width-1:0]add;
	wire [width-1:0]sub;
   wire [width-1:0]andd;
	wire [width-1:0]orr;
	wire [width-1:0]xorr;
	
	wire [2:0]func3 = func[2:0];
	wire func7 = func[3];

	
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
		case(func3)
		3'h0: begin
				case(func7)
					1'b0:aluResult = add; 
					1'b1:aluResult = sub;
				endcase
				end
		3'h1:	aluResult = dataA << dataB; //shift left Logic
		3'h2:	aluResult = signDataA < signDataB; //set less than signed
		3'h3:	aluResult = dataA < dataB;
		3'h4:	aluResult = xorr;
		3'h5:	begin
				case(func7)
					1'b0:aluResult = dataA >> dataB ; //Shift Right Logic
					1'b1:aluResult = signDataA >>> dataB ;//Shift Arthmetic Right 
				endcase
				end 
		3'h6:	aluResult = orr;
		3'h7:	aluResult = andd;
		default: aluResult = 32'b0;
		endcase
	end
	default: aluResult = 32'b0;
	endcase
	
	case(func3)
		3'h0: branchFromAlu = (dataA == dataB);
		3'h1: branchFromAlu = ~(dataA == dataB);
		3'h4:	branchFromAlu = (dataA < dataB);
		3'h5:	branchFromAlu = (dataA >= dataB);
		default:	branchFromAlu = 0;
	endcase
end




endmodule
