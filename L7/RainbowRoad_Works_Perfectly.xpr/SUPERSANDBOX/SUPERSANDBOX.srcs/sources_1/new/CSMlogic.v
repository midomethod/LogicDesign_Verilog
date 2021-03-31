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


module CSMlogic(
                    input hS,
                    input blink,
                    output resetHS,
                    output carOn,
                    output [2:0] D,
                    input [2:0] Q             
                    );
    
    assign D[0] = ~blink&(Q[0]|Q[1]|Q[2]); //ON
    assign D[1] = ( Q[0]&blink )|( Q[1]&blink&~hS )|( Q[2]&blink&hS);//blinkON
    assign D[2] = ( Q[1]&blink&hS )|( Q[2]&blink&~hS );//blinkOff  
    
    assign resetHS = blink&( Q[0]|hS&(Q[1]|Q[2]) );
    assign carOn = Q[0]|Q[1];
endmodule
