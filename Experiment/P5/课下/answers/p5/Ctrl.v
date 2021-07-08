`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:10 11/26/2020 
// Design Name: 
// Module Name:    Ctrl 
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
module Ctrl(
	input [31:0] Instr, 
	output AluSrc, RegWrite, MemToReg, MemWrite, Jump, Return, Link, 
	output [1:0] RegDst, ExtCtrl, 
	output [2:0] Branch, Tuse_rs, Tuse_rt, Tnew, 
	output [3:0] AluCtrl
    );

	wire [5:0] opcode = Instr[31:26], funct = Instr[5:0];
	wire R = opcode == 6'b000000;

	wire addu = R & funct == 6'b100001;
	wire subu = R & funct == 6'b100011;
	wire jr   = R & funct == 6'b001000;
	wire jalr = R & funct == 6'b001001;

	wire addi = opcode == 6'b001000;
	wire ori  = opcode == 6'b001101;
	wire lui  = opcode == 6'b001111;
	wire lw   = opcode == 6'b100011;
	wire sw   = opcode == 6'b101011;
	wire beq  = opcode == 6'b000100;
	wire j    = opcode == 6'b000010;
	wire jal  = opcode == 6'b000011;

	assign AluSrc = ori | lw | sw | lui | addi;
	assign RegWrite = addu | subu | ori | lw | lui | jal | addi | jalr;
	assign MemToReg = lw;
	assign MemWrite = sw;
	assign Jump = j | jal | jr | jalr;
	assign Return = jr | jalr;
	assign Link = jal | jalr;

	// RegDst = 1, write rd, RegDst = 2, write $31
	assign RegDst = addu | subu | jalr ? 1 : 
					jal ? 2 : 0;

	// zero = 0, sign = 1, upper = 2
	assign ExtCtrl = ori ? 0 : 
					 lw | sw | beq | addi ? 1 : 
					 lui ? 2 : 0;

	// Branch = 001, less, Branch == 010, equal, Branch == 100, more
	assign Branch = beq ? 3'b010 : 0;

	// ADDU = 1, SUBU = 2, OR = 3, SLL = 4, SRL = 5, SRA = 6;
	assign AluCtrl = addu | lw | sw | lui | addi ? 1 : 
					 subu ? 2 : 
					 ori  ? 3 : 0;

	// D = 1, E = 2, M = 3, W = 4
	assign Tuse_rs = beq | jr | jalr ? 1 : 
					 addu | subu | ori | lw | sw | addi ? 2 : 0;
	assign Tuse_rt = beq ? 1 : 
					 addu | subu ? 2 : 
					 sw ? 3 : 0;

	// PCplus8 = 1, imm = 2, ALU = 3, DM = 4
	assign Tnew = jal | jalr ? 0 : 
				  lui ? 1 : 
				  addu | subu | ori | addi ? 2 : 
				  lw ? 3 : 0;

endmodule
