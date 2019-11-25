module immGen#(parameter width = 32)(
	input [width-1:0] I,
	input [2:0] immSel,
	output reg [width-1:0]imm 
);

always@(*)begin
case (immSel)
	3'b000:	imm = {{21{I[31]}},I[30:25],I[24:21],I[20]};//I-imm
	3'b001:	imm = {{21{I[31]}},I[30:25],I[11:8],I[7]};//S-imm
	3'b010:	imm = {{20{I[31]}},I[7],I[30:25],I[11:8],1'b0};//B-imm
	3'b011:	imm = {I[31:12],{12{1'b0}}}; //U-imm
	3'b100:	imm = {{12{I[31]}},I[19:12],I[20],I[30:21]};//J-imm
	default:	imm = 32'd0;
endcase

end
endmodule
