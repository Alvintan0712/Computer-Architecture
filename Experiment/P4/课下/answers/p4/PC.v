`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:27:20 11/16/2020 
// Design Name: 
// Module Name:    PC 
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
module PC(
	input clk, reset, 
	input [31:0] nPC,
	output [10:0] Addr
    );

	reg [10:0] pc = 0;
	always @ (posedge clk, posedge reset) begin
		if(reset) begin
			pc <= 0;
		end
		else pc <= nPC;
	end
	assign Addr = pc;

endmodule
