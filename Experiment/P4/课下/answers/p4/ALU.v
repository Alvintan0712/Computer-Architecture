`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:48 11/16/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [31:0] A, B,
	input [4:0] S,
	input [3:0] Ctrl,
	output [31:0] D,
	output beq, bgt, blt
	);

	localparam addu = 1, subu = 2, Or = 3, sll = 4, srl = 5, sra = 6;
	
	assign D = Ctrl == addu ? A + B : 
			   Ctrl == subu ? A - B : 
			   Ctrl == Or ? A | B : 
			   Ctrl == sll ? B << S : 
			   Ctrl == srl ? B >> S : 
			   Ctrl == sra ? $signed(B) >> S : 0;
	assign beq = A == B;
	assign bgt = A > B;
	assign blt = A < B;

endmodule
