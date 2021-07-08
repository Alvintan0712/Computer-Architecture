`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:14 11/21/2020 
// Design Name: 
// Module Name:    InstrDecoder 
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
module InstrDecoder(
	input [31:0] Instr, 
	output [5:0] opcode, funct,
	output [4:0] rs, rt, rd, shamt, 
	output [15:0] imm16, 
	output [25:0] imm26
    );

	assign opcode = Instr[31:26];
	assign funct = Instr[5:0];
	assign rs = Instr[25:21];
	assign rt = Instr[20:16];
	assign rd = Instr[15:11];
	assign shamt = Instr[10:6];
	assign imm16 = Instr[15:0];
	assign imm26 = Instr[25:0];

endmodule
