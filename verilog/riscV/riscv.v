module riscv (input clock,input clear);

wire [31:0]dataA,dataB,imemAddr,I,aluResult,dmemOut;
reg [31:0]aluB,dataD,pcIn;
wire [4:0]Rs1,Rs2,Rd;
wire [6:0]opcode;
wire [10:0]signals; //CU signals
wire [31:0]immGenOut;
wire branchFromAlu;

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

single_port_ram imem(
	.data(),
	.addr(imemAddr),
	.we(0), 
	.clk(clock),
	.q(I)
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


single_port_ram dmem(
	.data(),
	.addr(aluResult),
	.we(signals[6]), 
	.clk(clock),
	.q(dmemOut)
);

always@(*)begin
	if(signals[3]) dataD = dmemOut;
	else dataD = aluResult;
end


endmodule








// Quartus II Verilog Template
// Single port RAM with single read/write address 

module single_port_ram 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];

endmodule
