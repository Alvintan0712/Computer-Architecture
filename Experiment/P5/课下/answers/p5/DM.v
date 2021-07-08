`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:35 11/26/2020 
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
	input clk, reset, MemWrite, 
	input [31:0] Addr, WriteData, PC, 
	output [31:0] DMOut
    );

	localparam RAM_SIZE = 1 << 15;
	
	wire [11:0] idx = Addr >> 2;
	reg [31:0] RAM [0:RAM_SIZE - 1];
	integer i;

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
			RAM[idx] <= WriteData;
			$display("%d@%h: *%h <= %h", $time, PC, Addr, WriteData);
			// $display("@%h: *%h <= %h", PC, Addr, WriteData);
		end
	end

	assign DMOut = RAM[idx];

endmodule
