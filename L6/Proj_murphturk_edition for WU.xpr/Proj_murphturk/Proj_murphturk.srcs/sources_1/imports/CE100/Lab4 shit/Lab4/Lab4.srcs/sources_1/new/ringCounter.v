`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 12:26:21 AM
// Design Name: 
// Module Name: ringCounter
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


module ringCounter(
    input clk,
    input advance,
    output [3:0] o
    );
    
    FDRE #(.INIT(1'b1) ) ring0 (.C(clk), .R(0), .CE(advance), .D(o[2]), .Q(o[0]));
    FDRE #(.INIT(1'b0) ) ring1 (.C(clk), .R(0), .CE(advance), .D(o[0]), .Q(o[1]));
    FDRE #(.INIT(1'b0) ) ring2 (.C(clk), .R(0), .CE(advance), .D(o[1]), .Q(o[2]));
    FDRE #(.INIT(1'b0) ) ring3 (.C(clk), .R(0), .CE(advance), .D(o[3]), .Q(o[3]));
    
endmodule
