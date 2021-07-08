`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:40 11/26/2020 
// Design Name: 
// Module Name:    Reg_MtoW 
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
module Reg_MtoW(
	input clk, reset, stall, 
	input [31:0] Instr_M, AluOut_M, DMOut_M, imm_M, HI_M, LO_M, 
	input [31:0] PCplus4_M, PCplus8_M, 
	input [4:0] A3_M, 
	output [31:0] Instr_W, AluOut_W, DMOut_W, imm_W, HI_W, LO_W, 
	output [31:0] PCplus4_W, PCplus8_W, 
	output [4:0] A3_W
    );

	reg [31:0] Instr = 0, AluOut = 0, DMOut = 0, imm = 0, HI = 0, LO = 0;
	reg [31:0] PCplus4 = 32'h3004, PCplus8 = 32'h3008;
	reg [4:0]  A3 = 0;

	always @ (posedge clk) begin
		if(reset) begin
			Instr <= 0;
			AluOut <= 0;
			DMOut <= 0;
			imm <= 0;
			HI <= 0;
			LO <= 0;
			PCplus4 <= 0;
			PCplus8 <= 0;
			A3 <= 0;
		end
		else if(stall) begin
			Instr <= Instr;
			AluOut <= AluOut;
			DMOut <= DMOut;
			imm <= imm;
			HI <= HI;
			LO <= LO;
			PCplus4 <= PCplus4;
			PCplus8 <= PCplus8;
			A3 <= A3;
		end
		else begin
			Instr <= Instr_M;
			AluOut <= AluOut_M;
			DMOut <= DMOut_M;
			imm <= imm_M;
			HI <= HI_M;
			LO <= LO_M;
			PCplus4 <= PCplus4_M;
			PCplus8 <= PCplus8_M;
			A3 <= A3_M;
		end
	end

	assign Instr_W = Instr;
	assign AluOut_W = AluOut;
	assign DMOut_W = DMOut;
	assign imm_W = imm;
	assign HI_W = HI;
	assign LO_W = LO;
	assign PCplus4_W = PCplus4;
	assign PCplus8_W = PCplus8;
	assign A3_W = A3;

endmodule
