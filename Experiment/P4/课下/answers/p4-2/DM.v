`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:32 11/21/2020 
// Design Name: 
// Module Name:    DM 
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
module DM(
	input clk, reset, MemWrite, Byte, Half, 
	input [31:0] Addr, PC, 
	input [31:0] DataWrite, 
	output [31:0] DataRead
    );

	localparam [11:0] RAM_SIZE = 1 << 11;
	reg [31:0] RAM [0:RAM_SIZE - 1];
	integer i;

	wire [11:0] index = Addr >> 2;
	wire [1:0] offset = Addr[1:0];

	initial begin
		for(i = 0; i < RAM_SIZE; i = i + 1)
			RAM[i] <= 32'h0;
	end

	always @ (posedge clk) begin
		if (reset) begin
			for(i = 0; i < RAM_SIZE; i = i + 1)
				RAM[i] <= 32'h0;
		end
		else if (MemWrite) begin
			RAM[index] <= DataWrite;
			$display("@%h: *%h <= %h", PC, Addr, DataWrite);
		end
	end

	assign DataRead = RAM[index];

endmodule
