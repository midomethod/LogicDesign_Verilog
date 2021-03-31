`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 07:27:35 PM
// Design Name: 
// Module Name: BCD_UD4L
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


module counter16(
    input clk,
    input [15:0] init,
    input reset,
    input Up,
    input Dw,
    input LD,
    input [15:0] D,
    output [15:0] Q,
    output UTC,
    output DTC
    );
    
wire UTC1, DTC1;
countUD4L first4bits (.clk(clk),.reset(reset),.init(init[3:0]), .Up(Up), .Dw(Dw), .LD(LD), .D(D[3:0]), .Q(Q[3:0]), .UTC(UTC1), .DTC(DTC1));
wire Up1, Dw1;
assign Up1 = Up&UTC1;
assign Dw1 = Dw&DTC1;

wire UTC2, DTC2;
countUD4L second4bits (.clk(clk),.reset(reset),.init(init[7:4]), .Up(Up1), .Dw(Dw1), .LD(LD), .D(D[7:4]), .Q(Q[7:4]), .UTC(UTC2), .DTC(DTC2));
wire Up2, Dw2;
assign Up2 = Up1&UTC2;
assign Dw2 = Dw1&DTC2;

wire UTC3, DTC3;
countUD4L third4bits (.clk(clk),.reset(reset),.init(init[11:8]), .Up(Up2), .Dw(Dw2), .LD(LD), .D(D[11:8]), .Q(Q[11:8]), .UTC(UTC3), .DTC(DTC3));
wire Up3, Dw3;
assign Up3 = Up2&UTC3;
assign Dw3 = Dw2&DTC3;

wire UTC4, DTC4;
countUD4L last4bits (.clk(clk),.reset(reset),.init(init[15:12]), .Up(Up3), .Dw(Dw3), .LD(LD), .D(D[15:12]), .Q(Q[15:12]), .UTC(UTC4), .DTC(DTC4));

assign UTC = UTC1&UTC2&UTC3&UTC4;
assign DTC = DTC1&DTC2&DTC3&DTC4;

endmodule
