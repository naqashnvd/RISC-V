module alu#(parameter width = 32)(
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
	
	wire [2:0]func3 = func[2:0];
	wire func7 = func[3];

	
	assign add = dataA + $signed(dataB);
	assign sub = $signed (dataA) - $signed(dataB);
	assign andd = dataA & dataB;
	assign orr = dataA | dataB;
	assign xorr = dataA ^ dataB;
	
	always@(*)begin
	case(aluOp[1:0])
	2'b00: aluResult = $signed(add);
	2'b01: aluResult = $signed(sub);
	2'b10: begin
		case(func3)
		3'h0: begin
					if(aluOp[2]) aluResult = $signed(add); //for I type
					else
								case(func7)
									1'b0:aluResult = $signed(add); 
									1'b1:aluResult = $signed(sub);
								endcase
				end
		3'h1:	aluResult = dataA << dataB[4:0]; //shift left Logic
		3'h2:	aluResult = $signed(dataA) < $signed(dataB); //set less than signed
		3'h3:	aluResult = dataA < dataB;
		3'h4:	aluResult = xorr;
		3'h5:	begin
					if(aluOp[2])	aluResult = dataA >> dataB[4:0] ; //Shift Right Logic //for I type
					else
									case(func7)
										1'b0:aluResult = dataA >> dataB[4:0] ; //Shift Right Logic
										1'b1:aluResult = $signed(dataA) >>> dataB[4:0] ;//Shift Arthmetic Right 
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
		3'h0:	branchFromAlu = (dataA == dataB);
		3'h1:	branchFromAlu = (dataA != dataB);
		3'h4:	branchFromAlu = ($signed(dataA) < $signed(dataB));
		3'h5:	branchFromAlu = ($signed(dataA) >= $signed(dataB));
		3'h6:	branchFromAlu = (dataA < dataB);	
		3'h7:	branchFromAlu = (dataA >= dataB);
		default:	branchFromAlu = 0;
	endcase
end




endmodule
