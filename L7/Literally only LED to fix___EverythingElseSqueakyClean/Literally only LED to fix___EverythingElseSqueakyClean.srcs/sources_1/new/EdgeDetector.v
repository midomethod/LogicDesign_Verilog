`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 10:59:35 PM
// Design Name: 
// Module Name: EdgeDetector
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


module EdgeDetector(
    input in,
    input clk,
    output out
    );
    
    wire Q1, Q0;
    
FDRE #(.INIT(1'b0) ) firstff (.C(clk), .R(1'b0), .CE(1'b1), .D(in), .Q(Q1));
FDRE #(.INIT(1'b0) ) secondff (.C(clk), .R(1'b0), .CE(1'b1), .D(Q1), .Q(Q0));

assign out = Q1&~Q0;
    
endmodule
