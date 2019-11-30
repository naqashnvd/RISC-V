`define LUI		7'b0110111
`define AUIPC	7'b0010111
`define JAL		7'b1101111
`define JALR	7'b1100111
`define SBType	7'b1100011
`define LOAD	7'b0000011
`define STORE	7'b0100011
`define IType	7'b0010011
`define RType	7'b0110011

`define F_RType	7'b1010011
`define F_LOAD	7'b0000111
`define F_STORE	7'b0100111

module controlUnit(
input [6:0]opcode,
input [4:0]funct5,
output reg [19:0]signals 
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
//18 aluResult sel ,
//19 fpuOp 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always@(*)begin
	if(opcode == `RType)		signals = 20'b00000000001000010000;
	else if(opcode == `IType)	signals = 20'b00000000011000010100;
	else if(opcode == `LOAD)	signals = 20'b00000000000000111100;
	else if(opcode == `STORE)	signals = 20'b00000000000001000101;
	else if(opcode == `SBType)	signals = 20'b00000000000110000010;
	else if(opcode == `LUI)		signals = 20'b00000000000000010111;
	else if(opcode == `AUIPC)	signals = 20'b00000001000000010111;
	else if(opcode == `JAL)		signals = 20'b00000101100000011100;
	else if(opcode == `JALR)	signals = 20'b00000111000000011100;
	
/////////////////////////////////////////// Floating point Instructions ///////////////////////////////////////////////////////
	else if(opcode == `F_RType) begin
			case(funct5)
//////////////////////////////////////////////// Use ALU /////////////////////////////////////////////////////////////////////////
				5'b11110:		signals = 20'b00001000000000000000;	//fmv.s.x	
				5'b11100:		signals = 20'b00010000000000010000;	//fmv.x.s	
/////////////////////////////////////////////// Use FPU //////////////////////////////////////////////////////////////////////////
				5'b00000:		signals = 20'b01111000000000000000; //FADD.S						{fpuOp,aluOp} = 0
				5'b00001:		signals = 20'b01111000000100000000; //FSUB.S						{fpuOp,aluOp} = 1
				5'b00010:		signals = 20'b01111000001000000000; //FMUL.S						{fpuOp,aluOp} = 2
				5'b00011:		signals = 20'b01111000001100000000;	//FDIV.S						{fpuOp,aluOp} = 3
				5'b00100:		signals = 20'b01111000010000000000; //F_Sign_Inject					{fpuOp,aluOp} = 4
				5'b00101:		signals = 20'b01111000010100000000;	//FMIN/FMAX						{fpuOp,aluOp} = 5
				5'b01011:		signals = 20'b01111000011000000000;	//FSQRT.S						{fpuOp,aluOp} = 6
				5'b10100:		signals = 20'b01111000011100000000;	//F_Compare						{fpuOp,aluOp} = 7
				5'b11000:		signals = 20'b11010000000000010000;	//FCVT.w.s	signed and unsigned	{fpuOp,aluOp} = 8
				5'b11010:		signals = 20'b11001000000100000000;	//FCVT.s.w signed and unsigned	{fpuOp,aluOp} = 9
				
				default signals = 20'h0;
			endcase
		end
//////////////////////////////////////////////// Use ALU ////////////////////////////////////////////////////////////////////////////
	else if(opcode == `F_LOAD)	signals = 20'b00001000000000101100;
	else if(opcode == `F_STORE) signals = 20'b00100000000001000101;
	
	else signals = 20'h0;
end

endmodule
