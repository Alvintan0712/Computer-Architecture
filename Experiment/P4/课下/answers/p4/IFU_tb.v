`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:50:06 11/18/2020
// Design Name:   IFU
// Module Name:   D:/buaa file/Computer Architecture/Verilog/MyCPU/IFU_tb.v
// Project Name:  MyCPU
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
	reg Branch;
	reg Jump;
	reg clk;
	reg reset;
	reg [31:0] BranchPC;
	reg [31:0] JumpPC;

	// Outputs
	wire [31:0] Instr;

	// Instantiate the Unit Under Test (UUT)
	IFU uut (
		.Branch(Branch), 
		.Jump(Jump), 
		.clk(clk), 
		.reset(reset), 
		.BranchPC(BranchPC), 
		.JumpPC(JumpPC), 
		.Instr(Instr)
	);

	initial begin
		// Initialize Inputs
		Branch = 0;
		Jump = 0;
		clk = 0;
		reset = 0;
		BranchPC = 0;
		JumpPC = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

