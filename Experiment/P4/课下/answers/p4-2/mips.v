`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:29 11/21/2020 
// Design Name: 
// Module Name:    mips 
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
	wire [5:0] opcode, funct;
	wire [4:0] rs, rt, rd, shamt;
	wire [15:0] imm16;
	wire [25:0] imm26;
	wire [31:0] imm, RegData1, RegData2, AluData, MemData;

	wire RegDst, RegWrite, AluSrc, MemWrite, MemToReg, Jump, Link, LinkReg, Return, Byte, Half, Sign;
	wire [1:0] ExtCtrl;
	wire [2:0] Branch;
	wire [3:0] AluCtrl;

	wire branch = AluCtrl == 4'h6 && Branch == AluData[2:0];
	wire [31:0] PC;

	// IFU(Addr[31:0],clk,reset,Branch,Jump,Instr[31:0]);
	IFU ifu(
		.JumpAddr(Return ? RegData1 : imm),
		.BranchAddr(PC + 4 + (imm << 2)),
		.clk(clk),
		.reset(reset),
		.Branch(branch),
		.Jump(Jump),
		.Instr(Instr), 
		.pc(PC)
		);

	// InstrDecoder(Instr[31:0],opcode[5:0],funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],imm16[15:0],imm26[25:0]);
	InstrDecoder decoder(
		.Instr(Instr),
		.opcode(opcode),
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.shamt(shamt),
		.funct(funct),
		.imm16(imm16),
		.imm26(imm26)
		);

	// Controller(Instr[31:0],RegDst,AluSrc,RegWrite,MemWrite,MemToReg,Jump,Link,LinkReg,Return,Byte,Half,ExtCtrl[1:0],Branch[2:0],AluCtrl[3:0]);
	Controller ctrl(
		.Instr(Instr),
		.RegDst(RegDst),
		.AluSrc(AluSrc),
		.RegWrite(RegWrite),
		.MemWrite(MemWrite),
		.MemToReg(MemToReg),
		.Jump(Jump),
		.Link(Link),
		.LinkReg(LinkReg), 
		.Return(Return), 
		.Byte(Byte), 
		.Half(Half), 
		.Sign(Sign),
		.ExtCtrl(ExtCtrl),
		.Branch(Branch),
		.AluCtrl(AluCtrl)
		);

	wire [31:0] ByteData, HalfData, WordData;
	wire [1:0] Offset = AluData[1:0];

	// DataType(Sign,Offset[1:0],Data[31:0],ByteData[31:0],HalfData[31:0],WordData[31:0])
	DataType regtype(
		.Sign(Sign),
		.Offset(Offset),
		.Data(MemData),
		.ByteData(ByteData),
		.HalfData(HalfData),
		.WordData(WordData)
		);

	wire [31:0] GrfData = Link ? PC + 4 :
						  MemToReg ? Byte ? ByteData : 
						  			 Half ? HalfData : WordData : AluData;
	wire [4:0] GrfWriteAddr = LinkReg ? 5'd31 : RegDst ? rd : rt;

	// GRF(clk,reset,RegWrite,A1[4:0],A2[4:0],A3[4:0],WriteData[31:0],RD1[31:0],RD2[31:0]);
	GRF grf(
		.clk(clk),
		.reset(reset),
		.RegWrite(RegWrite),
		.A1(rs),
		.A2(rt),
		.A3(GrfWriteAddr),
		.PC(PC), 
		.WriteData(GrfData),
		.RD1(RegData1),
		.RD2(RegData2)
		);

	// Extender(imm16[15:0],imm26[25:0],ExtCtrl[1:0],imm[31:0]);
	Extender ext(
		.imm16(imm16),
		.imm26(imm26),
		.ExtCtrl(ExtCtrl),
		.imm(imm)
		);

	// ALU(A[31:0],B[31:0],S[4:0],AluCtrl[3:0],D[31:0]);
	ALU alu(
		.A(RegData1),
		.B(AluSrc ? imm : RegData2),
		.S(shamt),
		.AluCtrl(AluCtrl),
		.D(AluData)
		);

	wire [31:0] DmData = Byte ? Offset == 2'h0 ? {MemData[31:8],RegData2[7:0]} : 
								Offset == 2'h1 ? {MemData[31:16],RegData2[7:0],MemData[7:0]} : 
								Offset == 2'h2 ? {MemData[31:24],RegData2[7:0],MemData[15:0]} :  {RegData2[7:0],MemData[23:0]} :
						 Half ? Offset[1] ? {RegData2[15:0],MemData[15:0]} : {MemData[31:16],RegData2[15:0]} : 
						 RegData2;

	// DM(clk,reset,MemWrite,Byte,Half,Addr[11:0],DataWrite[31:0],DataRead[31:0]);
	DM dm(
		.clk(clk),
		.reset(reset),
		.MemWrite(MemWrite), 
		.Byte(Byte),
		.Half(Half), 
		.Addr(AluData), 
		.PC(PC), 
		.DataWrite(DmData),
		.DataRead(MemData)
		);

endmodule
