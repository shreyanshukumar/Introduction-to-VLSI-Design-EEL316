`timescale 1ns / 1ps
//@SHREYANSHU KUMAR IIT JAMMU
//2016UEE0041
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:41 02/26/2019 
// Design Name: 
// Module Name:    barrel_shifter 
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

module mux2(a,b,s,e,out);   //making 2:1 MUX which can be further instatntiated         

input a,b;
input s,e;
	 output out;
	 wire w,w1;
	 assign w=a&(~s);
	 assign w1=b&s;
	 assign out = (w+w1)&e;
	endmodule

//making barrel shifter by instantiating above MUX
module barrel_SHREYANSHU(A,B,R,H); 
input [7:0]A; //input word 
input R;       //shift direction
input [2:0]B;   //number of shift (0-7)
output [7:0]H;   //updated word
wire [7:0]w1,w2,w3,w31,w32,w21,w22,w11,w12; //signals/wires used

//B[0] shift
mux2 m01(A[0],1'b0,B[0],~R,w11[0]);
mux2 m02(A[0],A[1],B[0],R,w12[0]);
assign w1[0]=w11[0]+w12[0];

mux2 m11(A[1],A[0],B[0],~R,w11[1]);
mux2 m12(A[1],A[2],B[0],R,w12[1]);
assign w1[1]=w11[1]+w12[1];

mux2 m21(A[2],A[1],B[0],~R,w11[2]);
mux2 m22(A[2],A[3],B[0],R,w12[2]);
assign w1[2]=w11[2]+w12[2];

mux2 m31(A[3],A[2],B[0],~R,w11[3]);
mux2 m32(A[3],A[4],B[0],R,w12[3]);
assign w1[3]=w11[3]+w12[3];

mux2 m41(A[4],A[3],B[0],~R,w11[4]);
mux2 m42(A[4],A[5],B[0],R,w12[4]);
assign w1[4]=w11[4]+w12[4];

mux2 m51(A[5],A[4],B[0],~R,w11[5]);
mux2 m52(A[5],A[6],B[0],R,w12[5]);
assign w1[5]=w11[5]+w12[5];

mux2 m61(A[6],A[5],B[0],~R,w11[6]);
mux2 m62(A[6],A[7],B[0],R,w12[6]);
assign w1[6]=w11[6]+w12[6];

mux2 m71(A[7],A[6],B[0],~R,w11[7]);
mux2 m72(A[7],1'b0,B[0],R,w12[7]);
assign w1[7]=w11[7]+w12[7];

// B1 shift  //@SHREYANSHU KUMAR IIT JAMMU
mux2 m011(w1[0],1'b0,B[1],~R,w21[0]);
mux2 m021(w1[0],w1[2],B[1],R,w22[0]);
assign w2[0]=w21[0]+w22[0];

mux2 m111(w1[1],1'b0,B[1],~R,w21[1]);
mux2 m121(w1[1],w1[3],B[1],R,w22[1]);
assign w2[1]=w21[1]+w22[1];

mux2 m211(w1[2],w1[0],B[1],~R,w21[2]);
mux2 m221(w1[2],w1[4],B[1],R,w22[2]);
assign w2[2]=w21[2]+w22[2];

mux2 m311(w1[3],w1[1],B[1],~R,w21[3]);
mux2 m321(w1[3],w1[5],B[1],R,w22[3]);
assign w2[3]=w21[3]+w22[3];

mux2 m411(w1[4],w1[2],B[1],~R,w21[4]);
mux2 m421(w1[4],w1[6],B[1],R,w22[4]);
assign w2[4]=w21[4]+w22[4];

mux2 m511(w1[5],w1[3],B[1],~R,w21[5]);
mux2 m521(w1[5],w1[7],B[1],R,w22[5]);
assign w2[5]=w21[5]+w22[5];

mux2 m611(w1[6],w1[4],B[1],~R,w21[6]);
mux2 m621(w1[6],1'b0,B[1],R,w22[6]);
assign w2[6]=w21[6]+w22[6];

mux2 m711(w1[7],w1[5],B[1],~R,w21[7]);
mux2 m721(w1[7],1'b0,B[1],R,w22[7]);
assign w2[7]=w21[7]+w22[7];
//B2 shift begins

mux2 m012(w2[0],1'b0,B[2],~R,w31[0]);
mux2 m022(w2[0],w2[4],B[2],R,w32[0]);
assign H[0]=w31[0]+w32[0];

mux2 m112(w2[1],1'b0,B[2],~R,w31[1]);
mux2 m122(w2[1],w2[5],B[2],R,w32[1]);
assign H[1]=w31[1]+w32[1];

mux2 m212(w2[2],1'b0,B[2],~R,w31[2]);
mux2 m222(w2[2],w2[6],B[2],R,w32[2]);
assign H[2]=w31[2]+w32[2];

mux2 m312(w2[3],1'b0,B[2],~R,w31[3]);
mux2 m322(w2[3],w2[7],B[2],R,w32[3]);
assign H[3]=w31[3]+w32[3];

mux2 m412(w2[4],w2[0],B[2],~R,w31[4]);
mux2 m422(w2[4],1'b0,B[2],R,w32[4]);
assign H[4]=w31[4]+w32[4];

mux2 m512(w2[5],w2[1],B[2],~R,w31[5]);
mux2 m522(w2[5],1'b0,B[2],R,w32[5]);
assign H[5]=w31[5]+w32[5];

mux2 m612(w2[6],w2[2],B[2],~R,w31[6]);
mux2 m622(w2[6],1'b0,B[2],R,w32[6]);
assign H[6]=w31[6]+w32[6];

mux2 m712(w2[7],w2[3],B[2],~R,w31[7]);
mux2 m722(w2[7],1'b0,B[2],R,w32[7]);
assign H[7]=w31[7]+w32[7];

endmodule 
//@SHREYANSHU KUMAR IIT JAMMU
