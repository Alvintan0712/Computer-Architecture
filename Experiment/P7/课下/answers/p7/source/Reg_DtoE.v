`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:07 11/26/2020 
// Design Name: 
// Module Name:    Reg_DtoE 
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
module Reg_DtoE(
	input clk, reset, stall, 
	input [31:0] Instr_D, RD1_D, RD2_D, imm_D, 
	input [31:0] PCplus4_D, PCplus8_D, 
	input [4:0] A3_D, Exccode_D, 
	input DelaySlot_D, PCEn_D, 
	output DelaySlot_E, PCEn_E, 
	output [31:0] Instr_E, RD1_E, RD2_E, imm_E, 
	output [31:0] PCplus4_E, PCplus8_E, 
	output [4:0] A3_E, Exccode_E
    );
	
	reg [31:0] Instr = 0, RD1 = 0, RD2 = 0, imm = 0;
	reg [31:0] PCplus4 = 32'h3004, PCplus8 = 32'h3008;
	reg [4:0] A3 = 0, Exccode = 0;
	reg DelaySlot = 0, PCEn = 0;

	always @ (posedge clk) begin
		if (reset) begin
			Instr <= 0;
			RD1 <= 0;
			RD2 <= 0;
			imm <= 0;
			A3 <= 0;
			Exccode <= 0;
			PCplus4 <= 32'h3004;
			PCplus8 <= 32'h3008;
			DelaySlot <= 0;
			PCEn <= 0;
		end
		else if (stall) begin
			Instr <= Instr;
			RD1 <= RD1;
			RD2 <= RD2;
			imm <= imm;
			A3 <= A3;
			Exccode <= Exccode;
			PCplus4 <= PCplus4;
			PCplus8 <= PCplus8;
			DelaySlot <= DelaySlot;
			PCEn <= PCEn;
		end
		else begin
			Instr <= Instr_D;
			RD1 <= RD1_D;
			RD2 <= RD2_D;
			imm <= imm_D;
			A3 <= A3_D;
			Exccode <= Exccode_D;
			PCplus4 <= PCplus4_D;
			PCplus8 <= PCplus8_D;
			DelaySlot <= DelaySlot_D;
			PCEn <= PCEn_D;
		end
	end

	assign Instr_E = Instr;
	assign RD1_E = RD1;
	assign RD2_E = RD2;
	assign imm_E = imm;
	assign A3_E = A3;
	assign Exccode_E = Exccode;
	assign PCplus4_E = PCplus4;
	assign PCplus8_E = PCplus8;
	assign DelaySlot_E = DelaySlot;
	assign PCEn_E = PCEn;

endmodule
