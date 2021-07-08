`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:18 11/16/2020 
// Design Name: 
// Module Name:    Top_Module 
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
module mips(input clk, reset);

 	wire [31:0] Instr;
 	wire beq, bgt, blt;

 	wire [5:0] opcode, funct;
 	wire [4:0] rs, rt, rd, shamt;
 	wire [15:0] imm16;
 	wire [25:0] imm26;
 	wire [31:0] imm32, RD1, RD2;

 	wire RegDst, AluSrc, RegWrite, MemToReg, MemWrite, Jump, Link, Byte, Half, Word, Return;
 	wire [31:0] MemData, AluData, PC;
 	wire [3:0] AluCtrl, Ext_Op;
 	wire [2:0] Branch;

 	// Branch = {bgt,beq,blt};
 	wire nPC_sel = bgt & Branch[2] | beq & Branch[1] | blt & Branch[0];

	// Controller(
	// input [5:0] opcode, funct,
	// output RegDst, AluSrc, RegWrite, MemToReg, MemWrite, Jump, Link, Byte, Half, Word, Return, 
	// output [3:0] AluCtrl, Ext_Op,
	// output [2:0] Branch
 	// );
 	Controller ctrl(	.opcode(opcode),
 						.funct(funct),
 						.RegDst(RegDst),
 						.AluSrc(AluSrc),
 						.RegWrite(RegWrite),
 						.MemToReg(MemToReg),
 						.MemWrite(MemWrite),
 						.Jump(Jump),
 						.Link(Link),
 						.Byte(Byte),
 						.Half(Half),
 						.Word(Word),
 						.Return(Return),
 						.AluCtrl(AluCtrl),
 						.Ext_Op(Ext_Op),
 						.Branch(Branch)
 					);

	// IFU(input Branch, Jump, clk, reset, input [31:0] BranchPC, JumpPC, output [31:0] Instr);
 	IFU ifu(	.Branch(nPC_sel),
 				.Jump(Jump),
 				.clk(clk),
 				.reset(reset),
 				.BranchPC(imm32),
 				.JumpPC(Return ? RD1 >> 2 : imm32),
 				.Instr(Instr),
 				.PC(PC)
 			);

	// Decoder(input [31:0] Instr, output [5:0] opcode, funct, output [4:0] rs, rt, rd, shamt, output [15:0] imm16, output [25:0] imm26);
 	Decoder decode(	.Instr(Instr),
 					.opcode(opcode),
 					.funct(funct),
 					.rs(rs),
 					.rt(rt),
 					.rd(rd),
 					.shamt(shamt),
 					.imm16(imm16),
 					.imm26(imm26)
 				);

	// Extender(input [15:0] imm16, input [25:0] imm26, input sign, zero, upper, j, output [31:0] imm32);
 	Extender extend(	.imm16(imm16),
 						.imm26(imm26),
 						.sign(Ext_Op[3]),
 						.zero(Ext_Op[2]),
 						.upper(Ext_Op[1]),
 						.j(Ext_Op[0]),
 						.imm32(imm32)
 				);

	// GRF(input [4:0] A1, A2, A3, input [31:0] WD, PC, input clk, reset, WE, output [31:0] RD1, RD2);
 	GRF grf(	.A1(rs),
 				.A2(rt),
 				.A3(Link ? 5'h1f : RegDst ? rd : rt),
 				.WD(Link ? PC + 4 : MemToReg ? MemData : AluData),
 				.PC(PC),
 				.clk(clk),
 				.reset(reset),
 				.WE(RegWrite),
 				.RD1(RD1),
 				.RD2(RD2)
 			);

	// ALU(input [31:0] A, B, input [4:0] S, input [3:0] Ctrl, output [31:0] D, output beq, bgt, blt);
 	ALU alu(	.A(RD1),
 				.B(AluSrc? imm32 : RD2),
 				.S(shamt),
 				.Ctrl(AluCtrl),
 				.D(AluData),
 				.beq(beq),
 				.bgt(bgt),
 				.blt(blt)
 			);

 	wire [10:0] Addr = AluData >> 2;
	// DM(input [31:0] WriteData, PC, input [4:0] Addr,	input MemWrite, clk, reset, Byte, Half, Word, output [31:0] ReadData);
 	DM dm(	.Addr(Addr),
 			.WriteData(RD2),
 			.PC(PC),
 			.MemWrite(MemWrite),
 			.clk(clk),
 			.reset(reset),
 			.Byte(Byte),
 			.Half(Half),
 			.Word(Word),
 			.ReadData(MemData)
 		);

endmodule
