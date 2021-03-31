`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 01:02:57 AM
// Design Name: 
// Module Name: EightBitAdder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EightBitAdder(
    input Cin,
    input [7:0] A,
    input [7:0] B,
    output [7:0] S,
    output Cout
    );

wire a;    
FullAdder Zeroeth (.A(A[0]), .B(B[0]), .Cin(Cin), .Cout(a), .S(S[0])); 
wire b;   
FullAdder First (.A(A[1]), .B(B[1]), .Cin(a), .Cout(b), .S(S[1]));
wire c;   
FullAdder Second (.A(A[2]), .B(B[2]), .Cin(b), .Cout(c), .S(S[2]));
wire d;   
FullAdder Third (.A(A[3]), .B(B[3]), .Cin(c), .Cout(d), .S(S[3]));
wire f;   
FullAdder Fourth (.A(A[4]), .B(B[4]), .Cin(d), .Cout(f), .S(S[4]));
wire g;   
FullAdder Fifth (.A(A[5]), .B(B[5]), .Cin(f), .Cout(g), .S(S[5]));
wire h;   
FullAdder Sixth (.A(A[6]), .B(B[6]), .Cin(g), .Cout(h), .S(S[6]));
// No wire needed here as this is the final carryout   
FullAdder Seventh (.A(A[7]), .B(B[7]), .Cin(h), .Cout(Cout), .S(S[7]));
    
endmodule
