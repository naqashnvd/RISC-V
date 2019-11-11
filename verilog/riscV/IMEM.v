//Instruction Memory
module IRAM #(parameter width = 32,parameter addrWidth = 8)(
output reg [(width)-1:0] DOUT,
input [8-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(8)-1:0];
integer i;
initial begin

for(i=0; i<(2**(8)-1); i=i+1)
	MEM[i] = 32'b0;
//Test Codes
MEM[ 0 ]=32'h00100093
;
MEM[ 1 ]=32'h00200113
;
MEM[ 2 ]=32'h402081b3
;
MEM[ 3 ]=32'h00208233
;

end

always @(posedge clk or negedge clear) begin
if(~clear) DOUT <=32'b0;
else begin 
	DOUT <= MEM[ADDR];
	if(wren) MEM[ADDR] <= DIN;
end
end
endmodule

