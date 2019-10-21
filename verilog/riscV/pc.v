module pc #(parameter width = 32)(
	input		[width-1:0]data,
	input		enable,
	input		clock,
	input		clear,
	output reg 	[width-1:0]out
);
	always@(posedge clock or negedge clear)begin
			if(~clear) out <=0;
			else begin 
				if(enable) out <=out + 4;
				else out <=out;
			end
	end
endmodule
