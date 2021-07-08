`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:25 11/26/2020 
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

	// Decode module
	wire [31:0] Instr_D, PCplus4_D, PCplus8_D;
	wire [2:0] Branch_D;
	wire [1:0] ExtCtrl_D, RegDst_D;
	wire [2:0] Tuse_rs_D, Tuse_rt_D, Tnew_D;
	wire Jump_D, Return_D, RegWrite_D, ifmdu_D, zero_D;

	// Execute module
	wire [31:0] Instr_E, PCplus4_E, PCplus8_E;
	wire [4:0] A3_E;
	wire [3:0] AluCtrl_E, MDU_OP_E;
	wire [2:0] Tuse_rs_E, Tuse_rt_E, Tnew_E;
	wire AluSrc_E, ifmfhi_E, ifmflo_E, start_E, Busy_E;

	// Memory module
	wire [31:0] Instr_M, PCplus4_M, PCplus8_M;
	wire [4:0] A3_M;
	wire [2:0] Tuse_rs_M, Tuse_rt_M, Tnew_M, MuxData_M, LoadType_M;
	wire [1:0] StoreType_M;
	wire MemWrite_M;

	// WriteBack module
	wire [31:0] Instr_W, PCplus4_W, PCplus8_W;
	wire [4:0] A3_W;
	wire [2:0] Tuse_rs_W, Tuse_rt_W, Tnew_W, MuxData_W;
	wire MemToReg_W, Link_W, RegWrite_W;

	// Hazard
	wire [4:0] ForwardSel_D1, ForwardSel_D2, ForwardSel_EA, ForwardSel_EB, ForwardSel_MD, ForwardSel_W;
	wire stall_PC, stall_FD, stall_DE, stall_EM, stall_MW;
	wire clr_FD, clr_DE, clr_EM, clr_MW;

	Ctrl ctrl_D(
		.Instr(Instr_D),
		.ExtCtrl(ExtCtrl_D), .Branch(Branch_D), .Jump(Jump_D), .RegDst(RegDst_D), .Link(Link_D), .Return(Return_D), .RegWrite(RegWrite_D), .ifmdu(ifmdu_D), .Zero(zero_D), 
		.Tuse_rs(Tuse_rs_D), .Tuse_rt(Tuse_rt_D)
		);
	Ctrl ctrl_E(
		.Instr(Instr_E),
		.AluSrc(AluSrc_E), .AluCtrl(AluCtrl_E), .Link(Link_E), .ifmfhi(ifmfhi_E), .ifmflo(ifmflo_E), .start(start_E), .MDU_OP(MDU_OP_E), 
		.Tnew(Tnew_E)
		);
	Ctrl ctrl_M(
		.Instr(Instr_M), 
		.MemWrite(MemWrite_M), .Link(Link_M), .StoreType(StoreType_M), .MuxData(MuxData_M), .LoadType(LoadType_M), 
		.Tnew(Tnew_M)
		);
	Ctrl ctrl_W(
		.Instr(Instr_W), 
		.MemToReg(MemToReg_W), .Link(Link_W), .RegWrite(RegWrite_W), .ifmfhi(ifmfhi_W), .ifmflo(ifmflo_W), .MuxData(MuxData_W), 
		.Tnew(Tnew_W)
		);

	Datapath datapath(
		.clk(clk), .reset(reset), 
		.stall_PC(stall_PC), .stall_FD(stall_FD), .stall_DE(stall_DE), .stall_EM(stall_EM), .stall_MW(stall_MW), 
		.clr_FD(clr_FD), .clr_DE(clr_DE), .clr_EM(clr_EM), .clr_MW(clr_MW), 
		.ForwardSel_D1(ForwardSel_D1), .ForwardSel_D2(ForwardSel_D2), 
		.ForwardSel_EA(ForwardSel_EA), .ForwardSel_EB(ForwardSel_EB), 
		.ForwardSel_MD(ForwardSel_MD), 
		// Decode module
		.Branch_D(Branch_D), .ExtCtrl_D(ExtCtrl_D), .Jump_D(Jump_D), .Return_D(Return_D), .RegDst_D(RegDst_D), .RegWrite_D(RegWrite_D), .zero_D(zero_D), 
		// Execute module
		.AluCtrl_E(AluCtrl_E), .AluSrc_E(AluSrc_E), .ifmfhi_E(ifmfhi_E), .ifmflo_E(ifmflo_E), .start_E(start_E), .MDU_OP_E(MDU_OP_E), 
		// Memory module
		.MemWrite_M(MemWrite_M), .StoreType_M(StoreType_M), .MuxData_M(MuxData_M), .LoadType_M(LoadType_M), 
		// WriteBack module
		.MemToReg_W(MemToReg_W), .Link_W(Link_W), .RegWrite_W(RegWrite_W), .ifmfhi_W(ifmfhi_W), .ifmflo_W(ifmflo_W), .MuxData_W(MuxData_W), 
		// Ctrl input
		.Instr_D(Instr_D), .Instr_E(Instr_E), .Instr_M(Instr_M), .Instr_W(Instr_W), 
		// dunno input
		.PCplus4_D(PCplus4_D), .PCplus4_E(PCplus4_E), .PCplus4_M(PCplus4_M), .PCplus4_W(PCplus4_W), 
		.PCplus8_D(PCplus8_D), .PCplus8_E(PCplus8_E), .PCplus8_M(PCplus8_M), .PCplus8_W(PCplus8_W), 
		.A3_E(A3_E), .A3_M(A3_M), .A3_W(A3_W), 
		.Busy_E(Busy_E)
		);

	Hazard hazard(
		.Instr_D(Instr_D), 
		.Tuse_rs_D(Tuse_rs_D), .Tuse_rt_D(Tuse_rt_D), .ifmdu_D(ifmdu_D), 
		// Execute
		.Instr_E(Instr_E), 
		.Tnew_E(Tnew_E), .start_E(start_E), .Busy_E(Busy_E), 
		.A3_E(A3_E), 
		// Memory
		.Instr_M(Instr_M), 
		.Tnew_M(Tnew_M), 
		.A3_M(A3_M), 
		// WriteBack
		.Instr_W(Instr_W), 
		.Tnew_W(Tnew_W), 
		.A3_W(A3_W), 
		// Hazard
		.ForwardSel_D1(ForwardSel_D1), .ForwardSel_D2(ForwardSel_D2), .ForwardSel_EA(ForwardSel_EA), 
		.ForwardSel_EB(ForwardSel_EB), .ForwardSel_MD(ForwardSel_MD), 
		.stall_PC(stall_PC), .stall_FD(stall_FD), .stall_DE(stall_DE), .stall_EM(stall_EM), .stall_MW(stall_MW), 
		.clr_FD(clr_FD), .clr_DE(clr_DE), .clr_EM(clr_EM), .clr_MW(clr_MW)
		);

endmodule
