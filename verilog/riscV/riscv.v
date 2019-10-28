`include "alu.v"
`include "aluSource.v"
`include "controlUnit.v"
`include "forwadingUnit.v"
`include "hdu.v"
`include "immGen.v"
`include "regFile.v"

module riscv (input [1:0]KEY,output [9:0]LEDR);

wire [31:0]dataA,dataB,imemAddr,aluResult,dmemOut,MEM_aluResult;
reg [31:0]dataD,pcIn;
wire [4:0]Rs1,Rs2,Rd,MEM_Rd;
wire [6:0]opcode;
wire [10:0]signals; //CU signals 0-1 imm sel , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP
wire [31:0]immGenOut;
wire branchFromAlu;

wire clock = KEY[0];
wire clear = KEY[1];
wire notStall;
wire [1:0]forwardA,forwardB;

wire [31:0]ID_imemAddr,ID_I;

wire [10:0]EX_signals;
wire [31:0]EX_imemAddr,EX_dataA,EX_dataB,EX_immGenOut;
wire [3:0]EX_func3_7;
wire [4:0]EX_Rs1,EX_Rs2,EX_Rd;

wire [10:0]MEM_signals;
wire [31:0]MEM_branchAddr,MEM_dataB;
wire MEM_branchFromAlu;

wire [31:0]EX_branchAddr ;

wire [10:0] WB_signals;
wire [31:0]WB_aluResult;
wire [4:0]WB_Rd;

wire [3:0]ID_func3_7 ;

assign ID_func3_7 = {ID_I[30],ID_I[14:12]};

assign LEDR[9:0]=dataD[9:0];



wire branchTaken = MEM_branchFromAlu & MEM_signals[7];

always@(*)begin
	if(branchTaken) pcIn = MEM_branchAddr;
	else pcIn = imemAddr+1;
end

register pc(
	.data(pcIn),
	.enable(notStall),
	.clock(~clock),
	.clear(clear),
	.out(imemAddr)
);

IRAM imem(
	.DOUT(ID_I),
	.ADDR(imemAddr[7:0]),
	.DIN(32'b0),
	.wren(1'b0),
	.clear(clear),
	.clk(clock)
);

//IF_ID 


register#(.width(32)) IF_ID(
	.data({imemAddr}),
	.enable(notStall),
	.clock(clock),
	.clear(clear),
	.out({ID_imemAddr})
);


assign opcode = ID_I[6:0];
assign Rd = ID_I[11:7];
assign Rs1 = ID_I[19:15];
assign Rs2 = ID_I[24:20];

regFile rf(
	.clock(~clock),
	.clear(clear),
	.regWriteEnable(WB_signals[4]),
	.addrA(Rs1),
	.addrB(Rs2),
	.addrD(WB_Rd),
	.dataD(dataD),
	.dataA(dataA),
	.dataB(dataB)
);

immGen immGen(
	.I(ID_I),
	.immSel(signals[1:0]),
	.imm(immGenOut) 
);



controlUnit CU(
	.opcode(opcode),
	.signals(signals) //0-1 imm sel , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP
);




//ID_EX

reg [10:0]stallSignals;
always@(*)begin
	if(notStall) stallSignals=signals;
	else stallSignals=10'b0;
end

register#(.width(158)) ID_EX(
	.data({stallSignals,ID_imemAddr,dataA,dataB,immGenOut,ID_func3_7,Rs1,Rs2,Rd}),
	.enable(1'b1),
	.clock(clock),
	.clear(~branchTaken),
	.out({EX_signals,EX_imemAddr,EX_dataA,EX_dataB,EX_immGenOut,EX_func3_7,EX_Rs1,EX_Rs2,EX_Rd})
);

wire [31:0]aluA,aluB,forwardB_dataB;
aluSource aluSource( 
	.EX_dataA(EX_dataA),
	.dataD(dataD),
	.MEM_aluResult(MEM_aluResult),
	.EX_dataB(EX_dataB),
	.EX_immGenOut(EX_immGenOut),
	.forwardA(forwardA),
	.forwardB(forwardB),
	.EX_signals(EX_signals),
	.aluA(aluA),
	.aluB(aluB),
	.forwardB_dataB(forwardB_dataB)
);


alu alu(
 .dataA(aluA),
 .dataB(aluB),
 .func(EX_func3_7),
 .aluOp(EX_signals[10:8]),
 .aluResult(aluResult),
 .branchFromAlu(branchFromAlu)
);


//EX_MEM

assign EX_branchAddr = (EX_imemAddr+(EX_immGenOut >>> 2));
register#(.width(113)) EX_MEM(
	.data({EX_signals,EX_branchAddr,branchFromAlu,aluResult,forwardB_dataB,EX_Rd}),
	.enable(1'b1),
	.clock(clock),
	.clear(clear),
	.out({MEM_signals,MEM_branchAddr,MEM_branchFromAlu,MEM_aluResult,MEM_dataB,MEM_Rd})
);

// data Ram

DataRAM dmem(
.DOUT(dmemOut),
.ADDR(MEM_aluResult[7:0]),
.DIN(MEM_dataB),
.wren(MEM_signals[6]),
.clear(clear),
.clk(clock)
);

//MEM_WB

register#(.width(48)) MEM_WB(
	.data({MEM_signals,MEM_aluResult,MEM_Rd}),
	.enable(1'b1),
	.clock(clock),
	.clear(clear),
	.out({WB_signals,WB_aluResult,WB_Rd})
);


always@(*)begin
	if(WB_signals[3]) dataD = dmemOut;
	else dataD = WB_aluResult;
	
end




//hazard Dectection Unit

HDU HDU(
	.EX_MemRead(EX_signals[5]),
	.ID_Rs1(Rs1),
	.ID_Rs2(Rs2),
	.EX_Rd(EX_Rd),
	.notStall(notStall)
);

//Forwarding Unit
forwardingUnit fu(
	.MEM_RegWrite(MEM_signals[4]),
	.WB_RegWrite(WB_signals[4]),
	.MEM_Rd(MEM_Rd),
	.EX_Rs1(EX_Rs1),
	.EX_Rs2(EX_Rs2),
	.WB_Rd(WB_Rd),
	.ForwardA(forwardA),
	.ForwardB(forwardB)
);

endmodule



//Instruction Memory
module IRAM #(parameter width = 32,parameter addrWidth = 8)(
output reg [(width)-1:0] DOUT,
input [8-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(8)-1:0];
integer i;
initial begin

for(i=0; i<(2**(8)-1); i=i+1)
	MEM[i] = 32'b0;

//MEM[0]=32'h00002083;
//MEM[1]=32'h00402103;
//
// MEM[0]=32'h00a00093;
// MEM[1]=32'h01400113;
// MEM[2]=32'h00102023;
// MEM[3]=32'h00202223;
// MEM[4]=32'h00002183;
// MEM[5]=32'h00402203;
// MEM[7]=32'h004182b3;




// addi x1,x0,1
// addi x2,x0,2
// bne x1,x2,true
// addi x3,x0,1
// true:
//// addi x4,x0,1
MEM[0]=32'h00100093; 
MEM[1]=32'h00200113; 
MEM[2]=32'h00209463; 
MEM[3]=32'h00100193;
MEM[4]=32'h00100213;



//Test Codes
// MEM[0]=32'h00800093;
// MEM[1]=32'h03100293;
// MEM[2]=32'h00500333;
// MEM[3]=32'h00120213;
// MEM[4]=32'hfe415ce3;
// MEM[5]=32'h00000213;
// MEM[6]=32'h00128293;
// MEM[7]=32'h00110113;
// MEM[8]=32'hfe20d4e3;


end

always @(posedge clk or negedge clear) begin
if(~clear) DOUT <=32'b0;
else begin 
	DOUT <= MEM[ADDR];
	if(wren) MEM[ADDR] <= DIN;
end
end
//assign DOUT = MEM[ADDR];

endmodule


//Data Memory
module DataRAM #(parameter width = 32,parameter addrWidth = 8)(
output reg [(width)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(addrWidth)-1:0];

integer i;
initial begin
for(i=0; i<(2**(addrWidth)-1); i=i+1)
	MEM[i] = 32'b0;
//MEM[0]=32'h1;
//MEM[1]=32'h2;

end

always @(posedge clk or negedge clear) begin
if(~clear) DOUT <=32'b0;
else begin 
	DOUT <= MEM[ADDR];
	if(wren) MEM[ADDR] <= DIN;
end
end

//assign DOUT = MEM[ADDR];

endmodule




//tb
module tb;
reg reset,clk;
riscv riscv0(.KEY({reset,clk}));
initial begin
$dumpfile("test.vcd");
$dumpvars(0, tb);

#0 reset = 1; clk = 0;
#1 reset = 0; #1 reset = 1;

#2 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;
#1 clk = ~clk; #1 clk = ~clk;




end
endmodule



