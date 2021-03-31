`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 01:43:16 PM
// Design Name: 
// Module Name: m4_1e
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


module m4_1e(
    input [3:0] in,
    input [1:0] sel,
    input e,
    output o
    );

wire a,b,c,d;

assign a = in[0]&~sel[1]&~sel[0];
assign b = in[1]&~sel[1]&sel[0];
assign c = in[2]&sel[1]&~sel[0];
assign d = in[3]&sel[1]&sel[0];
assign o = e&(a|b|c|d);

endmodule
