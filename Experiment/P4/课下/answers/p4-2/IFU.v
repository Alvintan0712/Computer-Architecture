`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:21:53 11/21/2020 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
	input [31:0] JumpAddr, BranchAddr, 
	input clk, reset, Branch, Jump, 
	output [31:0] Instr, pc
    );

	localparam [11:0] ROM_SIZE = 1 << 11;
	reg [31:0] PC = 32'h3000;
	reg [31:0] ROM [0:ROM_SIZE - 1];

	initial $readmemh("code.txt",ROM);

	always @ (posedge clk) begin
		if (reset) begin
			PC <= 32'h3000;
		end
		else PC <= Branch ? BranchAddr : 
				   Jump ? JumpAddr : PC + 4;
	end

	wire [11:0] index = PC - 32'h3000 >> 2;
	assign Instr = ROM[index];
	assign pc = PC;

endmodule
