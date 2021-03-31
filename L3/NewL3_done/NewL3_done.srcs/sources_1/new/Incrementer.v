`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 12:20:07 PM
// Design Name: 
// Module Name: Incrementer
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


module Incrementer(
        input [7:0] a,
        input [1:0] b,
        output [7:0] s
    );
    
wire [7:0] Add;
    assign Add = {6'b000000,b[1:0]}; 
       
EightBitAdder adding (.Cin(1'b0),.A(a),.B(Add),.S(s),.Cout());
    
endmodule
