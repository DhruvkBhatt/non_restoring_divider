`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:20 03/13/2020 
// Design Name: 
// Module Name:    non_restoring_division 
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

//This is divide_substep
//1.we compute shift AQ to one bit
//2.Then based on A's sign bit we add that number to m (2*A+m)(if sign bit of A is 1)/or subtract it (2*A-m)(if sign bit of A is 0)
//3.Then based on A's Sign bit we set Q to 0(if sign bit of A is 1) or Q to 1(if sign bit of A is 0).
//4.we return the AQ value
module divide_substep(input wire [31:0]a,input [31:0]Q,
							input wire [31:0] m,
							output [31:0] Anew,output [31:0] Qnew);
	wire [31:0] addam;
	wire [31:0] subam;
	wire t1;
	wire [31:0] temp_a1;
	assign cq0=a[31];
	shifter_32 sh1(temp_a1, a, 2'b10,Q[31],0);
	
	
	Adder myadd(temp_a1,m,addam);
		
	subtractor mysub(temp_a1,m,subam);
	mux2to1_32bits aa1(subam,addam, cq0, Anew);
	wire not_a;
	not n1(not_a,Anew[31]);
	shifter_32 sh11(Qnew, Q, 2'b10,not_a,0);
	
endmodule 

//last of divide algo 
//if sign of A=1 
//then A+M
//else
//no change
module divide_laststep(input [31:0]a,input [31:0] m,output [31:0] remainder);

	wire [31:0] addam;
	assign cq0=a[31];
	Adder myadd(a,m,addam);
	mux2to1_32bits aa1(a,addam, cq0, remainder);
	

endmodule


//main_module that call sub module 32-time and then last step of non_restoring_divide algo and 
//return quation and remainder
//	a/b=quation*b+remainder
module non_restoring_divide(input [31:0]a,b,output [31:0] quation,output [31:0] remainder);
	wire [31:0] Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15;
	wire [31:0] Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31;
	wire [31:0] m;
	wire [31:0] A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15;
	wire [31:0] A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32;
	wire [31:0] q0;
	wire qout;
	//initialize accu with 0
	divide_substep step1(32'h0000000,a,b,A1,Q1);
	divide_substep step2(A1,Q1,b,A2,Q2);
	divide_substep step3(A2,Q2,b,A3,Q3);
	divide_substep step4(A3,Q3,b,A4,Q4);
	divide_substep step5(A4,Q4,b,A5,Q5);
	divide_substep step6(A5,Q5,b,A6,Q6);
	divide_substep step7(A6,Q6,b,A7,Q7);
	divide_substep step8(A7,Q7,b,A8,Q8);
	divide_substep step9(A8,Q8,b,A9,Q9);
	divide_substep step10(A9,Q9,b,A10,Q10);
	divide_substep step11(A10,Q10,b,A11,Q11);
	divide_substep step12(A11,Q11,b,A12,Q12);
	divide_substep step13(A12,Q12,b,A13,Q13);
	divide_substep step14(A13,Q13,b,A14,Q14);
	divide_substep step15(A14,Q14,b,A15,Q15);
	divide_substep step16(A15,Q15,b,A16,Q16);
	divide_substep step17(A16,Q16,b,A17,Q17);
	divide_substep step18(A17,Q17,b,A18,Q18);
	divide_substep step19(A18,Q18,b,A19,Q19);
	divide_substep step20(A19,Q19,b,A20,Q20);
	divide_substep step21(A20,Q20,b,A21,Q21);
	divide_substep step22(A21,Q21,b,A22,Q22);
	divide_substep step23(A22,Q22,b,A23,Q23);
	divide_substep step24(A23,Q23,b,A24,Q24);
	
	divide_substep step25(A24,Q24,b,A25,Q25);
	divide_substep step26(A25,Q25,b,A26,Q26);
	divide_substep step27(A26,Q26,b,A27,Q27);
	divide_substep step28(A27,Q27,b,A28,Q28);

	divide_substep step29(A28,Q28,b,A29,Q29);
	divide_substep step30(A29,Q29,b,A30,Q30);
	divide_substep step31(A30,Q30,b,A31,Q31);
	divide_substep step32(A31,Q31,b,A32,quation);
	//call last step
	divide_laststep stepL(A32,b,remainder);
	 
endmodule


