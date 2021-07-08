`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:19 11/16/2020 
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
	input [5:0] opcode, funct,
	output RegDst, AluSrc, RegWrite, MemToReg, MemWrite, Jump, Link, Byte, Half, Word, Return, 
	output [3:0] AluCtrl, Ext_Op,
	output [2:0] Branch
    );

	wire R = opcode == 6'b000000;

	// And Logic
	wire addu = R & funct == 6'b100001;
	wire subu = R & funct == 6'b100011;
	wire ori = opcode == 6'b001101;
	wire lw = opcode == 6'b100011;
	wire sw = opcode == 6'b101011;
	wire beq = opcode == 6'b000100;
	wire lui = opcode == 6'b001111;
	wire j = opcode == 6'b000010;
	wire jal = opcode == 6'b000011;
	wire jr = R & funct == 6'b001000;
	// wire nop = R & funct == 6'b000000;

	// Or Logic
	assign RegDst = addu | subu;
	assign AluSrc = ori | lw | sw | lui;
	assign RegWrite = addu | subu | ori | lw | lui | jal;
	assign MemToReg = lw;
	assign MemWrite = sw;
	assign Branch = beq ? 3'b010 : 0;
	assign Jump = j | jal | jr;
	assign Link = jal;
	assign Byte = 0;
	assign Half = 0;
	assign Word = lw | sw;
	assign Return = jr;

	// addu = 1, subu = 2, Or = 3, sll = 4, srl = 5, sra = 6;
	assign AluCtrl = addu | lw | sw | lui? 1 : 
					 subu ? 2 : 
					 ori ? 3 : 0;

	// Ext_Op = {sign,zero,upper,j};
	assign Ext_Op = lw | sw | beq ? 4'b1000 : 
					ori ? 4'b0100 : 
					lui ? 4'b0010 : 
					j | jal | jr ? 4'b0101 : 0;

endmodule
