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


module hex7seg(
    input [3:0] n,
    output [6:0] seg
    );
    
   
    wire v0, v1, v2, v3, v4, v5, v6;
    
    assign v0 = (n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(~n[3]|n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|~n[0]);
    assign v1 = (n[3]|~n[2]|n[1]|~n[0])&(n[3]|~n[2]|~n[1]|n[0])&(~n[3]|n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|n[0])&(~n[3]|~n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v2 = (n[3]|n[2]|~n[1]|n[0])&(~n[3]|~n[2]|n[1]|n[0])&(~n[3]|~n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v3 = (n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|n[2]|~n[1]|n[0])&(~n[3]|~n[2]|~n[1]|~n[0]);
    assign v4 = (n[3]|n[2]|n[1]|~n[0])&(n[3]|n[2]|~n[1]|~n[0])&(n[3]|~n[2]|n[1]|n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|n[1]|~n[0]);
    assign v5 = (n[3]|n[2]|n[1]|~n[0])&(n[3]|n[2]|~n[1]|n[0])&(n[3]|n[2]|~n[1]|~n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|~n[0]);
    assign v6 = (n[3]|n[2]|n[1]|n[0])&(n[3]|n[2]|n[1]|~n[0])&(n[3]|~n[2]|~n[1]|~n[0])&(~n[3]|~n[2]|n[1]|n[0]);
    
    assign seg[0] = ~v0;
    assign seg[1] = ~v1;
    assign seg[2] = ~v2;
    assign seg[3] = ~v3;
    assign seg[4] = ~v4;
    assign seg[5] = ~v5;
    assign seg[6] = ~v6;
 
endmodule
