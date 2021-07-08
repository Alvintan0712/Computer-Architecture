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
	input [3:0] AluCtrl, 
	input [31:0] A, B, 
	input [4:0] S, 
	output [31:0] D
    );
	
	localparam ADDU = 1, SUBU = 2, OR = 3, SLL = 4, SRL = 5, SRA = 6;

	assign D = AluCtrl == ADDU ? A + B : 
			   AluCtrl == SUBU ? A - B : 
			   AluCtrl == OR   ? A | B : 
			   AluCtrl == SLL  ? B << S : 
			   AluCtrl == SRL  ? B >> S : 
			   AluCtrl == SRA  ? $signed($signed(B) >>> S) : 32'h0;

endmodule
