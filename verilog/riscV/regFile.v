module regFile #(parameter width = 32,parameter addrWidth = 5) (
	input clock,
	input clear,
	input	regWriteEnable,
	input	[addrWidth-1:0]addrA,
	input	[addrWidth-1:0]addrB,
	input [addrWidth-1:0]addrD,
	input [width-1:0]dataD,
	output reg[width-1:0]dataA,
	output reg[width-1:0]dataB
);
	
	//reg [width-1:0]Rin;
	//wire [width-1:0]Rout[width-1:0];
	reg [width-1:0]registers[0:width-1];

	always@(negedge clock)begin
		if(regWriteEnable && (addrD != 5'b0)) 
			registers[addrD] <= dataD;
	end
	
	always@(posedge clock)begin
		dataA <= registers[addrA];
		dataB <= registers[addrB]; 
	end
	
	
	initial begin
			registers[0]=32'b0;
	end

	
	//register r0 (dataD,Rin[0],clock,1'b0,Rout[0]);
	
	//generate
		//genvar i;
		//for(i=1;i<width;i=i+1)begin:r
			//register r (dataD,Rin[i],clock,clear,Rout[i]);
		//end
	//endgenerate
	
	//always@(*)begin
	
	 //dataA = Rout[addrA];
	 //dataB = Rout[addrB];
	 //Rin = regWriteEnable << addrD;

	//end
	

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
