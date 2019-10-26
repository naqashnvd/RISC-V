module forwardingUnit(
input MEM_RegWrite,WB_RegWrite,
input [4:0]MEM_Rd,EX_Rs1,EX_Rs2,WB_Rd,
output reg [1:0]ForwardA,ForwardB
);

always@(*)begin

if(MEM_RegWrite&(~(MEM_Rd == 1'b0))&(MEM_Rd == EX_Rs1)) ForwardA =2'b10;
else if(WB_RegWrite&(~(WB_Rd == 1'b0))&(WB_Rd == EX_Rs1)) ForwardA =2'b01;
else ForwardA =2'b00;

if(MEM_RegWrite&(~(MEM_Rd == 1'b0))&(MEM_Rd == EX_Rs2)) ForwardB =2'b10;
else if(WB_RegWrite&(~(WB_Rd == 1'b0))&(WB_Rd == EX_Rs2)) ForwardB =2'b01;
else ForwardB = 2'b00;

end
endmodule