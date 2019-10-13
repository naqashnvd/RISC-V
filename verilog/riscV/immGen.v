module immGen#(parameter width = 32)(
	input [width-1:0] I,
	input [1:0] immSel,
	output reg [width-1:0]imm 
);
integer i = 0;
always@(immSel,I)begin
case (immSel)
	2'b00:begin
		imm[11:0] = I[31:20];
		for (i=12;i<32;i=i+1)begin
			imm[i] = I[31];
		end
	end
	2'b01:begin
		imm[4:0] = I[11:7];
		imm[11:5] = I[31:25];
		for (i=12;i<32;i=i+1)begin
			imm[i] = I[31];
		end
	end
	2'b10: begin
		imm[0] = 1'b0;
		imm[4:1]=I[11:8];
		imm[11:5] =I[31:25];
		for (i=12;i<32;i=i+1)begin
			imm[i] = I[31];
		end
	end
	
	default: imm = 32'd0;
endcase

end
endmodule
