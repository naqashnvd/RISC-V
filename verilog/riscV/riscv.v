
`default_nettype none

`include "alu.v"
`include "aluSource.v"
`include "controlUnit.v"
`include "forwadingUnit.v"
`include "hdu.v"
`include "immGen.v"
`include "regFile.v"
`include "RAM.v"
`include "mux.v"



module riscv (input [1:0]KEY,output [9:0]LEDR);

	wire [31:0]dataA,dataB,imemAddr,aluResult,MEM_aluResult;
	wire [31:0]dataD,dmemOut,pcIn;
	wire [4:0]Rs1,Rs2,Rd,MEM_Rd;
	wire [6:0]opcode;
	wire [14:0]signals,EX_signals,MEM_signals,WB_signals; 
	//CU signals 0-1 immsel[1:0] , 2 AluSrc , 3 Mem to Reg , 4 RegWrite , 5 MemRead , 6 MemWrite , 7 Branch ,8-10 AluOP,11 immsel[2] ,12 offset to Reg , 13 I_jalr , 14 unconditionaljump
	wire [31:0]immGenOut;
	wire branchFromAlu;
	wire clock = KEY[0];
	wire clear = KEY[1];
	wire notStall,branchTaken,flush;
	wire [1:0]forwardA,forwardB;
	wire [31:0]ID_imemAddr,ID_I,I,WB_dmemOut;
	wire [31:0]EX_imemAddr,EX_dataA,EX_dataB,EX_immGenOut;
	wire [3:0]EX_func3_7,MEM_func3_7;
	wire [4:0]EX_Rs1,EX_Rs2,EX_Rd;
	wire [31:0]MEM_branchAddr,MEM_dataB;
	wire MEM_branchFromAlu;
	wire [31:0]EX_branchAddr ;
	wire [31:0]WB_aluResult;
	wire [4:0]WB_Rd;
	wire [3:0]ID_func3_7 ;
	wire [31:0]next_imemAddr,ID_next_imemAddr,EX_next_imemAddr,MEM_next_imemAddr,WB_next_imemAddr;

	assign ID_func3_7 = {ID_I[30],ID_I[14:12]};
	assign LEDR[9:0]=dataD[9:0];
	assign branchTaken = (MEM_branchFromAlu && MEM_signals[7]) || MEM_signals[14];
	assign next_imemAddr = imemAddr+1;
	
	
	pcIn_MUX	pcIn_MUX(
	.pcIn_sel({MEM_signals[13],branchTaken}),
	.in({MEM_aluResult,MEM_branchAddr,next_imemAddr}),
	.out(pcIn)
	);

	register pc(
		.data(pcIn),
		.enable(notStall),
		.clock(clock),
		.clear(clear),
		.out(imemAddr)
	);

	assign flush = clear&~branchTaken;

	RAM#(32,16) imem(
		.DOUT(I),
		.ADDR(imemAddr),
		.DIN(32'b0),
		.wren(1'b0),
		.clock(clock)
	);

	//IF_ID 
	register#(.width(96)) IF_ID(
		.data({imemAddr,I,next_imemAddr}),
		.enable(notStall),
		.clock(clock),
		.clear(flush),
		.out({ID_imemAddr,ID_I,ID_next_imemAddr})
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
		.immSel({signals[11],signals[1:0]}),
		.imm(immGenOut) 
	);

	controlUnit CU(
		.opcode(opcode),
		.signals(signals) 
	);

	//ID_EX
	reg [14:0]stallSignals;
	always@(*)begin
		if(notStall) stallSignals=signals;
		else stallSignals=15'b0;
	end

	register#(.width(194)) ID_EX(
		.data({stallSignals,ID_imemAddr,dataA,dataB,immGenOut,ID_func3_7,Rs1,Rs2,Rd,ID_next_imemAddr}),
		.enable(1'b1),
		.clock(clock),
		.clear(flush),
		.out({EX_signals,EX_imemAddr,EX_dataA,EX_dataB,EX_immGenOut,EX_func3_7,EX_Rs1,EX_Rs2,EX_Rd,EX_next_imemAddr})
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
		.aluSourceSel(EX_signals[2]),
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
	
	assign EX_branchAddr = ( $signed(EX_imemAddr)+($signed(EX_immGenOut) >>> 2)); // for word align memory
	register#(.width(153)) EX_MEM(
		.data({EX_signals,EX_branchAddr,branchFromAlu,aluResult,forwardB_dataB,EX_Rd,EX_func3_7,EX_next_imemAddr}),
		.enable(1'b1),
		.clock(clock),
		.clear(clear),
		.out({MEM_signals,MEM_branchAddr,MEM_branchFromAlu,MEM_aluResult,MEM_dataB,MEM_Rd,MEM_func3_7,MEM_next_imemAddr})
	);

	// data Ram
	wire [31:0]temp_dmemOut;
	RAM dmem(
		.DOUT(temp_dmemOut),
		.ADDR(MEM_aluResult[7:0]),
		.DIN(MEM_dataB),
		.wren(MEM_signals[6]),
		.clock(clock)
	);
	
	
	memOut_MUX memOut_MUX(
		.memOut_sel(MEM_func3_7[2:0]),
		.in(temp_dmemOut),
		.out(dmemOut)
	);
	



	//MEM_WB
	wire [31:0]WB_branchAddr;
	register#(.width(148)) MEM_WB(
		.data({MEM_signals,MEM_aluResult,MEM_Rd,dmemOut,MEM_branchAddr,MEM_next_imemAddr}),
		.enable(1'b1),
		.clock(clock),
		.clear(clear),
		.out({WB_signals,WB_aluResult,WB_Rd,WB_dmemOut,WB_branchAddr,WB_next_imemAddr})
	);

	WB_MUX WB_MUX(
	.WB_sel({WB_signals[12],WB_signals[3]}),
	.in({WB_next_imemAddr,WB_branchAddr,WB_aluResult,WB_dmemOut}),
	.out(dataD)
	);

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
	
	reg [31:0]count = 0;	
	always@(posedge clk)begin
		count <= count + 1;
	end

	integer i,j;
	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);

		$readmemh("imem.hex",riscv0.imem.MEM);
		$readmemh("dmem.hex",riscv0.dmem.MEM);

		for(i = 0; i < 32; i = i + 1)begin
			//$dumpvars(0, riscv0.imem.MEM[i]);
			$dumpvars(0, riscv0.dmem.MEM[i]);
			$dumpvars(0, riscv0.rf.registers[i]);
			end

		//$monitor("%c , %d",riscv0.dmem.MEM[255],count);
		$monitor("%c",riscv0.dmem.MEM[255]);		

		#0 reset = 1; clk = 0;
		#1 reset = 0; #1 reset = 1 ;#1
		
		for(j = 0;j < 100;j = j + 1) begin
			#1 clk = ~clk; #1 clk = ~clk;
		end
	end
endmodule



