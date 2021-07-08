`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:12 11/26/2020 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(
	input clk, reset, 
	input stall_PC, stall_FD, stall_DE, stall_EM, stall_MW, 
	input clr_FD, clr_DE, clr_EM, clr_MW, 
	input [4:0] ForwardSel_D1, ForwardSel_D2, ForwardSel_EA, ForwardSel_EB, ForwardSel_MD, 

	// Decode module
	input [2:0] Branch_D, 
	input [1:0] ExtCtrl_D, 
	input [1:0] RegDst_D, 
	input Jump_D, Return_D, RegWrite_D, 

	// Execute module
	input [3:0] AluCtrl_E, 
	input AluSrc_E, 

	// Memory module
	input MemWrite_M, 

	// WriteBack module
	input MemToReg_W, Link_W, RegWrite_W, 

	// Ctrl input
	output [31:0] Instr_D, Instr_E, Instr_M, Instr_W, 
	output [31:0] PCplus4_D, PCplus4_E, PCplus4_M, PCplus4_W, 
	output [31:0] PCplus8_D, PCplus8_E, PCplus8_M, PCplus8_W, 
	output [4:0] A3_E, A3_M, A3_W
    );

	// Fetch
	wire [31:0] Instr_F, PC_F;

	// Decode
	wire [4:0] rs = Instr_D[25:21], rt = Instr_D[20:16], rd = Instr_D[15:11];
	wire [15:0] imm16_D = Instr_D[15:0];
	wire [4:0] A1_D = rs, A2_D = rt;
	wire [4:0] A3_D = RegWrite_D ? RegDst_D === 2'h2 ? 5'd31 : 
								   RegDst_D === 2'h1 ? rd 	 : rt : 0;
	wire [31:0] PC_D = PCplus4_D - 4;
	wire [31:0] RD1_D, RD2_D, imm_D;
	wire [2:0] Comp_Out_D;
	wire [31:0] MF_RD1_D, MF_RD2_D;
	wire [31:0] PCBranch_D = (imm_D << 2) + PCplus4_D;
	wire [31:0] PCJump_D = Return_D ? MF_RD1_D : {PC_D[31:28],Instr_D[25:0],2'b0}; // Link MuxForward
	wire branch_D = |{Comp_Out_D & Branch_D};

	// Execute
	wire [31:0] RD1_E, RD2_E, imm_E, AluOut_E;
	wire [31:0] MF_A_E, MF_B_E;
	wire [4:0] shamt_E = Instr_E[10:6];

	// Memory
	wire [31:0] AluOut_M, RD2_M, DMOut_M, imm_M;
	wire [31:0] MF_RD2_M;

	// WriteBack
	wire [31:0] AluOut_W, DMOut_W, imm_W;

	// Fetch
	IFU ifu(
		.clk(clk), .reset(reset), .stall(stall_PC), 
		.Branch(branch_D), .Jump(Jump_D),
		.PCBranch(PCBranch_D), .PCJump(PCJump_D), 
		.Instr(Instr_F), .Pc(PC_F)
		);

	Reg_FtoD FtoD(
		.clk(clk), .reset(reset | clr_FD), .stall(stall_FD),
		.Instr_F(Instr_F),
		.PCplus4_F(PC_F + 4), .PCplus8_F(PC_F + 8),
		.Instr_D(Instr_D),
		.PCplus4_D(PCplus4_D), .PCplus8_D(PCplus8_D)
		);

	// Decode
	wire [31:0] WriteData = Link_W ? PCplus8_W : MemToReg_W ? DMOut_W : AluOut_W;

	GRF grf(
		.clk(clk),.reset(reset),.RegWrite(RegWrite_W),
		.A1(A1_D),.A2(A2_D),.A3(A3_W), 
		.WriteData(WriteData),
		.PC(PCplus4_W - 4), 
		.RD1(RD1_D), .RD2(RD2_D)
		);
	Ext ext(
		.ExtCtrl(ExtCtrl_D),
		.imm16(imm16_D), 
		.imm(imm_D)
		);
	Forward fwd_D(
		.ForwardSel_D1(ForwardSel_D1), .ForwardSel_D2(ForwardSel_D2), 
		.RD1_D(RD1_D), .RD2_D(RD2_D), 
		.PCplus8_E(PCplus8_E), .imm_E(imm_E), 
		.PCplus8_M(PCplus8_M), .imm_M(imm_M), .AluOut_M(AluOut_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), 
		.MF_RD1_D(MF_RD1_D)  , .MF_RD2_D(MF_RD2_D)
		);
	Comp comp(
		.A(MF_RD1_D), .B(MF_RD2_D),
		.Comp_Out(Comp_Out_D)
		);

	Reg_DtoE DtoE(
		.clk(clk), .reset(reset | clr_DE), .stall(stall_DE), 
		.Instr_D(Instr_D), .RD1_D(MF_RD1_D), .RD2_D(MF_RD2_D), .imm_D(imm_D), 
		.PCplus4_D(PCplus4_D), .PCplus8_D(PCplus8_D), 
		.A3_D(A3_D), 
		.Instr_E(Instr_E), .RD1_E(RD1_E), .RD2_E(RD2_E), .imm_E(imm_E), 
		.PCplus4_E(PCplus4_E), .PCplus8_E(PCplus8_E), 
		.A3_E(A3_E)
		);

	// Execute
	Forward fwd_E(
		.ForwardSel_EA(ForwardSel_EA), .ForwardSel_EB(ForwardSel_EB), 
		.RD1_E(RD1_E), .RD2_E(RD2_E), 
		.PCplus8_M(PCplus8_M), .imm_M(imm_M), .AluOut_M(AluOut_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), 
		.MF_A_E(MF_A_E), .MF_B_E(MF_B_E)
		);
	ALU alu(
		.AluCtrl(AluCtrl_E), 
		.A(MF_A_E), .B(AluSrc_E ? imm_E : MF_B_E), .S(shamt_E), 
		.D(AluOut_E)
		);

	Reg_EtoM EtoM(
		.clk(clk), .reset(reset | clr_EM), .stall(stall_EM), 
		.Instr_E(Instr_E), .AluOut_E(AluOut_E), .WriteData_E(MF_B_E), .imm_E(imm_E), 
		.PCplus4_E(PCplus4_E), .PCplus8_E(PCplus8_E), 
		.A3_E(A3_E), 
		.Instr_M(Instr_M), .AluOut_M(AluOut_M), .WriteData_M(RD2_M), .imm_M(imm_M), 
		.PCplus4_M(PCplus4_M), .PCplus8_M(PCplus8_M), 
		.A3_M(A3_M)
		);

	// Memory
	Forward fwd_M(
		.ForwardSel_MD(ForwardSel_MD), 
		.RD2_M(RD2_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), 
		.MF_RD2_M(MF_RD2_M)
		);
	DM dm(
		.clk(clk), .reset(reset), .MemWrite(MemWrite_M), 
		.Addr(AluOut_M), .WriteData(MF_RD2_M), .PC(PCplus4_M - 4), 
		.DMOut(DMOut_M)
		);

	Reg_MtoW MtoW(
		.clk(clk), .reset(reset | clr_MW), .stall(stall_MW), 
		.Instr_M(Instr_M), .AluOut_M(AluOut_M), .DMOut_M(DMOut_M), .imm_M(imm_M), 
		.PCplus4_M(PCplus4_M), .PCplus8_M(PCplus8_M), 
		.A3_M(A3_M), 
		.Instr_W(Instr_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), .imm_W(imm_W), 
		.PCplus4_W(PCplus4_W), .PCplus8_W(PCplus8_W), 
		.A3_W(A3_W)
		);

endmodule
