`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:27 11/26/2020 
// Design Name: 
// Module Name:    Ext 
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
module Ext(
	input [1:0] ExtCtrl, 
	input [15:0] imm16, 
	output [31:0] imm
    );
	
	localparam zero = 0, sign = 1, upper = 2;

	assign imm = ExtCtrl == zero ? {16'h0,imm16} : 
				 ExtCtrl == sign ? {{16{imm16[15]}},imm16} : 
				 ExtCtrl == upper? {imm16,16'h0} : 0;

endmodule
