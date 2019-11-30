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
output reg [18:0]signals 
);

///////////////////////////////////CU signals/////////////////////////////////////////////////////////////////////////////////
//0-1 immsel[1:0] ,
//2 AluSrc ,
//3 Mem to Reg ,
//4 RegWrite ,
//5 MemRead ,
//6 MemWrite ,
//7 Branch ,
//8-10 AluOP,
//11 immsel[2] ,
//12 offset to Reg ,
//13 I_jalr , 
//14 unconditionaljump ,
//15 float reg Write ,
//16 regFile dataA Sel ,
//17 regFile dataB Sel ,
//18 aluResult sel 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always@(*)begin
	if(opcode == `RType)			signals = 19'b0000000001000010000;
	else if(opcode == `IType)	signals = 19'b0000000011000010100;
	else if(opcode == `LOAD)	signals = 19'b0000000000000111100;
	else if(opcode == `STORE)	signals = 19'b0000000000001000101;
	else if(opcode == `SBType)	signals = 19'b0000000000110000010;
	else if(opcode == `LUI)		signals = 19'b0000000000000010111;
	else if(opcode == `AUIPC)	signals = 19'b0000001000000010111;
	else if(opcode == `JAL)		signals = 19'b0000101100000011100;
	else if(opcode == `JALR)	signals = 19'b0000111000000011100;
	else signals = 19'h0;
end

endmodule
