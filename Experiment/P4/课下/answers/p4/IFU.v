`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:29 11/16/2020 
// Design Name: 
// Module Name:    IFU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IFU(
	input Branch, Jump, clk, reset,
	input [31:0] BranchPC, JumpPC,
	output [31:0] Instr,
	output [31:0] PC
    );

	wire [10:0] Addr;
	wire [31:0] next = Jump ? ((JumpPC << 2) - 32'h3000) >> 2 : 
					   Branch ? Addr + 1 + BranchPC : Addr + 1;

	PC pc(
		.clk(clk),
		.reset(reset),
		.nPC(next),
		.Addr(Addr)
		);

	IM im(
		.Addr(Addr),
		.Instr(Instr)
		);
	assign PC = (Addr << 2) + 32'h3000;

endmodule
