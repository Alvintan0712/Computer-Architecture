`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:01 11/26/2020 
// Design Name: 
// Module Name:    PC 
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
module PC(
	input clk, reset, stall, NPC_Sel, 
	input [31:0] NPC, 
	output [31:0] PC
    );
	
	reg [31:0] pc = 32'h3000;

	always @ (posedge clk) begin
		if (reset) pc <= 32'h3000;
		else if (~stall) pc <= NPC_Sel ? NPC : pc + 4;
	end

	assign PC = pc;

endmodule
