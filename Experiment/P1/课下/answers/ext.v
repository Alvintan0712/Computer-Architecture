`timescale 1ns / 1ps
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );
	
	assign ext = EOp == 2'h0 ? {{16{imm[15]}},imm} : 
				    EOp == 2'h1 ? {16'h0,imm} : 
				    EOp == 2'h2 ? {imm,16'h0} : 
				    EOp == 2'h3 ? ({{16{imm[15]}},imm} << 2) : 0;

endmodule
