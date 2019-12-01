module HDU(
input EX_MemRead,
input [4:0]ID_Rs1,ID_Rs2,EX_Rd,
output notStall
);

assign notStall = ((~(((ID_Rs1 == EX_Rd )|(ID_Rs2 == EX_Rd)) & EX_MemRead))& 1'b1 );

endmodule