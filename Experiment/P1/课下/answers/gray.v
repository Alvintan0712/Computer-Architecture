`timescale 1ns / 1ps
module gray(
    input Clk,
    input Reset,
    input En,
    output reg [2:0] Output = 0,
    output reg Overflow = 0
    );

	parameter s0 = 3'b000,
			  s1 = 3'b001,
			  s2 = 3'b011,
			  s3 = 3'b010,
			  s4 = 3'b110,
			  s5 = 3'b111,
			  s6 = 3'b101,
			  s7 = 3'b100;

	always @(posedge Clk) begin
		if (Reset) begin
			Output <= 0;
			Overflow <= 0;
		end
		else if(En) begin
			case(Output)
				s0: Output <= s1;
				s1: Output <= s2;
				s2: Output <= s3;
				s3: Output <= s4;
				s4: Output <= s5;
				s5: Output <= s6;
				s6: Output <= s7;
				s7: Output <= s0;
			endcase
			Overflow <= Output == s7? 1 : Overflow;
		end
	end

endmodule
