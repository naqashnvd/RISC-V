
//Data Memory
module DataRAM #(parameter width = 32,parameter addrWidth = 8)(
output [(width)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clock
);
reg [width-1:0] MEM [2**(addrWidth)-1:0];

integer i;
initial begin
for(i=0; i<(2**(addrWidth)-1); i=i+1)
	MEM[i] = 32'b0;
MEM[0]=32'h5;
MEM[6]=32'ha;

end

always @(posedge clock) begin
	if(wren) MEM[ADDR] <= DIN;
end
assign DOUT = MEM[ADDR];
endmodule

