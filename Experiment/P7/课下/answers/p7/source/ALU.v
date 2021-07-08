`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:38 11/26/2020 
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
	input sign, 
	input [3:0] AluCtrl, 
	input [31:0] A, B, 
	input [4:0] S, 
	output overflow, 
	output [31:0] D
    );

	localparam ADDU = 1, SUBU = 2, OR = 3, SLL = 4, SRL = 5, SRA = 6, AND = 7, XOR = 8, NOR = 9, SLT = 10, SLTU = 11, SLLV = 12, SRLV = 13, SRAV = 14;
	wire [4:0] AS = A[4:0];

	wire [32:0] temp = AluCtrl == ADDU ? {A[31],A} + {B[31],B} : 
					   AluCtrl == SUBU ? {A[31],A} - {B[31],B} : 32'h0;

	assign overflow = sign ? AluCtrl == ADDU ? temp[32] ^ temp[31] : 
					  		 AluCtrl == SUBU ? temp[32] ^ temp[31] : 0 : 0;

	assign D = AluCtrl == ADDU ? A + B : 
			   AluCtrl == SUBU ? A - B : 
			   AluCtrl == OR   ? A | B : 
			   AluCtrl == SLL  ? B << S : 
			   AluCtrl == SRL  ? B >> S : 
			   AluCtrl == SRA  ? $signed($signed(B) >>> S) : 
			   AluCtrl == AND  ? A & B : 
			   AluCtrl == XOR  ? A ^ B : 
			   AluCtrl == NOR  ? ~(A | B) : 
			   AluCtrl == SLT  ? {31'b0,$signed(A) < $signed(B)} : 
			   AluCtrl == SLTU ? {31'b0,A < B} : 
			   AluCtrl == SLLV ? B << AS : 
			   AluCtrl == SRLV ? B >> AS : 
			   AluCtrl == SRAV ? $signed($signed(B) >>> AS) : 32'h0;

endmodule
