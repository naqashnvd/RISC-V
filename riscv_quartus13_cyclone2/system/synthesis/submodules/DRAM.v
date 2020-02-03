
module DRAM #(parameter width = 32,parameter addrWidth = 8)(
output [(width)-1:0] DOUT,
input [addrWidth-1:0] ADDR,
input [(width)-1:0] DIN,
input wren, clock,
input [2:0]func3
);
reg [width-1:0] MEM [0:2**(addrWidth)-1];


initial begin
	$readmemh("dmem.hex",MEM);
end


always @(posedge clock) begin
	if(wren)begin
		case(func3)
		2'b000:	MEM[ADDR]<=DIN[7:0];
		2'b001: MEM[ADDR]<=DIN[15:0];	
		2'b010:	MEM[ADDR]<=DIN[31:0];
		endcase
	end
end
assign DOUT = MEM[ADDR];
endmodule

