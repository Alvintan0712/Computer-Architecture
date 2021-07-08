`timescale 1ns / 1ps
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output reg result = 1
    );

	parameter s0 = 'h0, s1 = 'h1,
			  s2 = 'h2, s3 = 'h3,
			  s4 = 'h4, s5 = 'h5,
			  s6 = 'h6;

	reg [2:0] S0 = 0, S1 = 0;
	reg error = 0;
	integer cnt = 0, len = 0;

	wire [7:0] char;
	assign char = in == "B" ? "b" : 
		   		  in == "D" ? "d" :
		   		  in == "E" ? "e" :
		   		  in == "G" ? "g" :
		   		  in == "I" ? "i" :
		   		  in == "N" ? "n" : in;

	wire beg, Beg, en, En;
	assign beg = S0 == s4 && char == "n";
	assign Beg = S0 == s5 && char == " ";
	assign en  = S1 == s2 && char == "d";
	assign En  = S1 == s3 && char == " ";

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			S0 <= 0;
			S1 <= 0;
			cnt <= 0;
			len <= 0;
			error <= 0;
			result <= 1;
		end

		else begin
			case(S0)
				s0: S0 <= len == 0 && char == "b" ? s1 : s0;

				s1: S0 <= char == "e" ? s2 : 
						  char == "b" ? s1 : s0;

				s2: S0 <= char == "g" ? s3 : 
						  char == "b" ? s1 : s0;

				s3: S0 <= char == "i" ? s4 : 
						  char == "b" ? s1 : s0;

				s4: S0 <= char == "n" ? s5 : 
						  char == "b" ? s1 : s0;

				s5: S0 <= char == " " ? s6 : 
						  char == "b" ? s1 : s0;

				s6: S0 <= char == "b" ? s1 : s0;
			endcase

			case(S1)
				s0: S1 <= len == 0 && char == "e" ? s1 : s0;

				s1: S1 <= char == "n" ? s2 : 
						  char == "e" ? s1 : s0;

				s2: S1 <= char == "d" ? s3 : 
						  char == "e" ? s1 : s0;

				s3: S1 <= char == " " ? s4 : 
						  char == "e" ? s1 : s0;

				s4: S1 <= char == "e" ? s1 : s0;
			endcase

			cnt <= error ? cnt : 
				   Beg ? cnt + 1 : 
				   En  ? cnt - 1 : cnt;

			error <= En && cnt == 0 ? 1 : error;

			result <= error ? 				0 : 
					  beg ? 				0 :  
					  cnt == 0 && en ? 		0 : 
					  cnt == 0 && En ? 		0 : 
					  cnt == 1 && en ?		1 : 
					  cnt == 1 && !En ? 	0 : 
					  cnt == 0 && !Beg ? 	1 : 
					  cnt == 1 && en ?		1 : result;

			len <= char == " "? 0 : len + 1;
		end
	end

endmodule
