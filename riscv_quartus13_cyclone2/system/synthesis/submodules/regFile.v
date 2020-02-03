//////////////////////////////////////////Float Reg File //////////////////////////////////////////////////////////
module float_regFile #(parameter width = 32,parameter addrWidth = 5) (
	input clock,
	input	regWriteEnable,
	input	[addrWidth-1:0]addrA,
	input	[addrWidth-1:0]addrB,
	input [addrWidth-1:0]addrfrs3,
	input [addrWidth-1:0]addrD,
	input [width-1:0]dataD,
	output reg[width-1:0]dataA,
	output reg[width-1:0]dataB,
	output reg[width-1:0]datafrs3
);
	reg [width-1:0]registers[0:width-1];

	always@(negedge clock)begin
		if(regWriteEnable && (addrD != 5'b0)) 
			registers[addrD] <= dataD;
	end
	
	always@(posedge clock)begin
		dataA <= registers[addrA];
		dataB <= registers[addrB]; 
		datafrs3 <= registers[addrfrs3];
	end
	
	integer i;
	initial begin
		for(i=0;i<32;i=i+1)
			registers[i]=32'b0;
	end
endmodule

////////////////////////////////////////////////// Integer Reg file //////////////////////////////////////////////////////////
module regFile #(parameter width = 32,parameter addrWidth = 5) (
	input clock,
	input	regWriteEnable,
	input	[addrWidth-1:0]addrA,
	input	[addrWidth-1:0]addrB,
	input [addrWidth-1:0]addrD,
	input [width-1:0]dataD,
	output reg[width-1:0]dataA,
	output reg[width-1:0]dataB
);
	reg [width-1:0]registers[0:width-1];

	always@(negedge clock)begin
		if(regWriteEnable && (addrD != 5'b0)) 
			registers[addrD] <= dataD;
	end
	
	always@(posedge clock)begin
		dataA <= registers[addrA];
		dataB <= registers[addrB]; 
	end
	
	integer i;
	initial begin
		for(i=0;i<32;i=i+1)
			registers[i]=32'b0;
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module register #(parameter width = 32)(
	input		[width-1:0]data,
	input		enable,
	input		clock,
	input		clear,
	output reg 	[width-1:0]out
);
	always@(posedge clock or negedge clear)begin
		if(~clear)begin
			out <= 0;
		end
		else if(enable)begin
			out <= data;
		end
	end

endmodule
