`timescale 1ns / 1ps
//@SHREYANSHU KUMAR IIT JAMMU //2016UEE0041
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:19 02/27/2019 
// Design Name: 
// Module Name:    fulladder 
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
module fulladder(a,b,cin,sum,cout); //making module for 1-bit full adder
		input a,b,cin;
		output sum,cout;
			assign sum= a^b^cin;
			assign cout= (cin&(a^b))+(a&b);
			endmodule
module fulladder6(a1,b1,cin1,sum1,cout1); //making module for 6-bit full adder by instantiating 1-bit full adder 
		input [5:0]a1,b1;
		input cin1;
		output[5:0]sum1;
		output cout1;
		wire s1,s2,s3,s4,s5,s6,c1,c2,c3,c4,c5,c6;
			fulladder f1(a1[0],b1[0],cin1,sum1[0],c1);
			fulladder f2(a1[1],b1[1],c1,sum1[1],c2);
			fulladder f3(a1[2],b1[2],c2,sum1[2],c3);
			fulladder f4(a1[3],b1[3],c2,sum1[3],c4);        //@SHREYANSHU KUMAR IIT JAMMU
			fulladder f5(a1[4],b1[4],c4,sum1[4],c5);
			fulladder f6(a1[5],b1[5],c5,sum1[5],cout1);
		endmodule 

module incdec(A,P,SUM,COUT);
	input [5:0]A;
	input P;
	output [5:0]SUM;
	output COUT;
	wire [5:0]B;
		assign B[0]=1'b1^P;
		assign B[1]=1'b0^P;
		assign B[2]=1'b0^P;
		assign B[3]=1'b0^P;
		assign B[4]=1'b0^P;
		assign B[5]=1'b0^P;
		fulladder6 isn_01(A,B,P,SUM,COUT); //using above 6-bit full adder to perform increament or decreament
endmodule 