`timescale 1ns / 1ps
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out = 0
    );
	
	reg [1:0] s = 0;
	wire [1:0] op;

	assign op = ("0" <= in && in <= "9") ? 1 : 
				(in == "+" || in == "*") ? 2 : 0;

	always @(posedge clk or posedge clr) begin
		if (clr) begin
			s <= 0;
			out <= 0;
		end
		else begin
			case(s)
				2'h0: s <= op == 'h1 ? 1 : 3;
				2'h1: s <= op == 'h2 ? 2 : 3;
				2'h2: s <= op == 'h1 ? 1 : 3;
				2'h3: s <= 3;
			endcase
			out <= (s == 2'h0 || s == 2'h2) && op == 'h1;
		end
	end

endmodule
