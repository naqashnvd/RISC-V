module pc #(parameter width = 32)(
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
			out <= out + 4;
		end
	end
endmodule
