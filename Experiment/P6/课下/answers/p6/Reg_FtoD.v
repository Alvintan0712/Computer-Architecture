`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:48 11/26/2020 
// Design Name: 
// Module Name:    Reg_FtoD 
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
module Reg_FtoD(
	input clk, reset, stall, 
	input [31:0] Instr_F, PCplus4_F, PCplus8_F, 
	output [31:0] Instr_D, PCplus4_D, PCplus8_D
    );
	
	reg [31:0] Instr = 0, PCplus4 = 32'h3004, PCplus8 = 32'h3008;

	always @ (posedge clk) begin
		if (reset) begin
			Instr <= 0;
			PCplus4 <= 32'h3004;
			PCplus8 <= 32'h3008;
		end
		else if (stall) begin
			Instr <= Instr;
			PCplus4 <= PCplus4;
			PCplus8 <= PCplus8;			
		end
		else begin
			Instr <= Instr_F;
			PCplus4 <= PCplus4_F;
			PCplus8 <= PCplus8_F;			
		end
	end

	assign Instr_D = Instr;
	assign PCplus4_D = PCplus4;
	assign PCplus8_D = PCplus8;

endmodule
