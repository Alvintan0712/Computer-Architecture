`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:47 11/26/2020 
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
	input clk, reset, stall, Branch, Jump, CP0Req, EXLclr, 
	input [31:0] PCBranch, PCJump, EPC, 
	output [31:0] Instr, Pc
    );

	wire [31:0] pc;
	PC PC(
		.clk(clk),.reset(reset),.stall(stall & ~CP0Req & ~EXLclr), 
		.NPC_Sel(Branch | Jump | CP0Req | EXLclr), 
		.NPC(EXLclr ? EPC : CP0Req ? 32'h4180 : Jump ? PCJump : PCBranch),
		.PC(pc)
		);
	IM IM(.PC(pc),.Instr(Instr));
	assign Pc = pc;

endmodule
