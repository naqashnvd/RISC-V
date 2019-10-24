module riscv (input [1:0]KEY,output [9:0]LEDR);

wire [31:0]dataA,dataB,imemAddr,I,aluResult,dmemOut;
reg [31:0]aluB,dataD,pcIn;
wire [4:0]Rs1,Rs2,Rd;
wire [6:0]opcode;
wire [10:0]signals; //CU signals
wire [31:0]immGenOut;
wire branchFromAlu;
wire clock = KEY[0];
wire clear = KEY[1];


assign LEDR[9:0]=dataA[9:0];


register pc(
	.data(pcIn),
	.enable(1'b1),
	.clock(clock),
	.clear(clear),
	.out(imemAddr)
);


always@(*)begin
	if(branchFromAlu&signals[7]) pcIn = (imemAddr+(immGenOut >>> 2));
	else pcIn = imemAddr+1;
end



IRAM imem(
.DOUT(I),
.ADDR(imemAddr[7:0]),
.DIN(32'b0),
.wren(1'b0),
.clear(clear),
.clk(clock)
);





assign opcode = I[6:0];
assign Rd = I[11:7];
assign Rs1 = I[19:15];
assign Rs2 = I[24:20];

regFile rf(
	.clock(~clock),
	.clear(clear),
	.regWriteEnable(signals[4]),
	.addrA(Rs1),
	.addrB(Rs2),
	.addrD(Rd),
	.dataD(dataD),
	.dataA(dataA),
	.dataB(dataB)
);

immGen immGen(
	.I(I),
	.immSel(signals[1:0]),
	.imm(immGenOut) 
);



controlUnit CU(
	.opcode(opcode),
	.signals(signals) //0-1 imm sel , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP
);

always@(*)begin
	if(signals[2]) aluB =  immGenOut;
	else aluB = dataB;
end

alu alu(
 .dataA(dataA),
 .dataB(aluB),
 .func({I[30],I[14:12]}),
 .aluOp(signals[10:8]),
 .aluResult(aluResult),
 .branchFromAlu(branchFromAlu)
);
// data Ram

DataRAM dmem(
.DOUT(dmemOut),
.ADDR(aluResult[7:0]),
.DIN(dataB),
.wren(signals[6]),
.clear(clear),
.clk(clock)
);


always@(*)begin
	if(signals[3]) dataD = dmemOut;
	else dataD = aluResult;
end


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



