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

	// Hazard
	input stall_PC, stall_FD, stall_DE, stall_EM, stall_MW, 
	input clr_FD, clr_DE, clr_EM, clr_MW, 
	input [4:0] ForwardSel_D1, ForwardSel_D2, ForwardSel_EA, ForwardSel_EB, ForwardSel_MD, 

	// IO
	input [31:0] PrRD, 
	input [15:10] HWInt, 

	// Decode module
	input [2:0] Branch_D, 
	input [1:0] ExtCtrl_D, RegDst_D, 
	input Jump_D, Return_D, RegWrite_D, zero_D, unknown_Instr_D, DelaySlot_F, ifsyscall_D, // 1 new signal

	// Execute module
	input [3:0] AluCtrl_E, MDU_OP_E, 
	input AluSrc_E, ifmfhi_E, ifmflo_E, start_E, sign_E, cal_E, iflw_E, iflh_E, iflb_E, ifsw_E, ifsh_E, ifsb_E, // 8 new signal
	input DelaySlot_E, 

	// Memory module
	input MemWrite_M, CP0Write_M, EXLclr_M, CP0Src_M, iflw_M, iflh_M, iflb_M, ifsw_M, ifsh_M, ifsb_M, // 6 new signal
	input [1:0] StoreType_M, 
	input [2:0] MuxData_M, LoadType_M, 
	input [3:0] MDU_OP_M, 

	// WriteBack module
	input MemToReg_W, Link_W, RegWrite_W, ifmfhi_W, ifmflo_W, // 1 new signal
	input [2:0] MuxData_W, 

	// Ctrl input
	output [31:0] Instr_D, Instr_E, Instr_M, Instr_W, 
	output [31:0] PCplus4_D, PCplus4_E, PCplus4_M, PCplus4_W, 
	output [31:0] PCplus8_D, PCplus8_E, PCplus8_M, PCplus8_W, 
	output [4:0] A3_E, A3_M, A3_W,
	output Busy_E, 

	// IO
	output [31:0] PrAddr, PrWD, Addr, 
	output PrWe
    );

	// Fetch
	wire [31:0] Instr_F, PC_F;
	wire [4:0] Exccode_F_In;
	wire PCEn_F;

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
	wire [4:0] Exccode_D_In, Exccode_D_Out;
	wire DelaySlot_D, PCEn_D;

	// Execute
	wire [31:0] RD1_E, RD2_E, imm_E, AluOut_E;
	wire [31:0] MF_A_E, MF_B_E, HI_E, LO_E;
	wire [4:0] shamt_E = Instr_E[10:6];
	wire [4:0] Exccode_E_In, Exccode_E_Out;
	wire overflow_E, DelaySlot_E, PCEn_E;

	// Memory
	wire [31:0] AluOut_M, RD2_M, DMOut_M, imm_M, HI_M, LO_M, EPC_M;
	wire [31:0] MF_RD2_M, LoadData_M, CP0Data_M;
	wire [1:0] Offset_M = AluOut_M[1:0];
	wire [4:0] Exccode_M_In, Exccode_M_Out;
	wire CP0Req_M, DelaySlot_M, PCEn_M;

	// WriteBack
	wire [31:0] AluOut_W, DMOut_W, imm_W, HI_W, LO_W;
	wire [31:0] WriteData_W = ifmfhi_W ? HI_W : ifmflo_W ? LO_W : Link_W ? PCplus8_W : MemToReg_W ? DMOut_W : AluOut_W; // mfc0 use AluOut
	wire DelaySlot_W, PCEn_W;

	localparam Int = 0, AdEL = 4, AdES = 5, Syscall = 8, RI = 10, Ov = 12;

	// Fetch
	wire PCExc = PC_F < 32'h00003000 || PC_F > 32'h00004ffc || |(PC_F & 3);
	assign Exccode_F_In = PCExc ? AdEL : 0;
	IFU ifu(
		.clk(clk), .reset(reset), .stall(stall_PC), 
		.Branch(branch_D), .Jump(Jump_D), 
		.PCBranch(PCBranch_D), .PCJump(PCJump_D), .EPC(EPC_M), 
		.CP0Req(CP0Req_M), .EXLclr(EXLclr_M), 
		.Instr(Instr_F), .Pc(PC_F)
		);

	Reg_FtoD FtoD(
		.clk(clk), .reset(reset | clr_FD | CP0Req_M | EXLclr_M), .stall(stall_FD), 
		.Instr_F(PCExc ? 32'h0 : Instr_F), 
		.PCplus4_F(PC_F + 4), .PCplus8_F(PC_F + 8), 
		.Exccode_F(Exccode_F_In), 
		.DelaySlot_F(DelaySlot_F), .PCEn_F(1'b1), 
		.DelaySlot_D(DelaySlot_D), .PCEn_D(PCEn_D), 
		.Instr_D(Instr_D), 
		.PCplus4_D(PCplus4_D), .PCplus8_D(PCplus8_D), 
		.Exccode_D(Exccode_D_Out)
		);

	// Decode
	assign Exccode_D_In = Exccode_D_Out == 0 & unknown_Instr_D ? RI : 
						  Exccode_D_Out == 0 & ifsyscall_D	   ? Syscall : Exccode_D_Out ;
	GRF grf(
		.clk(clk),.reset(reset),.RegWrite(RegWrite_W),
		.A1(A1_D),.A2(A2_D),.A3(A3_W), 
		.WriteData(WriteData_W),
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
		.PCplus8_M(PCplus8_M), .imm_M(imm_M), .AluOut_M(AluOut_M), .MuxData_M(MuxData_M), .HI_M(HI_M), .LO_M(LO_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), .MuxData_W(MuxData_W), .HI_W(HI_W), .LO_W(LO_W), 
		.MF_RD1_D(MF_RD1_D)  , .MF_RD2_D(MF_RD2_D)
		);
	Comp comp(
		.zero(zero_D), 
		.A(MF_RD1_D), .B(MF_RD2_D),
		.Comp_Out(Comp_Out_D)
		);

	Reg_DtoE DtoE(
		.clk(clk), .reset(reset | clr_DE | CP0Req_M | EXLclr_M), .stall(stall_DE), 
		.Instr_D(unknown_Instr_D & ifsyscall_D ? 32'h0 : Instr_D), .RD1_D(MF_RD1_D), .RD2_D(MF_RD2_D), .imm_D(imm_D), 
		.PCplus4_D(PCplus4_D), .PCplus8_D(PCplus8_D), 
		.A3_D(A3_D), .Exccode_D(Exccode_D_In), .DelaySlot_D(DelaySlot_D), .PCEn_D(PCEn_D), 
		.Instr_E(Instr_E), .RD1_E(RD1_E), .RD2_E(RD2_E), .imm_E(imm_E), .DelaySlot_E(DelaySlot_E), .PCEn_E(PCEn_E), 
		.PCplus4_E(PCplus4_E), .PCplus8_E(PCplus8_E), 
		.A3_E(A3_E), .Exccode_E(Exccode_E_Out)
		);

	// Execute
	wire RollBack = MDU_OP_M == 1 | MDU_OP_M == 2 | MDU_OP_M == 3 | MDU_OP_M == 4 | MDU_OP_M == 5 | MDU_OP_M == 6;
	wire WE = MDU_OP_E == 3 | MDU_OP_E == 4;
	assign Exccode_E_In = Exccode_E_Out == 0 & overflow_E & cal_E   ? Ov : 
						  Exccode_E_Out == 0 & overflow_E & (iflw_E | iflh_E | iflb_E) ? AdEL : 
						  Exccode_E_Out == 0 & overflow_E & (ifsw_E | ifsh_E | ifsb_E) ? AdES : Exccode_E_Out;
	Forward fwd_E(
		.ForwardSel_EA(ForwardSel_EA), .ForwardSel_EB(ForwardSel_EB), 
		.RD1_E(RD1_E), .RD2_E(RD2_E), 
		.PCplus8_M(PCplus8_M), .imm_M(imm_M), .AluOut_M(AluOut_M), .MuxData_M(MuxData_M), .HI_M(HI_M), .LO_M(LO_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), .MuxData_W(MuxData_W), .HI_W(HI_W), .LO_W(LO_W), 
		.MF_A_E(MF_A_E), .MF_B_E(MF_B_E)
		);
	ALU alu(
		.sign(sign_E), 
		.AluCtrl(AluCtrl_E), 
		.A(MF_A_E), .B(AluSrc_E ? imm_E : MF_B_E), .S(shamt_E), 
		.overflow(overflow_E), 
		.D(AluOut_E)
		);
	MDU mdu(
		.clk(clk), .reset(reset), .start(start_E & ~EXLclr_M & ~CP0Req_M & ~reset), .return(CP0Req_M & RollBack), 
		.A(MF_A_E), .B(MF_B_E), .WE(WE & ~CP0Req_M & ~EXLclr_M & ~reset), 
		.MDU_OP(MDU_OP_E), 
		.Busy(Busy_E), 
		.HI(HI_E), .LO(LO_E)
		);

	Reg_EtoM EtoM(
		.clk(clk), .reset(reset | clr_EM | CP0Req_M | EXLclr_M), .stall(stall_EM), 
		.Instr_E(Instr_E), .AluOut_E(AluOut_E), .WriteData_E(MF_B_E), .imm_E(imm_E), .HI_E(HI_E), .LO_E(LO_E), 
		.PCplus4_E(PCplus4_E), .PCplus8_E(PCplus8_E), 
		.A3_E(A3_E), .Exccode_E(Exccode_E_In), 
		.DelaySlot_E(DelaySlot_E), .PCEn_E(PCEn_E), 
		.DelaySlot_M(DelaySlot_M), .PCEn_M(PCEn_M), 
		.Instr_M(Instr_M), .AluOut_M(AluOut_M), .WriteData_M(RD2_M), .imm_M(imm_M), .HI_M(HI_M), .LO_M(LO_M), 
		.PCplus4_M(PCplus4_M), .PCplus8_M(PCplus8_M), 
		.A3_M(A3_M), .Exccode_M(Exccode_M_Out)
		);

	// Memory
	wire [4:0] rd_M = Instr_M[15:11];
	wire DMAddr = 32'h00000000 <= AluOut_M & AluOut_M <= 32'h00002fff;
	wire TimerAddr = ((AluOut_M & 3) == 0) & (32'h00007f00 <= AluOut_M & AluOut_M <= 32'h00007f0b | 32'h00007f10 <= AluOut_M & AluOut_M <= 32'h00007f1b);
	assign Exccode_M_In = Exccode_M_Out == 0 & iflw_M & (~DMAddr & ~TimerAddr | |(AluOut_M & 3)) ? AdEL : 
						  Exccode_M_Out == 0 & ifsw_M & (~DMAddr & ~TimerAddr | |(AluOut_M & 3) | (TimerAddr & AluOut_M[3:2] == 2)) ? AdES : 
						  Exccode_M_Out == 0 & iflh_M & (~DMAddr | |(AluOut_M & 1))				 ? AdEL : 
						  Exccode_M_Out == 0 & ifsh_M & (~DMAddr | |(AluOut_M & 1))				 ? AdES : 
						  Exccode_M_Out == 0 & iflb_M & ~DMAddr								  	 ? AdEL : 
						  Exccode_M_Out == 0 & ifsb_M & ~DMAddr									 ? AdES : Exccode_M_Out;
	wire [31:0] PC = PCEn_M ? PCplus4_M - 4 : 
					 PCEn_E ? PCplus4_E - 4 : 
					 PCEn_D ? PC_D : PC_F;
	wire DelaySlot = PCEn_M ? DelaySlot_M : 
					 PCEn_E ? DelaySlot_E : 
					 PCEn_D ? DelaySlot_D : DelaySlot_F;
	assign PrAddr = AluOut_M;
	assign PrWD = MF_RD2_M;
	assign PrWe = MemWrite_M & TimerAddr & (AluOut_M[3:2] != 2) & ~CP0Req_M;
	assign Addr = PC;
	Forward fwd_M(
		.ForwardSel_MD(ForwardSel_MD), 
		.RD2_M(RD2_M), 
		.PCplus8_W(PCplus8_W), .imm_W(imm_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), .MuxData_W(MuxData_W), .HI_W(HI_W), .LO_W(LO_W), 
		.MF_RD2_M(MF_RD2_M)
		);
	DM dm(
		.clk(clk), .reset(reset), .MemWrite((PrWe ^ MemWrite_M) & ~CP0Req_M), .StoreType(StoreType_M), 
		.Addr(AluOut_M), .WriteData(MF_RD2_M), .PC(PCplus4_M - 4), 
		.DMOut(DMOut_M)
		);
	LoadData load(
		.DataIn(DMOut_M), 
		.LoadType(LoadType_M), 
		.Offset(Offset_M), 
		.DataOut(LoadData_M)
		);
	CP0 cp0(
		.clk(clk), .reset(reset), .CP0Write(CP0Write_M & ~CP0Req_M), 
		.EXLclr(EXLclr_M), 
		.PC((PC >> 2) << 2), .DataIn(MF_RD2_M), 
		// .PC(PCplus4_M - 4), .DataIn(MF_RD2_M), 
		.Exccode(Exccode_M_In), 
		.HWInt(HWInt), 
		.Addr(rd_M), 
		.DelaySlot(DelaySlot), 
		.CP0Req(CP0Req_M), 
		.epc(EPC_M), .DataOut(CP0Data_M)
	    );

	Reg_MtoW MtoW(
		.clk(clk), .reset(reset | clr_MW | CP0Req_M), .stall(stall_MW), 
		.Instr_M(Instr_M), .AluOut_M(AluOut_M), .DMOut_M(CP0Src_M ? CP0Data_M : TimerAddr ? PrRD : LoadData_M), .imm_M(imm_M), .HI_M(HI_M), .LO_M(LO_M), 
		.PCplus4_M(PCplus4_M), .PCplus8_M(PCplus8_M), 
		.A3_M(A3_M), 
		.DelaySlot_M(DelaySlot_M), .PCEn_M(PCEn_M), 
		.DelaySlot_W(DelaySlot_W), .PCEn_W(PCEn_W), 
		.Instr_W(Instr_W), .AluOut_W(AluOut_W), .DMOut_W(DMOut_W), .imm_W(imm_W), .HI_W(HI_W), .LO_W(LO_W), 
		.PCplus4_W(PCplus4_W), .PCplus8_W(PCplus8_W), 
		.A3_W(A3_W)
		);

endmodule
