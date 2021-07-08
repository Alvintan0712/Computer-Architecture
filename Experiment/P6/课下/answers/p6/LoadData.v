`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:07:41 12/16/2020 
// Design Name: 
// Module Name:    LoadData 
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
module LoadData(
	input [31:0] DataIn, 
	input [2:0] LoadType, 
	input [1:0] Offset, 
	output [31:0] DataOut
    );

	localparam word = 0, byte = 1, sign_byte = 2, half = 3, sign_half = 4;

	wire [7:0]  DataByte = Offset == 2'h0 ? DataIn[7:0]   	 : 
						   Offset == 2'h1 ? DataIn[15:8]  	 : 
						   Offset == 2'h2 ? DataIn[23:16] 	 : 
						   Offset == 2'h3 ? DataIn[31:24] 	 : 0;
	wire [15:0] DataHalf = Offset[1] == 1'b1 ? DataIn[31:16] : 
						   Offset[1] == 1'b0 ? DataIn[15:0]  : 0;

	assign DataOut = LoadType == word ? DataIn : 
					 LoadType == byte ? {24'h0,DataByte} : 
					 LoadType == sign_byte ? {{24{DataByte[7]}},DataByte} : 
					 LoadType == half ? {16'h0,DataHalf} : 
					 LoadType == sign_half ? {{16{DataHalf[15]}},DataHalf} : 0;

endmodule
