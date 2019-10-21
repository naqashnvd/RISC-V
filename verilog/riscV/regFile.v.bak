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
	
	wire clear = 1;
	reg [width-1:0]Rin;
	wire [width-1:0]Rout[0:width-1];
	
	generate
		genvar i;
		for(i=0;i<width;i=i+1)begin:r
		register r (dataD,Rin[i],clock,clear,Rout[i]);
		end
	endgenerate
	
	always@(*)begin
	
	 dataA <= Rout[addrA];
	 dataB <= Rout[addrB];
	 Rin <= regWriteEnable << addrD;

	end
	

endmodule

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
