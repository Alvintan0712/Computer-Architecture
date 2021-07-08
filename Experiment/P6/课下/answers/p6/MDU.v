`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:32 12/16/2020 
// Design Name: 
// Module Name:    MDU 
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
module MDU(
	input clk, reset, start, 
	input [3:0] MDU_OP, 
	input [31:0] A, B, 
	output Busy, 
	output [31:0] HI, LO
    );

	localparam mult = 1, div = 2, mthi = 3, mtlo = 4, multu = 5, divu = 6;
	reg [31:0] hi = 0, lo = 0;
	reg busy = 0;
	integer cnt = 0;

	always @ (posedge clk) begin
		if(reset) begin
			hi <= 0; lo <= 0;
			busy <= 0;
			cnt <= 0;
		end
		else if(~busy) begin
			if(start) begin
				case(MDU_OP)
					multu	: {hi,lo} <= A * B;
					divu	: {hi,lo} <= {A % B,A / B};
					mult 	: {hi,lo} <= $signed(A)*$signed(B);
					div 	: {hi,lo} <= {$signed(A) % $signed(B),$signed(A) / $signed(B)};
				endcase
				cnt <= MDU_OP == mult | MDU_OP == multu ? 5  : 
					   MDU_OP == divu | MDU_OP == div   ? 10 : 0;
				busy <= 1'b1;
			end
			else begin
				case(MDU_OP)
					mthi: hi <= A;
					mtlo: lo <= A;
				endcase
			end
		end
		else if(busy) begin
			cnt <= cnt - 1;
			busy <= cnt == 1 ? 0 : busy;
		end
	end

	assign HI = Busy ? 0 : hi;
	assign LO = Busy ? 0 : lo;
	assign Busy = busy;

endmodule
