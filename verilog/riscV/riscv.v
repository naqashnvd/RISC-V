module riscv (input [1:0]KEY);

wire [31:0]dataA,dataB,imemAddr,I,aluResult,dmemOut;
reg [31:0]aluB,dataD,pcIn;
wire [4:0]Rs1,Rs2,Rd;
wire [6:0]opcode;
wire [10:0]signals; //CU signals
wire [31:0]immGenOut;
wire branchFromAlu;
wire clock = KEY[0];
wire clear = KEY[1];


pc pc1(
	.data(pcIn),
	.enable(1),
	.clock(~clock),
	.clear(clear),
	.out(imemAddr)
);


always@(*)begin
	if(branchFromAlu&signals[7]) pcIn = imemAddr+immGenOut;
	else pcIn = imemAddr;
end

//single_port_ram imem(
//	.data(),
//	.addr(imemAddr),
//	.we(0), 
//	.clk(clock),
//	.q(I)
//);

IRAM imem(
.DOUT(I),
.ADDR(imemAddr),
.DIN(),
.wren(0),
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


//single_port_ram dmem(
//	.data(),
//	.addr(aluResult),
//	.we(signals[6]), 
//	.clk(clock),
//	.q(dmemOut)
//);

DataRAM dmem(
.DOUT(dmemOut),
.ADDR(aluResult),
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
module IRAM #(parameter width = 8,parameter addrWidth = 8)(
output reg  [(width*4)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width*4)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(addrWidth)-1:0];



integer i;
initial begin
for(i=0; i<(2**(addrWidth)-1); i=i+1)
	MEM[i] = 0;
//{MEM[3],MEM[2],MEM[1],MEM[0]}=32'h00002083;
//{MEM[7],MEM[6],MEM[5],MEM[4]}=32'h00402103;

{MEM[3],MEM[2],MEM[1],MEM[0]}=32'h00a00093;
{MEM[7],MEM[6],MEM[5],MEM[4]}=32'h01400113;
{MEM[11],MEM[10],MEM[9],MEM[8]}=32'h00102023;
{MEM[15],MEM[14],MEM[13],MEM[12]}=32'h00202223;
{MEM[19],MEM[18],MEM[17],MEM[16]}=32'h00002183;
{MEM[23],MEM[22],MEM[21],MEM[20]}=32'h00402203;
{MEM[27],MEM[26],MEM[25],MEM[24]}=32'h004182b3;
{MEM[31],MEM[30],MEM[29],MEM[28]}=32'h004182b3;

end

always @(posedge clk or negedge clear) begin
if(~clear)
DOUT <= 0;
else begin
DOUT <= {MEM[ADDR+3],MEM[ADDR+2],MEM[ADDR+1],MEM[ADDR]};
if(wren)
{MEM[ADDR+3],MEM[ADDR+2],MEM[ADDR+1],MEM[ADDR]} <= DIN;
end
end
endmodule


//Data Memory
module DataRAM #(parameter width = 8,parameter addrWidth = 8)(
output [(width*4)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width*4)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(addrWidth)-1:0];

integer i;
initial begin
for(i=0; i<(2**(addrWidth)-1); i=i+1)
	MEM[i] = 0;
{MEM[3],MEM[2],MEM[1],MEM[0]}=32'h1;
{MEM[7],MEM[6],MEM[5],MEM[4]}=32'h2;


end

always @(posedge clk ) begin
//DOUT <= {MEM[ADDR+3],MEM[ADDR+2],MEM[ADDR+1],MEM[ADDR]};
if(wren) {MEM[ADDR+3],MEM[ADDR+2],MEM[ADDR+1],MEM[ADDR]} <= DIN;
end

assign DOUT = {MEM[ADDR+3],MEM[ADDR+2],MEM[ADDR+1],MEM[ADDR]};

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
end
endmodule



