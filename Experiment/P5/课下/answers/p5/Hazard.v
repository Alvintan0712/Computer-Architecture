`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:03 11/26/2020 
// Design Name: 
// Module Name:    Hazard 
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
module Hazard(
	// Decode
	input [31:0] Instr_D, 
	input [2:0] Tuse_rs_D, Tuse_rt_D, 

	// Execute
	input [31:0] Instr_E, 
	input [2:0] Tnew_E, 
	input [4:0] A3_E, 

	// Memory
	input [31:0] Instr_M, 
	input [2:0] Tnew_M, 
	input [4:0] A3_M, 

	// WriteBack
	input [31:0] Instr_W, 
	input [2:0] Tnew_W, 
	input [4:0] A3_W, 

	output [4:0] ForwardSel_D1, ForwardSel_D2, ForwardSel_EA, ForwardSel_EB, ForwardSel_MD, 
	output stall_PC, stall_FD, stall_DE, stall_EM, stall_MW, 
	output clr_FD, clr_DE, clr_EM, clr_MW
    );

	localparam F = 0, D = 1, E = 2, M = 3, W = 4;
	localparam EToD_PC = 1, EToD_EXT = 2, 
			   MToD_PC = 3, MToD_EXT = 4, MToD_ALU = 5, 
			   WToD_PC = 6, WToD_EXT = 7, WToD_ALU = 8, WToD_DM = 9, 

			   MToE_PC = 1, MToE_EXT = 2, MToE_ALU = 3, 
			   WToE_PC = 4, WToE_EXT = 5, WToE_ALU = 6, WToE_DM = 7, 

			   WToM_PC = 1, WToM_EXT = 2, WToM_ALU = 3, WToM_DM = 4;

	wire [4:0] rs_D = Instr_D[25:21], rt_D = Instr_D[20:16];
	wire [4:0] rs_E = Instr_E[25:21], rt_E = Instr_E[20:16];
	wire [4:0] rs_M = Instr_M[25:21], rt_M = Instr_M[20:16];

	assign ForwardSel_D1 = |A3_E && rs_D == A3_E ? Tnew_E == F ? EToD_PC  : 
												   Tnew_E == D ? EToD_EXT : 0 : 
						   |A3_M && rs_D == A3_M ? Tnew_M == F ? MToD_PC  : 
						   						   Tnew_M == D ? MToD_EXT : 
						   						   Tnew_M == E ? MToD_ALU : 0 : 
						   |A3_W && rs_D == A3_W ? Tnew_W == F ? WToD_PC	: 
						   						   Tnew_W == D ? WToD_EXT : 
						   						   Tnew_W == E ? WToD_ALU : 
						   						   Tnew_W == M ? WToD_DM  : 0 : 0;

	assign ForwardSel_D2 = |A3_E && rt_D == A3_E ? Tnew_E == F ? EToD_PC  : 
												   Tnew_E == D ? EToD_EXT : 0 : 
						   |A3_M && rt_D == A3_M ? Tnew_M == F ? MToD_PC  : 
						   						   Tnew_M == D ? MToD_EXT : 
						   						   Tnew_M == E ? MToD_ALU : 0 : 
						   |A3_W && rt_D == A3_W ? Tnew_W == F ? WToD_PC	: 
						   						   Tnew_W == D ? WToD_EXT : 
						   						   Tnew_W == E ? WToD_ALU : 
						   						   Tnew_W == M ? WToD_DM  : 0 : 0;

	assign ForwardSel_EA = |A3_M && rs_E == A3_M ? Tnew_M == F ? MToE_PC	: 
												   Tnew_M == D ? MToE_EXT : 
												   Tnew_M == E ? MToE_ALU : 0 : 
						   |A3_W && rs_E == A3_W ? Tnew_W == F ? WToE_PC	: 
						   						   Tnew_W == D ? WToE_EXT : 
						   						   Tnew_W == E ? WToE_ALU : 
						   						   Tnew_W == M ? WToE_DM	: 0 : 0;

	assign ForwardSel_EB = |A3_M && rt_E == A3_M ? Tnew_M == F ? MToE_PC  : 
												   Tnew_M == D ? MToE_EXT : 
												   Tnew_M == E ? MToE_ALU : 0 : 
						   |A3_W && rt_E == A3_W ? Tnew_W == F ? WToE_PC  : 
						   						   Tnew_W == D ? WToE_EXT : 
						   						   Tnew_W == E ? WToE_ALU : 
						   						   Tnew_W == M ? WToE_DM  : 0 : 0;

	assign ForwardSel_MD = |A3_W && rt_M == A3_W ? Tnew_W == F ? WToM_PC	: 
						   						   Tnew_W == D ? WToM_EXT : 
						   						   Tnew_W == E ? WToM_ALU : 
						   						   Tnew_W == M ? WToM_DM  : 0 : 0;

	wire rs_stall = Tuse_rs_D == D & Tnew_E >= E & rs_D == A3_E & |A3_E | 
					Tuse_rs_D == E & Tnew_E >= M & rs_D == A3_E & |A3_E | 
					Tuse_rs_D == D & Tnew_M >= M & rs_D == A3_M & |A3_M ;

	wire rt_stall = Tuse_rt_D == D & Tnew_E >= E & rt_D == A3_E & |A3_E | 
					Tuse_rt_D == E & Tnew_E >= M & rt_D == A3_E & |A3_E | 
					Tuse_rt_D == D & Tnew_M >= M & rt_D == A3_M & |A3_M ;

	assign stall_PC = stall_FD;
	assign stall_FD = clr_DE;
	assign stall_DE = 0;
	assign stall_EM = 0;
	assign stall_MW = 0;

	assign clr_FD = 0;
	assign clr_DE = rs_stall | rt_stall;
	assign clr_EM = 0;
	assign clr_MW = 0;

endmodule
