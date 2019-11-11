
//Data Memory
module DataRAM #(parameter width = 32,parameter addrWidth = 8)(
output reg [(width)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clear, clk
);
reg [width-1:0] MEM [2**(addrWidth)-1:0];

integer i;
initial begin
for(i=0; i<(2**(addrWidth)-1); i=i+1)
	MEM[i] = 32'b0;
//MEM[0]=32'h1;
//MEM[1]=32'h2;

end

always @(posedge clk or negedge clear) begin
if(~clear) DOUT <=32'b0;
else begin 
	DOUT <= MEM[ADDR];
	if(wren) MEM[ADDR] <= DIN;
end
end
endmodule

