`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:27:26 11/16/2020 
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
	input [10:0] Addr,
	output [31:0] Instr
    );

	localparam ROM_SIZE = 2048;
	reg [31:0] ROM [0:ROM_SIZE - 1];

	initial begin
		$readmemh("code.txt",ROM);
	end

	assign Instr = ROM[Addr];

endmodule
