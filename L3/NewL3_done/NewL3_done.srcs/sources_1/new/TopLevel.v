`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 01:17:40 PM
// Design Name: 
// Module Name: TopLevel
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


module TopLevel(
    input [7:0] sw,
    input btnC,
    input btnL,
    input btnR,
    input clkin,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [0:0] JA
    );

wire [1:0] Add;
    assign Add = {btnL,btnC};

wire [7:0] A; 
wire [7:0] Sum;

assign A = sw[7:0];

Incrementer compute (.a(A),.b(Add),.s(Sum));

wire [3:0] ZeroethHex; 
wire [3:0] FirstHex;
assign ZeroethHex = Sum[3:0];
assign FirstHex = Sum[7:4];

wire [6:0] zeroethSeg;
wire [6:0] firstSeg;
hex7seg zeroethHex (.n(ZeroethHex), .seg(zeroethSeg));
hex7seg firstHex (.n(FirstHex), .seg(firstSeg));

wire [7:0] zeroethSegExtended;
wire [7:0] firstSegExtended;
assign zeroethSegExtended = {1'b0, zeroethSeg};
assign firstSegExtended = {1'b0, firstSeg};

wire dig_sel;
lab3_digsel digitSelection (.clkin(clkin), .greset(btnR), .digsel(dig_sel));

wire [7:0] segOut;

m2_1x8 whichHex (.in0(zeroethSegExtended), .in1(firstSegExtended), .sel(dig_sel), .o(segOut));

assign seg[0] = segOut[0];
assign seg[1] = segOut[1];
assign seg[2] = segOut[2];
assign seg[3] = segOut[3];
assign seg[4] = segOut[4];
assign seg[5] = segOut[5];
assign seg[6] = segOut[6];
wire seg7;
assign seg7 = segOut[7];

assign an[0] = dig_sel;
assign an[1] = ~dig_sel;
assign an[2] = 1'b1;
assign an[3] = 1'b1;
assign dp    = 1'b1;
assign JA[0] = dig_sel;


endmodule
