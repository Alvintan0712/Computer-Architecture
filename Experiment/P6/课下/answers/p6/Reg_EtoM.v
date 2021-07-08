`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:24 11/26/2020 
// Design Name: 
// Module Name:    Reg_EtoM 
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
module Reg_EtoM(
	input clk, reset, stall, 
	input [31:0] Instr_E, AluOut_E, WriteData_E, imm_E, HI_E, LO_E, 
	input [31:0] PCplus4_E, PCplus8_E, 
	input [4:0] A3_E, 
	output [31:0] Instr_M, AluOut_M, WriteData_M, imm_M, HI_M, LO_M, 
	output [31:0] PCplus4_M, PCplus8_M, 
	output [4:0] A3_M
    );

	reg [31:0] Instr = 0, AluOut = 0, WriteData = 0, imm = 0, HI = 0, LO = 0;
	reg [31:0] PCplus4 = 32'h3004, PCplus8 = 32'h3008;
	reg [4:0] A3 = 0;

	always @ (posedge clk) begin
		if(reset) begin
			Instr <= 0;
			AluOut <= 0;
			WriteData <= 0;
			imm <= 0;
			HI <= 0;
			LO <= 0;
			PCplus4 <= 32'h3004;
			PCplus8 <= 32'h3008;
			A3 <= 0;
		end
		else if(stall) begin
			Instr <= Instr;
			AluOut <= AluOut;
			WriteData <= WriteData;
			imm <= imm;
			HI <= HI;
			LO <= LO;
			PCplus4 <= PCplus4;
			PCplus8 <= PCplus8;
			A3 <= A3;
		end
		else begin
			Instr <= Instr_E;
			AluOut <= AluOut_E;
			WriteData <= WriteData_E;
			imm <= imm_E;
			HI <= HI_E;
			LO <= LO_E;
			PCplus4 <= PCplus4_E;
			PCplus8 <= PCplus8_E;
			A3 <= A3_E;
		end
	end

	assign Instr_M = Instr;
	assign AluOut_M = AluOut;
	assign WriteData_M = WriteData;
	assign imm_M = imm;
	assign HI_M = HI;
	assign LO_M = LO;
	assign PCplus4_M = PCplus4;
	assign PCplus8_M = PCplus8;
	assign A3_M = A3;

endmodule
