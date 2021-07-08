`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:31 11/27/2020 
// Design Name: 
// Module Name:    Comp 
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
module Comp(
	input zero, 
	input [31:0] A, B, 
	output [2:0] Comp_Out
    );
	
	wire [31:0] b = zero ? 0 : B;
	assign Comp_Out = $signed(A) >  $signed(b) ? 3'b100 : 
					  $signed(A) == $signed(b) ? 3'b010 : 
					  $signed(A) <  $signed(b) ? 3'b001 : 3'b0;

endmodule
