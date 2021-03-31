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


module FourBitAdder(
    input Cin,
    input [3:0] A,
    input [3:0] B,
    output [3:0] S,
    output Cout
    );

wire a;    
FullAdder Zeroeth (.A(A[0]), .B(B[0]), .Cin(Cin), .Cout(a), .S(S[0])); 
wire b;   
FullAdder First (.A(A[1]), .B(B[1]), .Cin(a), .Cout(b), .S(S[1]));
wire c;   
FullAdder Second (.A(A[2]), .B(B[2]), .Cin(b), .Cout(c), .S(S[2]));
FullAdder Third (.A(A[3]), .B(B[3]), .Cin(c), .Cout(Cout), .S(S[3]));
    
endmodule
