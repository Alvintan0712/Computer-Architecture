`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:32 12/13/2020 
// Design Name: 
// Module Name:    Forward 
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
module Forward(
	// Decode
	input [4:0] ForwardSel_D1, ForwardSel_D2, 
	input [31:0] RD1_D, RD2_D, 

	// Execute
	input [4:0] ForwardSel_EA, ForwardSel_EB, 
	input [31:0] PCplus8_E, imm_E, RD1_E, RD2_E, 

	// Memory
	input [2:0] MuxData_M, 
	input [4:0] ForwardSel_MD, 
	input [31:0] PCplus8_M, imm_M, AluOut_M, RD2_M, HI_M, LO_M, 

	// WriteBack
	input [2:0] MuxData_W, 
	input [31:0] PCplus8_W, imm_W, AluOut_W, DMOut_W, HI_W, LO_W, 

	output [31:0] MF_RD1_D, MF_RD2_D, 
	output [31:0] MF_A_E, MF_B_E, 
	output [31:0] MF_RD2_M
    );

	localparam ALU = 0, HI = 1, LO = 2;
	localparam EToD_PC = 1, EToD_EXT = 2, 
			   MToD_PC = 3, MToD_EXT = 4, MToD_ALU = 5, 
			   WToD_PC = 6, WToD_EXT = 7, WToD_ALU = 8, WToD_DM = 9, 

			   MToE_PC = 1, MToE_EXT = 2, MToE_ALU = 3, 
			   WToE_PC = 4, WToE_EXT = 5, WToE_ALU = 6, WToE_DM = 7, 

			   WToM_PC = 1, WToM_EXT = 2, WToM_ALU = 3, WToM_DM = 4;

	assign MF_RD1_D = ForwardSel_D1 == EToD_PC  ? PCplus8_E : 
					  ForwardSel_D1 == EToD_EXT ? imm_E 	: 
					  ForwardSel_D1 == MToD_PC	? PCplus8_M : 
					  ForwardSel_D1 == MToD_EXT	? imm_M		: 
					  ForwardSel_D1 == MToD_ALU	? MuxData_M == ALU ? AluOut_M : 
					  							  MuxData_M == HI  ? HI_M 	  : 
					  							  MuxData_M == LO  ? LO_M 	  : 0 : 
					  ForwardSel_D1 == WToD_PC	? PCplus8_W	: 
					  ForwardSel_D1 == WToD_EXT	? imm_W		: 
					  ForwardSel_D1 == WToD_ALU	? MuxData_W == ALU ? AluOut_W : 
					  							  MuxData_W == HI  ? HI_W     : 
					  							  MuxData_W == LO  ? LO_W     : 0 : 
					  ForwardSel_D1 == WToD_DM	? DMOut_W	: RD1_D;

	assign MF_RD2_D = ForwardSel_D2 == EToD_PC  ? PCplus8_E : 
					  ForwardSel_D2 == EToD_EXT ? imm_E 	: 
					  ForwardSel_D2 == MToD_PC	? PCplus8_M : 
					  ForwardSel_D2 == MToD_EXT	? imm_M		: 
					  ForwardSel_D2 == MToD_ALU	? MuxData_M == ALU ? AluOut_M : 
					  							  MuxData_M == HI  ? HI_M	  : 
					  							  MuxData_M == LO  ? LO_M 	  : 0 : 
					  ForwardSel_D2 == WToD_PC	? PCplus8_W	: 
					  ForwardSel_D2 == WToD_EXT	? imm_W		: 
					  ForwardSel_D2 == WToD_ALU	? MuxData_W == ALU ? AluOut_W : 
					  							  MuxData_W == HI  ? HI_W     : 
					  							  MuxData_W == LO  ? LO_W     : 0 : 
					  ForwardSel_D2 == WToD_DM	? DMOut_W	: RD2_D;

	assign MF_A_E = ForwardSel_EA == MToE_PC  ? PCplus8_M : 
					ForwardSel_EA == MToE_EXT ? imm_M	  : 
					ForwardSel_EA == MToE_ALU ? MuxData_M == ALU ? AluOut_M : 
												MuxData_M == HI  ? HI_M		: 
												MuxData_M == LO  ? LO_M		: 0 : 
					ForwardSel_EA == WToE_PC  ? PCplus8_W : 
					ForwardSel_EA == WToE_EXT ? imm_W	  : 
					ForwardSel_EA == WToE_ALU ? MuxData_W == ALU ? AluOut_W : 
												MuxData_W == HI  ? HI_W		: 
												MuxData_W == LO  ? LO_W		: 0 : 
					ForwardSel_EA == WToE_DM  ? DMOut_W	  : RD1_E;

	assign MF_B_E = ForwardSel_EB == MToE_PC  ? PCplus8_M : 
					ForwardSel_EB == MToE_EXT ? imm_M	  : 
					ForwardSel_EB == MToE_ALU ? MuxData_M == ALU ? AluOut_M : 
												MuxData_M == HI  ? HI_M		: 
												MuxData_M == LO  ? LO_M		: 0 :
					ForwardSel_EB == WToE_PC  ? PCplus8_W : 
					ForwardSel_EB == WToE_EXT ? imm_W	  : 
					ForwardSel_EB == WToE_ALU ? MuxData_W == ALU ? AluOut_W : 
												MuxData_W == HI  ? HI_W		: 
												MuxData_W == LO  ? LO_W		: 0 :
					ForwardSel_EB == WToE_DM  ? DMOut_W	  : RD2_E;

	assign MF_RD2_M = ForwardSel_MD == WToM_PC	? PCplus8_W	: 
					  ForwardSel_MD == WToM_EXT	? imm_W		: 
					  ForwardSel_MD == WToM_ALU	? MuxData_W == ALU ? AluOut_W : 
												  MuxData_W == HI  ? HI_W	  : 
												  MuxData_W == LO  ? LO_W	  : 0 :
					  ForwardSel_MD == WToM_DM	? DMOut_W	: RD2_M;

endmodule
