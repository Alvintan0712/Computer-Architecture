`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:40 11/26/2020 
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
	
	reg [31:0] Reg [0:31];
	integer i;

	initial begin
		for(i = 0; i < 32; i = i + 1) 
			Reg[i] <= 32'h0;
	end

	always @ (posedge clk) begin
		if (reset) begin
			for(i = 0; i < 32; i = i + 1)
				Reg[i] <= 32'h0;
		end
		else if (RegWrite) begin
			if(|A3) begin
				Reg[A3] <= WriteData;
				$display("%d@%h: $%d <= %h", $time, PC, A3, WriteData);
				// $display("@%h: $%d <= %h", PC, A3, WriteData);
			end
			else Reg[A3] <= 32'h0;
		end
	end

	assign RD1 = RegWrite & |A3 & A3 == A1 ? WriteData : Reg[A1];
	assign RD2 = RegWrite & |A3 & A3 == A2 ? WriteData : Reg[A2];

endmodule
