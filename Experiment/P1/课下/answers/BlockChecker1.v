`timescale 1ns / 1ps
module BlockChecker(
	input clk,
	input reset,
	input [7:0] in,
	output result
	);

	wire isupper = "A" <= in & in <= "Z";
	wire [7:0] char = isupper ? (8'd32|in) : in;

	reg [7:0] s [7:0];
	reg halt = 0;
	integer cnt = 0;

	initial begin
		s[0] <= " ";
		s[1] <= " ";
		s[2] <= " ";
		s[3] <= " ";
		s[4] <= " ";
		s[5] <= " ";
		s[6] <= " ";
		s[7] <= " ";
	end

	wire isbegin = {s[5],s[4],s[3],s[2],s[1],s[0]} == " begin";
	wire isend = {s[3],s[2],s[1],s[0]} == " end";

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			cnt <= 0;
			halt <= 0;
			s[0] <= " ";
			s[1] <= " ";
			s[2] <= " ";
			s[3] <= " ";
			s[4] <= " ";
			s[5] <= " ";
			s[6] <= " ";
			s[7] <= " ";
		end
		else begin
			s[7] <= s[6];
			s[6] <= s[5];
			s[5] <= s[4];
			s[4] <= s[3];
			s[3] <= s[2];
			s[2] <= s[1];
			s[1] <= s[0];
			s[0] <= char;

			halt <= cnt == 0 & isend & char == " " ? 1 : halt;
			cnt <= isbegin & char == " " ? cnt + 1 : 
				   isend & char == " " ? cnt - 1 : cnt;
		end
	end
	assign result = halt ? 0 : 
					cnt == 0 & (isbegin | isend) ? 0 : 
					cnt == 1 & isend ? 1 : 
					|cnt ? 0 : 1;

endmodule
