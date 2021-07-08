`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:54 11/26/2020 
// Design Name: 
// Module Name:    IM 
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
module IM(
	input [31:0] PC, 
	output [31:0] Instr
    );
	
	localparam ROM_SIZE = 1 << 20;
	reg [31:0] ROM [0:ROM_SIZE - 1];

	initial begin
		$readmemh("code.txt",ROM);
		$readmemh("code_handler.txt", ROM, 1120, 2047);
	end

	wire [31:0] idx = PC - 32'h3000 >> 2;
	assign Instr = ROM[idx];

endmodule
