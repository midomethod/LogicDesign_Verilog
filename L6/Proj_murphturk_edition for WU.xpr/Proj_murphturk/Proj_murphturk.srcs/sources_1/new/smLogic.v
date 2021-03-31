`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2019 02:20:17 PM
// Design Name: 
// Module Name: smLogic
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


module TSMlogic(
    input btnR,
    input btnL,
    input [8:0] Q,
    output countUp,
    output countDw,
    output blinkR,
    output blinkL,
    input [8:0] D
    );
    
    assign D[0] = (btnL & btnR & Q[0]) | (~btnL & ~btnR & (Q[0]|Q[1]|Q[5]));
    assign D[1] = ~btnL & btnR & (Q[0]|Q[1]|Q[2]|Q[4]|Q[8]);
    assign D[2] = btnL & btnR & (Q[3]|Q[1]|Q[2]);
    assign D[3] = btnL & ~btnR & (Q[2]|Q[3]);
    assign D[4] = (btnL & btnR & Q[4])|(~btnL & ~btnR & (Q[3]|Q[4]));
    assign D[5] = btnL & ~btnR & (Q[0]|Q[4]|Q[5]|Q[6]|Q[8]);
    assign D[6] = btnL & btnR & (Q[5]|Q[6]|Q[7]);
    assign D[7] = ~btnL & btnR & (Q[6]|Q[7]);
    assign D[8] = (btnL & btnR & Q[8])|(~btnL & ~btnR & (Q[7]|Q[8]));
    
    assign countUp = (~btnL & ~btnR & Q[7]);
    assign countDw = (~btnL & ~btnR & Q[3]);
    assign blinkR = Q[8];
    assign blinkL = Q[4];
    
endmodule
