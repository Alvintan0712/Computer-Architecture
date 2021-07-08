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
module CPU(
	input clk, reset, 
	input [15:10] HWInt, 
	input [31:0] PrRD, 
	output [31:0] PrAddr, PrWD, Addr, 
	output PrWe
	);

	// Decode module
	wire [31:0] Instr_D, PCplus4_D, PCplus8_D;
	wire [2:0] Branch_D;
	wire [1:0] ExtCtrl_D, RegDst_D;
	wire [2:0] Tuse_rs_D, Tuse_rt_D;
	wire Jump_D, Return_D, RegWrite_D, ifmdu_D, zero_D, unknown_Instr_D, DelaySlot_D, ifsyscall_D;

	// Execute module
	wire [31:0] Instr_E, PCplus4_E, PCplus8_E;
	wire [4:0] A3_E;
	wire [3:0] AluCtrl_E, MDU_OP_E;
	wire [2:0] Tnew_E;
	wire AluSrc_E, ifmfhi_E, ifmflo_E, start_E, Busy_E;
	wire cal_E, iflw_E, iflh_E, iflb_E, ifsw_E, ifsh_E, ifsb_E, sign_E;

	// Memory module
	wire [31:0] Instr_M, PCplus4_M, PCplus8_M;
	wire [4:0] A3_M;
	wire [3:0] MDU_OP_M;
	wire [2:0] Tuse_rs_M, Tuse_rt_M, Tnew_M, MuxData_M, LoadType_M;
	wire [1:0] StoreType_M;
	wire MemWrite_M, CP0Write_M, EXLclr_M, CP0Src_M;
	wire iflw_M, iflh_M, iflb_M, ifsw_M, ifsh_M, ifsb_M;

	// WriteBack module
	wire [31:0] Instr_W, PCplus4_W, PCplus8_W;
	wire [4:0] A3_W;
	wire [2:0] Tnew_W, MuxData_W;
	wire MemToReg_W, Link_W, RegWrite_W, ifmfhi_W, ifmflo_W;

	// Hazard
	wire [4:0] ForwardSel_D1, ForwardSel_D2, ForwardSel_EA, ForwardSel_EB, ForwardSel_MD, ForwardSel_W;
	wire stall_PC, stall_FD, stall_DE, stall_EM, stall_MW;
	wire clr_FD, clr_DE, clr_EM, clr_MW;

	Ctrl ctrl_D(
		.Instr(Instr_D),
		.ExtCtrl(ExtCtrl_D), .Branch(Branch_D), .Jump(Jump_D), .RegDst(RegDst_D), .Link(Link_D), .Return(Return_D), .RegWrite(RegWrite_D), 
		.ifmdu(ifmdu_D), .Zero(zero_D), .unknown_Instr(unknown_Instr_D), .DelaySlot(DelaySlot_D), .ifsyscall(ifsyscall_D), 
		.Tuse_rs(Tuse_rs_D), .Tuse_rt(Tuse_rt_D)
		);
	Ctrl ctrl_E(
		.Instr(Instr_E),
		.AluSrc(AluSrc_E), .AluCtrl(AluCtrl_E), .Link(Link_E), .ifmfhi(ifmfhi_E), .ifmflo(ifmflo_E), .start(start_E), .MDU_OP(MDU_OP_E), 
		.cal(cal_E), .iflw(iflw_E), .iflh(iflh_E), .iflb(iflb_E), .ifsw(ifsw_E), .ifsh(ifsh_E), .ifsb(ifsb_E), .sign(sign_E), 
		.Tnew(Tnew_E)
		);
	Ctrl ctrl_M(
		.Instr(Instr_M), 
		.MemWrite(MemWrite_M), .Link(Link_M), .StoreType(StoreType_M), .MuxData(MuxData_M), .LoadType(LoadType_M), 
		.iflw(iflw_M), .iflh(iflh_M), .iflb(iflb_M), .ifsw(ifsw_M), .ifsh(ifsh_M), .ifsb(ifsb_M), 
		.CP0Write(CP0Write_M), .EXLclr(EXLclr_M), .CP0Src(CP0Src_M), .MDU_OP(MDU_OP_M), 
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
		// IO input
		.PrRD(PrRD), .HWInt(HWInt), 
		// Decode input
		.Branch_D(Branch_D), .ExtCtrl_D(ExtCtrl_D), .Jump_D(Jump_D), .Return_D(Return_D), .RegDst_D(RegDst_D), .RegWrite_D(RegWrite_D), .zero_D(zero_D), 
		.unknown_Instr_D(unknown_Instr_D), .DelaySlot_F(DelaySlot_D), .ifsyscall_D(ifsyscall_D), 
		// Execute input
		.AluCtrl_E(AluCtrl_E), .AluSrc_E(AluSrc_E), .ifmfhi_E(ifmfhi_E), .ifmflo_E(ifmflo_E), .start_E(start_E), .MDU_OP_E(MDU_OP_E), 
		.sign_E(sign_E), .cal_E(cal_E), .iflw_E(iflw_E), .iflh_E(iflh_E), .iflb_E(iflb_E), .ifsw_E(ifsw_E), .ifsh_E(ifsh_E), .ifsb_E(ifsb_E), 
		// Memory input
		.MemWrite_M(MemWrite_M), .StoreType_M(StoreType_M), .MuxData_M(MuxData_M), .LoadType_M(LoadType_M), 
		.CP0Write_M(CP0Write_M), .EXLclr_M(EXLclr_M), .CP0Src_M(CP0Src_M), .MDU_OP_M(MDU_OP_M), 
		.iflw_M(iflw_M), .iflh_M(iflh_M), .iflb_M(iflb_M), .ifsw_M(ifsw_M), .ifsh_M(ifsh_M), .ifsb_M(ifsb_M), 
		// WriteBack input
		.MemToReg_W(MemToReg_W), .Link_W(Link_W), .RegWrite_W(RegWrite_W), .ifmfhi_W(ifmfhi_W), .ifmflo_W(ifmflo_W), .MuxData_W(MuxData_W), 
		// Ctrl output
		.Instr_D(Instr_D), .Instr_E(Instr_E), .Instr_M(Instr_M), .Instr_W(Instr_W), 
		// dunno output
		.PCplus4_D(PCplus4_D), .PCplus4_E(PCplus4_E), .PCplus4_M(PCplus4_M), .PCplus4_W(PCplus4_W), 
		.PCplus8_D(PCplus8_D), .PCplus8_E(PCplus8_E), .PCplus8_M(PCplus8_M), .PCplus8_W(PCplus8_W), 
		.A3_E(A3_E), .A3_M(A3_M), .A3_W(A3_W), 
		.Busy_E(Busy_E), 
		// IO output
		.PrAddr(PrAddr), .PrWD(PrWD), .PrWe(PrWe), .Addr(Addr)
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
