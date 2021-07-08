`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:00 11/16/2020 
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
	input [31:0] WriteData, PC, 
	input [10:0] Addr,
	input MemWrite, clk, reset, Byte, Half, Word,
	output [31:0] ReadData
    );

	localparam RAM_SIZE = 2048;
	reg [31:0] RAM [0:RAM_SIZE - 1];
	integer i;

	initial begin
		for(i = 0; i < RAM_SIZE; i = i + 1)
			RAM[i] <= 0;
	end

	always @ (posedge clk) begin
		if(reset) begin
			for(i = 0; i < RAM_SIZE; i = i + 1)
				RAM[i] <= 0;
		end
		else if(MemWrite) begin
			if(Word) begin
				RAM[Addr] <= WriteData;
				$display("@%h: *%h <= %h", PC, {20'h0,Addr} << 2, WriteData);
			end
			else if(Half) begin
				RAM[Addr] <= WriteData[15:0];
			end
			else if(Byte) begin
				RAM[Addr] <= WriteData[7:0];
			end
		end
	end
	assign ReadData = RAM[Addr];

endmodule
