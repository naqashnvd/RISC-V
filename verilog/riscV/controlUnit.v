`define LUI 7'b0110111
`define AUIPC 7'b0010111
`define JAL 7'b1101111
`define JALR 7'b1100111
`define SBType 7'b1100011
`define LOAD 7'b0000011
`define STORE 7'b0100011
`define IType 7'b0010011
`define RType 7'b0110011

module controlUnit(
input [6:0]opcode,
output reg [14:0]signals 
//CU signals 0-1 immsel[1:0] , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP,11 immsel[2],12 offset to Reg, 13 I_jalr , 14 unconditional jumps
);

always@(*)begin
	if(opcode == `RType)		signals = 15'b000001000010000;
	else if(opcode == `IType)	signals = 15'b000011000010100;
	else if(opcode == `LOAD)	signals = 15'b000000000111100;
	else if(opcode == `STORE)	signals = 15'b000000001000101;
	else if(opcode == `SBType)	signals = 15'b000000110000010;
	else if(opcode == `LUI)		signals = 15'b000000000010111;
	else if(opcode == `AUIPC)	signals = 15'b001000000010111;
	else if(opcode == `JAL)		signals = 15'b101100000011100;
	else if(opcode == `JALR)	signals = 15'b111000000011100;
	else signals = 14'h0;
end

endmodule
