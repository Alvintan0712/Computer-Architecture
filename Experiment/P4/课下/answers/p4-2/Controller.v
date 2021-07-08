`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:25 11/21/2020 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	input [31:0] Instr, 
	output RegDst, AluSrc, RegWrite, MemWrite, MemToReg, Jump, Link, LinkReg, Return, Byte, Half, Sign, 
	output [1:0] ExtCtrl, 
	output [2:0] Branch, 
	output [3:0] AluCtrl
    );

	wire [5:0] opcode = Instr[31:26];
	wire [5:0] funct = Instr[5:0];
	wire R = opcode == 6'h0;

	wire addu = R & funct == 6'b100001;
	wire subu = R & funct == 6'b100011;
	wire jr   = R & funct == 6'b001000;
	wire sll  = R & funct == 6'b000000;
	wire srl  = R & funct == 6'b000010;
	wire sra  = R & funct == 6'b000011;
	wire jalr = R & funct == 6'b001001;

	wire ori  = opcode == 6'b001101;
	wire lw   = opcode == 6'b100011;
	wire sw   = opcode == 6'b101011;
	wire beq  = opcode == 6'b000100;
	wire lui  = opcode == 6'b001111;
	wire jal  = opcode == 6'b000011;
	wire lb	  = opcode == 6'b100000;
	wire lh   = opcode == 6'b100001;
	wire sb   = opcode == 6'b101000;
	wire sh   = opcode == 6'b101001;

	assign RegDst = addu | subu | sll | srl | sra | jalr;
	assign AluSrc = ori | lw | sw | lui | lb | lh | sb | sh;
	assign RegWrite = addu | subu | ori | lw | lui | jal | lb | lh | sll | srl | sra | jalr;
	assign MemWrite = sw | sb | sh;
	assign MemToReg = lw | lb | lh;
	assign Jump = jal | jr | jalr;
	assign Link = jal | jalr;
	assign Return = jr | jalr;
	assign LinkReg = jal;
	assign Byte = lb | sb;
	assign Half = lh | sh;
	assign Sign = lb | lh;

	// localparam [1:0] zero = 2'h0, sign = 2'h1, upper = 2'h2, jump  = 2'h3;
	assign ExtCtrl = ori ? 2'h0 : 
					 lw | sw | beq | lb | lh | sb | sh ? 2'h1 : 
					 lui ? 2'h2 : 
					 jal ? 2'h3 : 0;

	// Branch = {bgt,beq,blt};
	assign Branch = beq ? 3'b010 : 0;

	// localparam [3:0] ADD = 1, SUB = 2, OR = 3, AND = 4, XOR = 5, COMP = 6, SLL = 7, SRL = 8, SRA = 9;
	assign AluCtrl = addu | lw | sw | lui | lb | lh | sb | sh ? 4'h1 : 
					 subu ? 4'h2 : 
					 ori  ? 4'h3 : 
					 sll  ? 4'h7 : 
					 srl  ? 4'h8 : 
					 sra  ? 4'h9 : 
					 beq  ? 4'h6 : 4'h0;

endmodule
