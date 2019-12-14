module fpuController(input clock,
	input clear,
	input [3:0]fpuOp,
	input fpu_sel,
	output reg fpu_inprogress
);
	reg [4:0]count;
	wire clock_reset;
	reg [4:0]cycles;
	/////////////////////////////////////////////////// Cycles //////////////////////////////////////////////////////////////////////////////
		always@(*)begin
		case(fpuOp)
			4'b0000:	begin
							cycles = 5'd7;
						end
			4'b0001:	begin
							cycles = 5'd7;
						end
			4'b0010:	begin	
							cycles = 5'd5;
						end
			4'b0011:	begin	
							cycles = 5'd6;
						end
			4'b0100:	begin
							cycles = 5'd0;
						end
			4'b0101: begin
							cycles = 5'd1;
						end		
			4'b0110:	begin
							cycles = 5'd16;
						end
			4'b0111:	begin
							cycles = 5'd1;	
						end
			4'b1000:	begin	
							cycles = 5'd6;
						end
			4'b1001:	begin 
							cycles = 5'd6;
						end
			default:	begin
							cycles = 5'b0;
						end
		endcase
	end
	
	//////////////////////////////////////////////////////////// Stall ///////////////////////////////////////////////////////////////////////////////

	always@(*)begin
		if(fpu_sel & (cycles!=0)) begin
			if(count < cycles )	begin
				fpu_inprogress	=	1'b1;
			end	
			else begin 
				fpu_inprogress	=	1'b0;
			end	
		end
		else begin
			fpu_inprogress	=	1'b0;
		end
	end

	always@(posedge clock or negedge clear)begin
		if(~clear) count <= 5'b0;
		else if (~fpu_inprogress)	count<=5'b0;
		else begin
			count <= count+5'b1;
		end
	end
endmodule













