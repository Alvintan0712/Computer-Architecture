`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:49 11/21/2020 
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
	input [3:0] AluCtrl, 
	output [31:0] D
    );

	localparam [3:0] ADD = 1, SUB = 2, OR = 3, AND = 4, XOR = 5, COMP = 6, SLL = 7, SRL = 8, SRA = 9;

	assign D = AluCtrl == ADD  ? A + B : 
			   AluCtrl == SUB  ? A - B : 
			   AluCtrl == OR   ? A | B : 
			   AluCtrl == AND  ? A & B : 
			   AluCtrl == XOR  ? A ^ B : 
			   AluCtrl == COMP ? {29'h0, A > B, A == B, A < B} : 
			   AluCtrl == SLL  ? B << S : 
			   AluCtrl == SRL  ? B >> S : 
			   AluCtrl == SRA  ? $signed($signed(B) >>> S) : 32'h0;

endmodule
