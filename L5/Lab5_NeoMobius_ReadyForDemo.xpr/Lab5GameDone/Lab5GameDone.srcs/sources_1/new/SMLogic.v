`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2019 11:00:52 PM
// Design Name: 
// Module Name: SMLogic
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


module SMLogic(
    input fourSec,
    input twoSec,
    input go,
    input stop,
    input match,
    input [4:0] Q,
    output loadT,
    output resetT,
    output loadN,
    output SHR,
    output SHL,
    output flashA,
    output flashB,
    output [4:0] D,
    output idle,
    output playphase
    );

assign D[0] = Q[0]&~go|fourSec&(Q[2]|Q[3]);
assign D[1] = Q[1]&~stop|Q[4]&twoSec;
assign D[2] = (Q[1]&stop&match)|(Q[2]&~fourSec);
assign D[3] = (Q[1]&stop&~match)|(Q[3]&~fourSec);
assign D[4] = Q[0]&go|Q[4]&~twoSec;


assign loadT = Q[0]&go;
assign resetT = (Q[0]&go)|stop;
assign loadN = twoSec&Q[1];
assign SHR = Q[2]&fourSec;
assign SHL = Q[3]&fourSec;
assign flashA = Q[2];
assign flashB = Q[3];
assign idle = Q[0];
assign playphase = Q[1];

endmodule
