//Instruction Memory
module IRAM #(parameter width = 32,parameter addrWidth = 8)(
output [(width)-1:0] DOUT,
input [8-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clock
);
reg [width-1:0] MEM [2**(8)-1:0];
integer i;
initial begin

for(i=0; i<(2**(8)-1); i=i+1)
	MEM[i] = 32'b0;
//Test Codes
MEM[ 0 ]=32'h00002083
;
MEM[ 1 ]=32'h0010a103
;
MEM[ 2 ]=32'h002081b3
;

end

always @(posedge clock) begin
	if(wren) MEM[ADDR] <= DIN;
end
assign DOUT = MEM[ADDR];
endmodule

