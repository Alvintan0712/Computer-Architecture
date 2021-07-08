`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:39 11/16/2020 
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
	input [4:0] A1, A2, A3,
	input [31:0] WD, PC, 
	input clk, reset, WE,
	output [31:0] RD1, RD2
    );

	reg [31:0] Reg [0:31];
	integer i;

	initial begin
		for(i = 0; i < 32; i = i + 1)
			Reg[i] <= 0;
	end

	always @ (posedge clk) begin
		if(reset) begin
			for(i = 0; i < 32; i = i + 1)
				Reg[i] <= 0;
		end
		else if(WE) begin
			 if(|A3) begin
				Reg[A3] <= WD;
				$display("@%h: $%d <= %h", PC, A3, WD);
			end
			else begin
				$display("@%h: $%d <= %h", PC, A3, WD);
			end
		end
	end
	assign RD1 = Reg[A1];
	assign RD2 = Reg[A2];

endmodule
