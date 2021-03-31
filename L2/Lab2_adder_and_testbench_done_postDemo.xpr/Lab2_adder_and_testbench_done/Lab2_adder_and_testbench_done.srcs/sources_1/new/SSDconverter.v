`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2019 12:47:21 AM
// Design Name: 
// Module Name: SSDconverter
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


module SSDconverter(
    input [0:3] n,
    output [0:6] seg,
    output dp,
    output [0:3] an
    );
    
    assign dp = 1;
    assign an[0] = 0;
    assign an[1] = 1;
    assign an[2] = 1;
    assign an[3] = 1;
    
    wire [0:6] v;
    
    assign v[0] = (n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(~n[3]|n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|~n[0]);
    assign v[1] = (n[3]|~n[2]|n[1]|~n[0])&(n[3]|~n[2]|~n[1]|n[0])&(~n[3]|n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|n[0])&(~n[3]|~n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v[2] = (n[3]|n[2]|~n[1]|n[0])&(~n[3]|~n[2]|n[1]|n[0])&(~n[3]|~n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v[3] = (n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v[4] = (n[3]|n[2]|n[1]|~n[0])&(n[3]|n[2]|~n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|~n[0]);
    assign v[5] = (n[3]|n[2]|n[1]|~n[0])&(n[3]|n[2]|~n[1]|n[0])&(n[3]|n[2]|~n[1]|~n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|~n[0]);
    assign v[6] = (n[3]|n[2]|n[1]|n[0])&(n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|n[0]);
    
    assign seg[0] = ~v[0];
    assign seg[1] = ~v[1];
    assign seg[2] = ~v[2];
    assign seg[3] = ~v[3];
    assign seg[4] = ~v[4];
    assign seg[5] = ~v[5];
    assign seg[6] = ~v[6];
 
endmodule
