`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:12 11/22/2020
// Design Name:   IFU
// Module Name:   D:/buaa file/Computer Architecture/Verilog/p4/IFU_tb.v
// Project Name:  p4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IFU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IFU_tb;

	// Inputs
	reg [31:0] JumpAddr;
	reg [31:0] BranchAddr;
	reg clk;
	reg reset;
	reg Branch;
	reg Jump;

	// Outputs
	wire [31:0] Instr;
	wire [31:0] pc;

	// Instantiate the Unit Under Test (UUT)
	IFU uut (
		.JumpAddr(JumpAddr), 
		.BranchAddr(BranchAddr), 
		.clk(clk), 
		.reset(reset), 
		.Branch(Branch), 
		.Jump(Jump), 
		.Instr(Instr), 
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		JumpAddr = 0;
		BranchAddr = 0;
		clk = 0;
		reset = 0;
		Branch = 0;
		Jump = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

