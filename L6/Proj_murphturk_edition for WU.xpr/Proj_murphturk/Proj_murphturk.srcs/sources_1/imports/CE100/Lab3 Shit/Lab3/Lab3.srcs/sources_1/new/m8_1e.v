`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 07:57:31 PM
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
    input e,
    output o
    );
    
    assign o = (e & in[0] & ~sel[2] & ~sel[1] & ~sel[0] | e & in[1] & ~sel[2] & ~sel[1] & sel[0] | e & in[2] & ~sel[2] & sel[1] & ~sel[0] | 
                e & in[3] & ~sel[2] & sel[1] & sel[0] | e & in[4] & sel[2] & ~sel[1] & ~sel[0] | e & in[5] & sel[2] & ~sel[1] & sel[0] |
                e & in[6] & sel[2] & sel[1] & ~sel[0] | e & in[7] & sel[2] & sel[1] & sel[0]);
    
endmodule
