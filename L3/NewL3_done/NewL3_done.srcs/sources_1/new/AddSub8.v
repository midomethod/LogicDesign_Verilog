`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 01:14:23 AM
// Design Name: 
// Module Name: AddSub8
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


module AddSub8(
    input [7:0] A,
    input [7:0] B,
    input sub,
    output [7:0] S,
    output ovfl
    );

//Preparing negative B for the subtraction operation
wire [7:0] InvertedB;
assign InvertedB = ~B;
wire Cout;              //Prepares wire to receive the carry out although we may not use it
wire [7:0] NegativeB;
EightBitAdder MinusB (.Cin(1'b1), .A(8'b00000000), .B(InvertedB), .S(NegativeB), .Cout(Cout));

//Picks the appropriate B based on the select line sub
wire [7:0] AppropriateB;
m2_1x8 Choose (.in0(B), .in1(NegativeB), .sel(sub), .o(AppropriateB));

//Calculates the sum
wire SumCout;
wire [7:0] Sum;
EightBitAdder sum (.Cin(1'b0), .A(A), .B(AppropriateB), .S(Sum), .Cout(SumCout));

assign S = Sum;

//logic for overflow
wire MSBA, MSBB, MSBSum;
assign MSBA = A[7];
assign MSBB = B[7];
assign MSBSum = Sum[7];

assign ovfl =   (MSBA & MSBB & ~MSBSum & ~sub)|(~MSBA & ~MSBB & MSBSum & ~sub)|(MSBA & ~MSBB & ~MSBSum & sub)|(~MSBA & MSBB & MSBSum & sub);
   
endmodule
