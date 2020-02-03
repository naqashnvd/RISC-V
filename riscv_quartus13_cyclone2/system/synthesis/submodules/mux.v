module WB_MUX(
	input [1:0]WB_sel,
	input [127:0]in,
	output reg [31:0]out
);
	wire [31:0]WB_aluResult,WB_dmemOut,WB_branchAddr,WB_next_imemAddr;
	assign WB_dmemOut = in[31:0];
	assign WB_aluResult = in[63:32];
	assign WB_branchAddr = in[95:64];
	assign WB_next_imemAddr = in[127:96];
	always@(*)begin
			case(WB_sel)
				2'b00:	out = WB_aluResult;
				2'b01:	out = WB_dmemOut;
				2'b10:	out = WB_branchAddr;
				2'b11:	out = WB_next_imemAddr;
				default out = 32'b0;
			endcase
		end
endmodule

module memOut_MUX(
	input [2:0]memOut_sel,
	input [31:0]in,
	output reg [31:0]out
);

always@(*)begin
		case(memOut_sel[2:0])
			3'b000:	out = {{24{in[7]}},in[7:0]};	//LB
			3'b001:	out = {{16{in[15]}},in[15:0]};	//LH
			3'b010:	out = in[31:0];	//LW
			3'b100:	out = {{24{1'b0}},in[7:0]};	//LBU
			3'b101:	out = {{16{1'b0}},in[15:0]};	//LHU
			default: out = 32'b0;
		endcase	
	end
endmodule

module pcIn_MUX(
	input[1:0] pcIn_sel,
	input [95:0] in,
	output reg [31:0]out
);
wire [31:0]next_imemAddr,MEM_aluResult,MEM_branchAddr;
assign	next_imemAddr	=	in[31:0];
assign	MEM_branchAddr	=	in[63:32];
assign	MEM_aluResult	=	in[95:64];
always@(*)begin
		case(pcIn_sel)
			2'b00:	out	=	next_imemAddr;
			2'b01:	out	=	MEM_branchAddr;
			2'b11:	out	=	($signed({MEM_aluResult[31:1],1'b0})>>>2); // for word align memory
			default:	out	=	32'b0;
		endcase
	end

endmodule



