`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:40:29 03/13/2020
// Design Name:   non_restoring_divide
// Module Name:   E:/bits/ACA/Verilog_ISE_xilinq_program/non_restoring_division/non_restoring_divide_tb.v
// Project Name:  non_restoring_division
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: non_restoring_divide
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module non_restoring_divide_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] quation;
	wire [31:0] remainder;

	// Instantiate the Unit Under Test (UUT)
	non_restoring_divide uut (
		.a(a), 
		.b(b), 
		.quation(quation), 
		.remainder(remainder)
	);
	
	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		$monitor("at time =",$time," ",a," /",b," = ", quation ," * ",b," + ",remainder);
		// Wait 100 ns for global reset to finish
		a = 32'h00000001;
		b = 32'h00000001;
		
		#10
		a=32'h00000008;
		b=32'h00000003;
		#10
		a=32'h80000000;
		b=32'h00000003;
		#10
		$finish;
        
		// Add stimulus here

	end
      
endmodule

