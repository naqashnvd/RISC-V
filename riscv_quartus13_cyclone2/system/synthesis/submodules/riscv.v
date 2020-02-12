
//`default_nettype none

`timescale 1 ps / 1 ps

//`include "alu.v"
//`include "aluSource.v"
//`include "controlUnit.v"
//`include "forwadingUnit.v"
//`include "hdu.v"
//`include "immGen.v"
//`include "regFile.v"
//`include "DRAM.v"
//`include "IRAM.v"
//`include "mux.v"
//`include "FPU.v"
//`include "FPU_Controller.v"


//module top(input CLOCK_50,input [1:1]KEY,input [0:0]SW,output [6:0]HEX0,output [6:0]HEX1,output [6:0]HEX2,output [6:0]HEX3);
//	wire[31:0]dataOut;
//	
//	riscv_core rv32i(
//	.clk(CLOCK_50),
//	.rst_n(KEY[1]),
//	.dataOut(dataOut)
//	);
//	
//	wire [15:0]sw_dataOut;
//	assign sw_dataOut = (SW)?dataOut[31:16]:dataOut[15:0]; // SW handles to show upper and lower 16 bits
//	sevSegDec s0(sw_dataOut[3:0],HEX0);
//	sevSegDec s1(sw_dataOut[7:4],HEX1);
//	sevSegDec s2(sw_dataOut[11:8],HEX2);
//	sevSegDec s3(sw_dataOut[15:12],HEX3);
//
//endmodule


module riscv_core (
	input clk,
	input rst_n,
	//for JTAG UART
	output [31:0]av_address,
	output av_read_n,
	input  [31:0]av_readdata,
	output av_write_n,
	output [31:0]av_writedata,
	input  av_waitrequest, //stall the pipeline	
	//for demo 
	output [31:0]dataOut
);
	
	wire clock;
	assign clock = clk;
	wire clear;
	assign clear = rst_n;
	wire [31:0]dataA,dataB,imemAddr,aluResult,MEM_aluResult;
	wire [31:0]dataD,dmemOut,pcIn;
	wire [4:0] Rs1,Rs2,Rd,MEM_Rd;
	wire [6:0] opcode;
	wire [19:0]signals,EX_signals,MEM_signals,WB_signals; 
	
		/////////////////////////////////////////CU signals/////////////////////////////////////////////////////////////////////////////////
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
		//18 aluResult sel  ,
		//19 fpuOp 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	wire [31:0]immGenOut;
	wire branchFromAlu;
	wire notStall,branchTaken,flush;
	wire [1:0]forwardA,forwardB,forwardC;
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
	wire [4:0]ID_funct5;
	wire [31:0]next_imemAddr,ID_next_imemAddr,EX_next_imemAddr,MEM_next_imemAddr,WB_next_imemAddr;
	wire fpu_inprogress;
	wire [4:0]frs3,EX_frs3;
	
	assign ID_func3_7 = {ID_I[30],ID_I[14:12]};
	assign branchTaken = (MEM_branchFromAlu && MEM_signals[7]) || MEM_signals[14];
	assign next_imemAddr = imemAddr+1;
	
	assign ID_funct5=ID_I[31:27];
	
	assign frs3 = ID_I[31:27];
	
	wire HEX_display; // for HEX display
	
	/////////////////////////////////////////////// Register for Demo /////////////////////////////////////////////////////
	
	register regOut(
		.data(MEM_dataB),
		.enable(HEX_display),
		.clock(clock),
		.clear(clear),
		.out(dataOut)
	);

	assign HEX_display = (MEM_aluResult == 32'h108)?1:0; //Memory map to HEX display
	
	//////////////////////////////////////////////Jtag Uart /////////////////////////////////////////////////////////////////
	
	

	assign av_address = MEM_aluResult; 
	assign av_read_n = ~(MEM_signals[5] & HEX_display);
	//assign av_readdata =
	assign av_write_n = ~(MEM_signals[6] & HEX_display);
	//assign av_writedata = MEM_dataB;
	assign av_writedata = dataOut;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	pcIn_MUX	pcIn_MUX(
	.pcIn_sel({MEM_signals[13],branchTaken}),
	.in({MEM_aluResult,MEM_branchAddr,next_imemAddr}),
	.out(pcIn)
	);

	register pc(
		.data(pcIn),
		.enable(notStall & ~fpu_inprogress & av_waitrequest  ),
		.clock(clock),
		.clear(clear),
		.out(imemAddr)
	);

	assign flush = clear&~branchTaken;

	IRAM#(.width(32),.addrWidth(9)) imem(
		.DOUT(I),
		.ADDR(imemAddr[8:0]),
		.DIN(32'b0),
		.wren(1'b0),
		.clock(clock)
	);

	////////////////////////////////////////////////////////////////IF_ID /////////////////////////////////////////////////////////////////////////
	register#(.width(96)) IF_ID(
		.data({imemAddr,I,next_imemAddr}),
		.enable(notStall & ~fpu_inprogress & av_waitrequest ),
		.clock(clock),
		.clear(flush),
		.out({ID_imemAddr,ID_I,ID_next_imemAddr})
	);


	assign opcode = ID_I[6:0];
	assign Rd = ID_I[11:7];
	assign Rs1 = ID_I[19:15];
	assign Rs2 = ID_I[24:20];
	
	wire [31:0]EX_x_dataA,EX_x_dataB;

	regFile rf(
		.clock(clock),
		.regWriteEnable(WB_signals[4]),
		.addrA(Rs1),
		.addrB(Rs2),
		.addrD(WB_Rd),
		.dataD(dataD),
		.dataA(EX_x_dataA),
		.dataB(EX_x_dataB)
	);

	immGen immGen(
		.I(ID_I),
		.immSel({signals[11],signals[1:0]}),
		.imm(immGenOut) 
	);

	controlUnit CU(
		.opcode(opcode),
		.funct5(ID_funct5), //for F extension
		.signals(signals) 
	);
	
	/////////////////////////////////////////////////////Floating Point Register///////////////////////////////////////////////////////////
	
	wire [31:0]EX_f_dataA,EX_f_dataB;
	wire [31:0]EX_datafrs3;
	float_regFile float_rf(
		.clock(clock),
		.regWriteEnable(WB_signals[15]), //Float reg Write
		.addrA(Rs1),
		.addrB(Rs2),
		.addrfrs3(frs3),
		.addrD(WB_Rd),
		.dataD(dataD),
		.dataA(EX_f_dataA),
		.dataB(EX_f_dataB),
		.datafrs3(EX_datafrs3)
	);

	assign EX_dataA = (EX_signals[16])? EX_f_dataA : EX_x_dataA;
	assign EX_dataB = (EX_signals[17])? EX_f_dataB : EX_x_dataB;
	
	////////////////////////////////////////////////////////////ID_EX/////////////////////////////////////////////////////////////////////
	reg [19:0]stallSignals;
	always@(*)begin
		if(notStall) stallSignals=signals;
		else stallSignals=20'b0;
	end

	register#(.width(140)) ID_EX(
		.data({stallSignals,ID_imemAddr,immGenOut,ID_func3_7,Rs1,Rs2,frs3,Rd,ID_next_imemAddr}),
		.enable(~fpu_inprogress  & av_waitrequest   ),
		.clock(clock),
		.clear(flush),
		.out({EX_signals,EX_imemAddr,EX_immGenOut,EX_func3_7,EX_Rs1,EX_Rs2,EX_frs3,EX_Rd,EX_next_imemAddr})
	);

	wire [31:0]aluA,aluB,forwardB_dataB,fpuC;
	aluSource aluSource( 
		.EX_dataA(EX_dataA),
		.dataD(dataD),
		.MEM_aluResult(MEM_aluResult),
		.EX_dataB(EX_dataB),
		.EX_datafrs3(EX_datafrs3),
		.EX_immGenOut(EX_immGenOut),
		.forwardA(forwardA),
		.forwardB(forwardB),
		.forwardC(forwardC),
		.aluSourceSel(EX_signals[2]),
		.aluA(aluA),
		.aluB(aluB),
		.fpuC(fpuC),
		.forwardB_dataB(forwardB_dataB)
	);

	///////////////////////////////////////////////////////////// Alu ////////////////////////////////////////////////////////////////////////////////
	wire [31:0]temp_aluResult;
	alu alu(
		.dataA(aluA),
		.dataB(aluB),
		.func(EX_func3_7),
		.aluOp(EX_signals[10:8]),
		.aluResult(temp_aluResult),
		.branchFromAlu(branchFromAlu)
	);
	
	///////////////////////////////////////////////////////// FPU //////////////////////////////////////////////////////////////////////////////////////
	wire [31:0]temp_fpuResult;
	
	
	fpuController fpuController( 
		.clock(clock),
		.clear(clear),
		.fpuOp({EX_signals[19],EX_signals[10:8]}), //{fpuOp,aluOp}
		.fpu_sel(EX_signals[18]), // aluResult Sel -> 1 for fpuResult
		.fpu_inprogress(fpu_inprogress)
	);
	
	 FPU fpu(
		 .clock(clock),
		 .clear(clear),
		 .fpu_sel(EX_signals[18]), // aluResult Sel -> 1 for fpuResult
		 .dataA(aluA),
		 .dataB(aluB),
		 .datafrs3(fpuC),
		 .func3(EX_func3_7[2:0]),
		 .fpuOp({EX_signals[19],EX_signals[10:8]}), //{fpuOp,aluOp}
		 .EX_Rs2_0(EX_Rs2[0]),
		 .fpuResult(temp_fpuResult)
	 );
	 
	 assign aluResult = (EX_signals[18])? temp_fpuResult : temp_aluResult;

	//////////////////////////////////////////////////////////////EX_MEM///////////////////////////////////////////////////////////////////////////////////
	
	assign EX_branchAddr = ( $signed(EX_imemAddr)+($signed(EX_immGenOut) >>> 2)); // for word align instruction memory
	register#(.width(158)) EX_MEM(
		.data({EX_signals,EX_branchAddr,branchFromAlu,aluResult,forwardB_dataB,EX_Rd,EX_func3_7,EX_next_imemAddr}),
		.enable(~fpu_inprogress & av_waitrequest),
		.clock(clock),
		.clear(clear),
		.out({MEM_signals,MEM_branchAddr,MEM_branchFromAlu,MEM_aluResult,MEM_dataB,MEM_Rd,MEM_func3_7,MEM_next_imemAddr})
	);

	//////////////////////////////////////////////////////////// data Ram//////////////////////////////////////////////////////////////////////////////////
	wire [31:0]temp_dmemOut;
	wire [31:0] memOut_MUX_result;
	DRAM#(.width(32),.addrWidth(12)) dmem(
		.DOUT(temp_dmemOut),
		.ADDR(MEM_aluResult[11:0]),
		.DIN(MEM_dataB),
		.wren(MEM_signals[6]),
		.clock(clock),
		.func3(MEM_func3_7[2:0])
	);
	
	
	memOut_MUX memOut_MUX(
		.memOut_sel(MEM_func3_7[2:0]),
		.in(temp_dmemOut),
		.out(memOut_MUX_result)
	);
	
	//assign dmemOut = (HEX_display)?av_readdata:memOut_MUX_result; // to read data from jtag Uart
	assign dmemOut = memOut_MUX_result;
	////////////////////////////////////////////////////////////MEM_WB//////////////////////////////////////////////////////////////////////////////////////////
	wire [31:0]WB_branchAddr;
	register#(.width(153)) MEM_WB(
		.data({MEM_signals,MEM_aluResult,MEM_Rd,dmemOut,MEM_branchAddr,MEM_next_imemAddr}),
		.enable(~fpu_inprogress & av_waitrequest ),
		.clock(clock),
		.clear(clear),
		.out({WB_signals,WB_aluResult,WB_Rd,WB_dmemOut,WB_branchAddr,WB_next_imemAddr})
	);

	WB_MUX WB_MUX(
	.WB_sel({WB_signals[12],WB_signals[3]}),
	.in({WB_next_imemAddr,WB_branchAddr,WB_aluResult,WB_dmemOut}),
	.out(dataD)
	);

	//////////////////////////////////////////////////////////hazard Dectection Unit//////////////////////////////////////////////////////////////////////
	HDU HDU(
		.EX_MemRead(EX_signals[5]),
		.ID_Rs1(Rs1),
		.ID_Rs2(Rs2),
		.EX_Rd(EX_Rd),
		.notStall(notStall)
	);

	/////////////////////////////////////////////////////////////Forwarding Unit/////////////////////////////////////////////////////////////////////////
	forwardingUnit fu(
		.MEM_RegWrite(MEM_signals[4] ),
		.MEM_f_RegWrite(MEM_signals[15]),
		.WB_RegWrite(WB_signals[4]), 
		.WB_f_RegWrite(WB_signals[15]),
		.MEM_Rd(MEM_Rd),
		.EX_Rs1(EX_Rs1),
		.EX_Rs2(EX_Rs2),
		.EX_frs3(EX_frs3),
		.WB_Rd(WB_Rd),
	//	.temp_fix(EX_signals[6] | EX_signals[17]), //temperoray fix for fsw
		.temp_fix(EX_signals[17]),
		.ForwardA(forwardA),
		.ForwardB(forwardB),
		.ForwardC(forwardC)
	);

	
endmodule

////////////////////////////////////////////////////////////Seven Seg Decoder for DE1/////////////////////////////////////////////////////////////
module sevSegDec(input [3:0]bcd,output reg [6:0] seg);
always@(bcd) begin
	case (bcd) 
            4'h0 : seg = 7'b1000000;
            4'h1 : seg = 7'b1111001;
            4'h2 : seg = 7'b0100100;
            4'h3 : seg = 7'b0110000;
            4'h4 : seg = 7'b0011001;
            4'h5 : seg = 7'b0010010;
            4'h6 : seg = 7'b0000010;
            4'h7 : seg = 7'b1111000;
            4'h8 : seg = 7'b0000000;
				4'h9 : seg = 7'b0010000;
            4'hA : seg = 7'b0001000;
				4'hB : seg = 7'b0000011;
				4'hC : seg = 7'b1000110;
				4'hD : seg = 7'b0100001;
				4'hE : seg = 7'b0000110;
				4'hF : seg = 7'b0111000;
				default : seg = 7'b1111111; 
	endcase
end
endmodule


////////////////////////////////////////////////////////////////tb/////////////////////////////////////////////////////////////////////////////////
module tb;
	reg rst_n,clk;
	reg [31:0]av_readdata;
	reg av_waitrequest;
	wire [31:0]av_writedata,dataOut;
	wire av_address,av_read_n,av_write_n;
	
	//wire [31:0]dataOut;
	//riscv_core riscv0(clk,reset,dataOut);
	
	riscv_core riscv0 (
	clk,
	rst_n,
	//for JTAG UART
	av_address,
	av_read_n,
	av_readdata,
	av_write_n,
	av_writedata,
	av_waitrequest,
	dataOut
	);
	
	
	integer i,j;
	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);


//		for(i = 0; i < 32; i = i + 1)begin
//			$dumpvars(0, riscv0.imem.MEM[i]);
//			$dumpvars(0, riscv0.dmem.MEM[i]);
//			$dumpvars(0, riscv0.rf.registers[i]);
//			$dumpvars(0, riscv0.float_rf.registers[i]);
//			end

		$monitor("%h",riscv0.dmem.MEM[264]);	
		//$monitor("%h",riscv0.float_rf.registers[15]);

		#0 rst_n = 1; clk = 0;av_waitrequest = 0;av_readdata = 31'b0;
		#1 rst_n = 0; #1 rst_n = 1 ;#1
		
		for(j = 0;j < 100;j = j + 1) begin
			#1 clk = ~clk; #1 clk = ~clk;
		end
	end
endmodule



