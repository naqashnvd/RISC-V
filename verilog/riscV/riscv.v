`include "alu.v"
`include "aluSource.v"
`include "controlUnit.v"
`include "forwadingUnit.v"
`include "hdu.v"
`include "immGen.v"
`include "regFile.v"
`include "RAM.v"
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
	wire notStall,branchTaken,flush;
	wire [1:0]forwardA,forwardB;
	wire [31:0]ID_imemAddr,ID_I,I,WB_dmemOut;
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
	assign branchTaken = MEM_branchFromAlu & MEM_signals[7];

	always@(*)begin
		if(branchTaken) pcIn = MEM_branchAddr;
		else pcIn = imemAddr+1;
	end

	register pc(
		.data(pcIn),
		.enable(notStall),
		.clock(clock),
		.clear(clear),
		.out(imemAddr)
	);

	assign flush = clear&~branchTaken;

	RAM imem(
		.DOUT(I),
		.ADDR(imemAddr[7:0]),
		.DIN(32'b0),
		.wren(1'b0),
		.clock(clock)
	);

	//IF_ID 
	register#(.width(64)) IF_ID(
		.data({imemAddr,I}),
		.enable(notStall),
		.clock(clock),
		.clear(flush),
		.out({ID_imemAddr,ID_I})
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
		.clear(flush),
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
	assign EX_branchAddr = ( $signed(EX_imemAddr)+($signed(EX_immGenOut) >>> 2));
	register#(.width(113)) EX_MEM(
		.data({EX_signals,EX_branchAddr,branchFromAlu,aluResult,forwardB_dataB,EX_Rd}),
		.enable(1'b1),
		.clock(clock),
		.clear(clear),
		.out({MEM_signals,MEM_branchAddr,MEM_branchFromAlu,MEM_aluResult,MEM_dataB,MEM_Rd})
	);

	// data Ram
	RAM dmem(
		.DOUT(dmemOut),
		.ADDR(MEM_aluResult[7:0]),
		.DIN(MEM_dataB),
		.wren(MEM_signals[6]),
		.clock(clock)
	);

	//MEM_WB
	register#(.width(80)) MEM_WB(
		.data({MEM_signals,MEM_aluResult,MEM_Rd,dmemOut}),
		.enable(1'b1),
		.clock(clock),
		.clear(clear),
		.out({WB_signals,WB_aluResult,WB_Rd,WB_dmemOut})
	);


	always@(*)begin
		if(WB_signals[3]) dataD = WB_dmemOut;
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








//tb
module tb;
	reg reset,clk;
	riscv riscv0(.KEY({reset,clk}));
	integer i;

	always@(*)begin
		if(riscv0.MEM_aluResult[7:0] == 8'hff) 
			$display("%c",riscv0.MEM_dataB);	
	end

	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);

		$readmemh("imem.hex",riscv0.imem.MEM);
		$readmemh("dmem.hex",riscv0.dmem.MEM);

		for(i = 0; i < 10; i = i + 1)begin
			$dumpvars(1, riscv0.imem.MEM[i]);
			$dumpvars(1, riscv0.dmem.MEM[i]);
			end

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



