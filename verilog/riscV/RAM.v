
module RAM #(parameter width = 32,parameter addrWidth = 8)(
output [(width)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clock
);
reg [width-1:0] MEM [0:2**(addrWidth)-1];

integer i;
initial begin
	for(i=0;i<2**(addrWidth);i=i+1) MEM[i]=0;
end

always @(posedge clock) begin
	if(wren) MEM[ADDR] <= DIN;
end
assign DOUT = MEM[ADDR];
endmodule

