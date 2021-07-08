`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:11 11/16/2020 
// Design Name: 
// Module Name:    Extender 
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
module Extender(
	input [15:0] imm16,
	input [25:0] imm26,
	input sign, zero, upper, j,
	output [31:0] imm32
    );

	reg [31:0] imm = 0;
	always @ (*) begin
		if(j) begin
			if(sign) imm = {{6{imm26[25]}},imm26};
			else if(zero) imm = {6'h0,imm26};
			else imm = 0;
		end
		else begin
			if(sign) imm = {{16{imm16[15]}},imm16};
			else if(zero) imm = {16'h0,imm16};
			else if(upper) imm = {imm16,16'h0};
			else imm = 0;
		end
	end

	assign imm32 = imm;

endmodule
