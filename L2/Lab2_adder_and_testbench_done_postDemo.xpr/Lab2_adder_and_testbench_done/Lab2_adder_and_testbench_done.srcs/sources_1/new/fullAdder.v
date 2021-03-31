`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 11:48:24 PM
// Design Name: 
// Module Name: fullAdder
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


module fullAdder(
    input a,
    input b,
    input cin,
    output s,
    output cout
    );
    
    assign s = (~a&~b&cin)|(~a&b&~cin)|(a&~b&~cin)|(a&b&cin);
    assign cout = (~a&b&cin)|(a&b&~cin)|(a&~b&cin)|(a&b&cin);
    
endmodule
