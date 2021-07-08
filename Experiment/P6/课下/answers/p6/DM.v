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
	input [1:0] StoreType, 
	output [31:0] DMOut
    );

	localparam RAM_SIZE = 1 << 15;
	localparam word = 1, byte = 2, half = 3;

	wire [31:0] idx = Addr >> 2;
	wire [1:0] Offset = Addr[1:0];
	reg [31:0] RAM [0:RAM_SIZE - 1];
	integer i;

	initial begin
		for(i = 0; i < RAM_SIZE; i = i + 1)
			RAM[i] <= 32'h0;
	end

	wire [31:0] Data = StoreType == word ? WriteData : 
					   StoreType == byte ? Offset == 2'h0 ? {DMOut[31:8],WriteData[7:0]} : 
					   					   Offset == 2'h1 ? {DMOut[31:16],WriteData[7:0],DMOut[7:0]} : 
					   					   Offset == 2'h2 ? {DMOut[31:24],WriteData[7:0],DMOut[15:0]} : 
					   					   Offset == 2'h3 ? {WriteData[7:0],DMOut[23:0]} : 0 : 
					   StoreType == half ? Offset[1] == 1'b0 ? {DMOut[31:16],WriteData[15:0]} : 
					   					   Offset[1] == 1'b1 ? {WriteData[15:0],DMOut[15:0]}  : 0 : 0;

	always @ (posedge clk) begin
		if (reset) begin
			for(i = 0; i < RAM_SIZE; i = i + 1)
				RAM[i] <= 32'h0;
		end
		else if (MemWrite) begin
			RAM[idx] <= Data;
			$display("%d@%h: *%h <= %h", $time, PC, (Addr >> 2) << 2, Data);
			// $display("@%h: *%h <= %h", PC, (Addr >> 2) << 2, Data);
		end
	end

	assign DMOut = RAM[idx];

endmodule
