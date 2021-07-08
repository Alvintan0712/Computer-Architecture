`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:39:29 11/21/2020 
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
	input [1:0] ExtCtrl, 
	output [31:0] imm
    );
	
	localparam [1:0] zero = 2'h0, sign = 2'h1, upper = 2'h2, jump  = 2'h3;

	assign imm = ExtCtrl == zero  ? {16'h0,imm16} : 
				 ExtCtrl == sign  ? {{16{imm16[15]}},imm16} : 
				 ExtCtrl == upper ? {imm16,16'h0} : 
				 ExtCtrl == jump  ? {4'h0,imm26,2'h0} : 32'h0;

endmodule
