`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 10:38:29 PM
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(
    input advance,
    input clk,
    output [3:0] ring
    );

FDRE #(.INIT(1'b1) ) ring0 (.C(clk), .R(1'b0), .CE(advance), .D(ring[3]), .Q(ring[0])); 
FDRE #(.INIT(1'b0) ) ring1 (.C(clk), .R(1'b0), .CE(advance), .D(ring[0]), .Q(ring[1])); 
FDRE #(.INIT(1'b0) ) ring2 (.C(clk), .R(1'b0), .CE(advance), .D(ring[1]), .Q(ring[2]));   
FDRE #(.INIT(1'b0) ) ring3 (.C(clk), .R(1'b0), .CE(advance), .D(ring[2]), .Q(ring[3])); 
  
endmodule
