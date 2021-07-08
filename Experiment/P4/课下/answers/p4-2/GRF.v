`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:54 11/21/2020 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	input clk, reset, RegWrite, 
	input [4:0] A1, A2, A3, 
	input [31:0] WriteData, PC, 
	output [31:0] RD1, RD2
    );

	reg [31:0] Reg [31:0];
	integer i;
	initial begin
		for(i = 0; i < 32; i = i + 1)
			Reg[i] <= 0;
	end

	always @ (posedge clk) begin
		if (reset) begin
			for(i = 0; i < 32; i = i + 1)
				Reg[i] <= 0;
		end
		else if (RegWrite) begin
			if(|A3) Reg[A3] <= WriteData;
			else Reg[A3] <= 32'h0;
			$display("@%h: $%d <= %h", PC, A3, WriteData);
		end
	end

	assign RD1 = Reg[A1];
	assign RD2 = Reg[A2];

endmodule
