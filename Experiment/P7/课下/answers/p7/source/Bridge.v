`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:34:07 12/23/2020 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
	input [31:0] PrRD0_In, PrRD1_In, PrAddr_In, PrWD_In, 
	input [15:10] HWInt_In, 
	input PrWe_In, 

	output [31:0] PrRD_Out, PrAddr_Out, PrWD_Out, 
	output [15:10] HWInt_Out, 
	output PrWe_Out0, PrWe_Out1
    );

	assign PrRD_Out = 32'h00007f00 <= PrAddr_In & PrAddr_In <= 32'h00007f08 ? PrRD0_In : 
					  32'h00007f10 <= PrAddr_In & PrAddr_In <= 32'h00007f1b ? PrRD1_In : 0;
	assign PrAddr_Out = PrAddr_In;
	assign PrWD_Out = PrWD_In;
	assign HWInt_Out = HWInt_In;
	assign PrWe_Out0 = 32'h00007f00 <= PrAddr_In & PrAddr_In <= 32'h00007f08 & PrWe_In;
	assign PrWe_Out1 = 32'h00007f10 <= PrAddr_In & PrAddr_In <= 32'h00007f1b & PrWe_In;

endmodule
