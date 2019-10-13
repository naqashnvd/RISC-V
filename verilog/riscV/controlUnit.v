module controlUnit(
input [6:0]opcode,
output reg [10:0]signals //0-1 imm sel , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP
);

always@(*)begin
	if(opcode == 7'h33) signals = 11'h210;
	else if(opcode == 7'h13) signals = 11'h214;
	else if(opcode == 7'h03) signals = 11'h03d;
	else if(opcode == 7'h23) signals = 11'h045;
	else if(opcode == 7'h63) signals = 11'h482;
	else signals = 11'h0;
end

endmodule