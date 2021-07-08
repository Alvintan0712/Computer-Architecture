`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:25 11/26/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk, reset, interrupt, 
	output [31:0] addr
	);

	wire [31:0] PrRD0_In, PrRD1_In, PrRD_Out, PrWD_In, PrWD_Out, PrAddr_In, PrAddr_Out;
	wire [15:10] HWInt_In, HWInt_Out;
	wire PrWe_In, PrWe_Out0, PrWe_Out1;

	assign HWInt_In[15:13] = 0;
	assign HWInt_In[12] = interrupt;
	CPU cpu(
		.clk(clk), .reset(reset), 
		.HWInt(HWInt_Out), // input
		.PrRD(PrRD_Out), // input
		.PrAddr(PrAddr_In), .PrWD(PrWD_In), .Addr(addr), 
		.PrWe(PrWe_In)
		);
	Bridge bridge(
		.PrRD_Out(PrRD_Out), .HWInt_Out(HWInt_Out), .PrAddr_In(PrAddr_In), .PrWD_In(PrWD_In), .PrWe_In(PrWe_In), 
		.PrRD0_In(PrRD0_In), .PrRD1_In(PrRD1_In), .HWInt_In(HWInt_In), .PrAddr_Out(PrAddr_Out), .PrWD_Out(PrWD_Out), 
		.PrWe_Out0(PrWe_Out0), .PrWe_Out1(PrWe_Out1)
		);
	Timer Timer0(.clk(clk), .reset(reset), .Addr(PrAddr_Out[31:2]), .PC(addr), .WE(PrWe_Out0), .Din(PrWD_Out), .Dout(PrRD0_In), .IRQ(HWInt_In[10]));
	Timer Timer1(.clk(clk), .reset(reset), .Addr(PrAddr_Out[31:2]), .PC(addr), .WE(PrWe_Out1), .Din(PrWD_Out), .Dout(PrRD1_In), .IRQ(HWInt_In[11]));

endmodule
