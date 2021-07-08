`timescale 1ns/1ps

module mips_tb;

	wire [31:0] addr;
	reg clk = 0,reset = 0,interrupt = 0;

	mips uut(
		.clk(clk),.reset(reset),
		.interrupt(interrupt),
		.addr(addr)
	);

	always #5 clk<=~clk;

endmodule