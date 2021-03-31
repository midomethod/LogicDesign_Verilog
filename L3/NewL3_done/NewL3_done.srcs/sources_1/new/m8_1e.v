`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 01:43:16 PM
// Design Name: 
// Module Name: m8_1e
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


module m8_1e(
    input [7:0] in,
    input [2:0] sel,
    output o
    );
    
wire a,b,c,d,f,g,h,i;

assign a = in[0] & ~sel[2] & ~sel[1] & ~sel[0];
assign b = in[1] & ~sel[2] & ~sel[1] & sel[0];
assign c = in[2] & ~sel[2] & sel[1] & ~sel[0];
assign d = in[3] & ~sel[2] & sel[1] & sel[0];
assign f = in[4] & sel[2] & ~sel[1] & ~sel[0];
assign g = in[5] & sel[2] & ~sel[1] & sel[0];
assign h = in[6] & sel[2] & sel[1] & ~sel[0];
assign i = in[7] & sel[2] & sel[1] & sel[0];
assign o = (a|b|c|d|f|g|h|i);
    
endmodule
