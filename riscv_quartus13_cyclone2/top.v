module top(input CLOCK_50,input [1:1]KEY,input [0:0]SW,output [6:0]HEX0,output [6:0]HEX1,output [6:0]HEX2,output [6:0]HEX3);
	wire[31:0]dataOut;
	
	  system u0 (
        .dataout_export  (dataOut),  // dataout.export
        .clk_0_clk       (CLOCK_50),       //   clk_0.clk
        .reset_0_reset_n (KEY[1])  // reset_0.reset_n
    );
	
	wire [15:0]sw_dataOut;
	assign sw_dataOut = (SW)?dataOut[31:16]:dataOut[15:0]; // SW handles to show upper and lower 16 bits
	sevSegDec s0(sw_dataOut[3:0],HEX0);
	sevSegDec s1(sw_dataOut[7:4],HEX1);
	sevSegDec s2(sw_dataOut[11:8],HEX2);
	sevSegDec s3(sw_dataOut[15:12],HEX3);

endmodule


////////////////////////////////////////////////////////////////tb/////////////////////////////////////////////////////////////////////////////////
module tb;
	reg rst_n,clk;
	wire [31:0]dataOut;
	
	system u0 (
        .dataout_export  (dataOut),  // dataout.export
        .clk_0_clk       (clk),       //   clk_0.clk
        .reset_0_reset_n (rst_n)  // reset_0.reset_n
    );
	
	
	integer j;
	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);
		
		$monitor("%h",u0.riscv_core_0.dmem.MEM[264]);

		#0 rst_n = 1; clk = 0;
		#1 rst_n = 0; #1 rst_n = 1 ;#1
		
		for(j = 0;j < 100;j = j + 1) begin
			#1 clk = ~clk; #1 clk = ~clk;
		end
	end
endmodule
