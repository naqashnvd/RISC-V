module forwardingUnit(
input MEM_RegWrite,WB_RegWrite,
input MEM_f_RegWrite,WB_f_RegWrite,
input [4:0]MEM_Rd,EX_Rs1,EX_Rs2,EX_frs3,WB_Rd,
input temp_fix, //temperory fix for float store hazard 
output reg [1:0]ForwardA,ForwardB,ForwardC
);

always@(*)begin
/////////////////////////////////////////////////// ALU ///////////////////////////////////////////////////////////////////////////
if(MEM_RegWrite&(MEM_Rd != 5'b0)&(MEM_Rd == EX_Rs1)) ForwardA =2'b10;
else if(WB_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_Rs1)&(~(MEM_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_Rs1)))) ForwardA =2'b01;

////////////////////////////////////////////////// Fpu /////////////////////////////////////////////////////////////////////////////

else if(MEM_f_RegWrite&(MEM_Rd != 5'b0)&(MEM_Rd == EX_Rs1)) ForwardA =2'b10;
else if(WB_f_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_Rs1)&(~(MEM_f_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_Rs1)))) ForwardA =2'b01;
else ForwardA =2'b00;

/////////////////////////////////////////////////// ALU ///////////////////////////////////////////////////////////////////////////

if(MEM_RegWrite&(MEM_Rd != 5'b0)&(MEM_Rd == EX_Rs2)) ForwardB =2'b10;
else if(WB_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_Rs2)&(~(MEM_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_Rs2)))) ForwardB =2'b01;
//else if((~temp_fix)&WB_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_Rs2)&(~(MEM_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_Rs2)))) ForwardB =2'b01;

////////////////////////////////////////////////// Fpu /////////////////////////////////////////////////////////////////////////////
else if(MEM_f_RegWrite&(MEM_Rd != 5'b0)&(MEM_Rd == EX_Rs2)) ForwardB =2'b10;
else if(WB_f_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_Rs2)&(~(MEM_f_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_Rs2)))) ForwardB =2'b01;
else ForwardB = 2'b00;

////////////////////////////////////////////////// Fpu /////////////////////////////////////////////////////////////////////////////

if(MEM_f_RegWrite&(MEM_Rd != 5'b0)&(MEM_Rd == EX_frs3)) ForwardC =2'b10;
else if(WB_f_RegWrite&(WB_Rd != 5'b0)&(WB_Rd == EX_frs3)&(~(MEM_f_RegWrite & (MEM_Rd !=5'b0)&(MEM_Rd == EX_frs3)))) ForwardC =2'b01;
else ForwardC = 2'b00;

end
endmodule
