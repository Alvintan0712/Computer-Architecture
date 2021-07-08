`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:10 12/23/2020 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
	input clk, reset, CP0Write, 
	input EXLclr, // Ctrl Signal
	input [31:0] PC, DataIn, 
	input [6:2] Exccode, // Exception code
	input [5:0] HWInt, // Interrupt Signal
	input [4:0] Addr, // Register Address
	input DelaySlot, 
	output CP0Req, // CP0 Request
	output [31:0] epc, DataOut
    );

	localparam Int = 0, AdEL = 4, AdES = 5, Syscall = 8, RI = 10, Ov = 12;
	localparam SR = 12, CAUSE = 13, EPC = 14, PrID = 15;
	// SR[15:10] = IM, SR[1] = EXL, SR[0] = IE;
	// Cause[31] = BD, Cause[15:10] = IP, Cause[6:2] = Exccode;

	integer i;
	reg [31:0] Reg [0:31];

	wire [15:10] IM = Reg[SR][15:10], IP = Reg[CAUSE][15:10];
	wire EXL = Reg[SR][1], IE = Reg[SR][0], BD = Reg[CAUSE][31];

	initial begin
		for(i = 0; i < 32; i = i + 1)
			Reg[i] <= i == PrID ? {"k","n","n","b"} : 32'h0;
					  // i == SR   ? {31'h0,1'b1} : 32'h0;
	end

	wire ExcReq = |Exccode & ~EXL;
	wire IntReq = |(HWInt & IM) & IE & ~EXL;
	wire EXLset = CP0Req;

	assign CP0Req = ExcReq | IntReq;
	assign DataOut = Reg[Addr];
	assign epc = Reg[EPC];

	always @ (posedge clk) begin
		if(reset) begin
			for(i = 0; i < 32; i = i + 1)
				Reg[i] <= i == PrID ? {"k","n","n","b"} : 32'h0;
						  // i == SR   ? {31'h0,1'b1} : 32'h0;
		end
		else begin
			Reg[CAUSE][15:10] <= HWInt;
			if(CP0Write && (Addr == 12 || Addr == 14)) Reg[Addr] <= DataIn;
			else begin
				if(EXLset) Reg[SR][1] <= 1'b1;
				if(EXLclr) Reg[SR][1] <= 1'b0;
				if(~EXL) begin
					Reg[CAUSE][31] <= CP0Req ? DelaySlot : Reg[CAUSE][31];
					Reg[CAUSE][6:2] <= CP0Req ? IntReq ? 5'h0 : Exccode : Reg[CAUSE][6:2];
					Reg[EPC] <= CP0Req ? DelaySlot ? PC - 4 : PC : epc;
				end
			end
		end
	end

endmodule
