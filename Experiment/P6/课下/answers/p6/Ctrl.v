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
	output AluSrc, RegWrite, MemToReg, MemWrite, Jump, Return, Link, start, ifmfhi, ifmflo, ifmdu, Zero, 
	output [1:0] RegDst, ExtCtrl, StoreType, 
	output [2:0] Branch, Tuse_rs, Tuse_rt, Tnew, LoadType, MuxData, 
	output [3:0] AluCtrl, MDU_OP
    );

	wire [5:0] opcode = Instr[31:26], funct = Instr[5:0];
	wire [4:0] zero = Instr[20:16];
	wire R = opcode == 6'b000000;

	wire add   = R & funct == 6'b100000; 
	wire addu  = R & funct == 6'b100001;
	wire And   = R & funct == 6'b100100;
	wire sub   = R & funct == 6'b100010;
	wire subu  = R & funct == 6'b100011;
	wire jr    = R & funct == 6'b001000;
	wire jalr  = R & funct == 6'b001001;
	wire Or    = R & funct == 6'b100101;
	wire Xor   = R & funct == 6'b100110;
	wire Nor   = R & funct == 6'b100111;
	wire sll   = R & funct == 6'b000000;
	wire srl   = R & funct == 6'b000010;
	wire sra   = R & funct == 6'b000011;
	wire slt   = R & funct == 6'b101010;
	wire sltu  = R & funct == 6'b101011;
	wire sllv  = R & funct == 6'b000100;
	wire srlv  = R & funct == 6'b000110;
	wire srav  = R & funct == 6'b000111;
	wire mult  = R & funct == 6'b011000;
	wire multu = R & funct == 6'b011001;
	wire div   = R & funct == 6'b011010;
	wire divu  = R & funct == 6'b011011;
	wire mthi  = R & funct == 6'b010001;
	wire mtlo  = R & funct == 6'b010011;
	wire mfhi  = R & funct == 6'b010000;
	wire mflo  = R & funct == 6'b010010;

	wire addi  = opcode == 6'b001000;
	wire addiu = opcode == 6'b001001;
	wire andi  = opcode == 6'b001100;
	wire ori   = opcode == 6'b001101;
	wire xori  = opcode == 6'b001110;
	wire lw    = opcode == 6'b100011;
	wire lb    = opcode == 6'b100000;
	wire lbu   = opcode == 6'b100100;
	wire lh    = opcode == 6'b100001;
	wire lhu   = opcode == 6'b100101;
	wire lui   = opcode == 6'b001111;
	wire sw    = opcode == 6'b101011;
	wire sb    = opcode == 6'b101000;
	wire sh    = opcode == 6'b101001;
	wire j     = opcode == 6'b000010;
	wire jal   = opcode == 6'b000011;
	wire beq   = opcode == 6'b000100;
	wire bne   = opcode == 6'b000101;
	wire slti  = opcode == 6'b001010;
	wire sltiu = opcode == 6'b001011;

	wire bgez = opcode == 6'b000001 & zero == 5'b00001;
	wire bgtz = opcode == 6'b000111 & zero == 5'b00000;
	wire blez = opcode == 6'b000110 & zero == 5'b00000;
	wire bltz = opcode == 6'b000001 & zero == 5'b00000;

	assign Zero = bgez | bgtz | blez | bltz;
	assign AluSrc 	= ori | lw | sw | lui | addi | addiu | andi | xori | slti | sltiu | lb | lbu | lh | lhu | sb | sh;
	assign RegWrite = add  | addi | addiu | addu | sub | subu | ori  | lw    | 
					  lui  | jal  | And   | andi | Or  | Xor  | xori | Nor   | 
					  jalr | sll  | srl   | sra  | slt | slti | sltu | sltiu | 
					  sllv | srlv | srav  | lb   | lbu | lh   | lhu  | mfhi  | mflo;
	assign MemToReg = lw | lb | lbu | lh | lhu;
	assign MemWrite = sw | sb | sh;
	assign Jump 	= j | jal | jr | jalr;
	assign Return 	= jr | jalr;
	assign Link 	= jal | jalr;

	// RegDst = 1, write rd, RegDst = 2, write $31
	assign RegDst = add | addu | And | sub | subu | Or | Xor | Nor | jalr | sll | srl | sra | slt | sltu | sllv | srlv | srav | mfhi | mflo ? 1 : 
					jal ? 2 : 0;

	// zero = 0, sign = 1, upper = 2
	assign ExtCtrl = ori | andi | xori ? 0 : 
					 addi | addiu | lw | sw | beq | bne | blez | bgtz | bgez | bltz | slti | sltiu | lb | lbu | lh | lhu | sh | sb ? 1 : 
					 lui ? 2 : 0;

	// Branch = 001, less, Branch == 010, equal, Branch == 100, more
	assign Branch = beq  ? 3'b010 : 
					bne  ? 3'b101 : 
					blez ? 3'b011 : 
					bgtz ? 3'b100 : 
					bgez ? 3'b110 : 
					bltz ? 3'b001 : 0;

	// ADDU = 1, SUBU = 2, OR = 3, SLL = 4, SRL = 5, SRA = 6, AND = 7, XOR = 8, NOR = 9, SLT = 10, SLTU = 11, SLLV = 12, SRLV = 13, SRAV = 14;
	assign AluCtrl = add | addu | addi | addiu | lw | sw | lui | lb | lbu | lh | lhu | sb | sh ? 1 : 
					 sub | subu 	? 2  : 
					 ori | Or 		? 3  : 
					 sll 			? 4  : 
					 srl 			? 5  : 
					 sra 			? 6  : 
					 And | andi 	? 7  : 
					 Xor | xori 	? 8  : 
					 Nor 			? 9  : 
					 slt  | slti	? 10 : 
					 sltu | sltiu 	? 11 :
					 sllv 			? 12 : 
					 srlv 			? 13 : 
					 srav 			? 14 : 0;

	assign start = mult | div | multu | divu;

	// mult = 1, div = 2, mthi = 3, mtlo = 4, multu = 5, divu = 6;
	assign MDU_OP = mult  ? 1 : 
					div   ? 2 : 
					mthi  ? 3 : 
					mtlo  ? 4 : 
					multu ? 5 : 
					divu  ? 6 : 0;
	assign ifmdu = mult | multu | div | divu | mthi | mtlo | mfhi | mflo;
	assign ifmflo = mflo;
	assign ifmfhi = mfhi;

	// word = 1, byte = 2, half = 3;
	assign StoreType = sw ? 1 : 
					   sb ? 2 : 
					   sh ? 3 : 0;

	// word = 0, byte = 1, sign_byte = 2, half = 3, sign_half = 4;
	assign LoadType = lbu ? 1 : 
					  lb  ? 2 : 
					  lhu ? 3 : 
					  lh  ? 4 : 0;

	// ALU = 0, HI = 1, LO = 2
	assign MuxData = mfhi ? 1 : 
					 mflo ? 2 : 0;

	// D = 1, E = 2, M = 3, W = 4
	assign Tuse_rs = beq  | bne  | blez | bgtz  | bltz | bgez  | jr   | jalr ? 1 : 
					 add  | addu | addi | addiu | sub  | subu  | Or   | ori  | 
					 And  | andi | Xor  | xori  | Nor  | lw    | lb   | lbu  | 
					 lh   | lhu  | sw   | sb    | sh   | sllv  | srlv | srav | 
					 slt  | sltu | slti | sltiu | mult | multu | div  | divu | 
					 mthi | mtlo ? 2 : 0;

	assign Tuse_rt = beq  | bne   ? 1 : 
					 add  | addu  | sub  | subu | Or   | And  | Xor | Nor  | 
					 sll  | sllv  | srl  | srlv | sra  | srav | slt | sltu | 
					 mult | multu | div  | divu ? 2 : 
					 sw   | sb    | sh   ? 3 : 0;

	assign Tnew = jal  | jalr ? 0 : 
				  lui 		  ? 1 : 
				  add  | addu | addi  | addiu | sub  | subu | Or    | ori | And  | andi | 
				  Xor  | xori | Nor   | sll   | sllv | srl  | srlv  | sra | srav | slt  | 
				  sltu | slti | sltiu | mfhi  | mflo ? 2 : 
				  lw   | lb   | lbu   | lh    | lhu  ? 3 : 0;

endmodule
