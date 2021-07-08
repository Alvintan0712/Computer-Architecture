`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:21 11/23/2020 
// Design Name: 
// Module Name:    DataType 
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
module DataType(
	input Sign, 
	input [1:0] Offset, 
	input [31:0] Data, 
	output [31:0] ByteData, HalfData, WordData
    );
	
	assign ByteData = {Sign ? {24{Data[7]}} : 24'h0,Data[8*Offset +: 8]};
	assign HalfData = {Sign ? {16{Data[15]}} : 16'h0,Data[16*Offset[1] +: 16]};
	assign WordData = Data;

endmodule
