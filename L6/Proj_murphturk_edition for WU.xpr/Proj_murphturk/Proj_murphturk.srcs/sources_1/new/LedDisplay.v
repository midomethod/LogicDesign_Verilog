`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 09:47:58 PM
// Design Name: 
// Module Name: LedDisplay
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


module LedDisplay(
    input LtoR,
    input RtoL,
    input qsec,
    input clk,
    output [7:0] Q
    );
    
    wire [7:0] U, D;
    wire R;
    
    assign R = (Q[0] &  Q[1] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7]);   
    
    
    FDRE #(.INIT(1'b1) ) Rflop0 (.C(clk), .R(R), .CE(RtoL & qsec), .D(1'b1), .Q(U[0]));
    FDRE #(.INIT(1'b0) ) Rflop1 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[0]), .Q(U[1]));
    FDRE #(.INIT(1'b0) ) Rflop2 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[1]), .Q(U[2]));
    FDRE #(.INIT(1'b0) ) Rflop3 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[2]), .Q(U[3]));
    FDRE #(.INIT(1'b0) ) Rflop4 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[3]), .Q(U[4]));
    FDRE #(.INIT(1'b0) ) Rflop5 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[4]), .Q(U[5]));
    FDRE #(.INIT(1'b0) ) Rflop6 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[5]), .Q(U[6]));
    FDRE #(.INIT(1'b0) ) Rflop7 (.C(clk), .R(R), .CE(RtoL & qsec), .D(U[6]), .Q(U[7]));
    
    FDRE #(.INIT(1'b0) ) Lflop0 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[1]), .Q(D[0]));
    FDRE #(.INIT(1'b0) ) Lflop1 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[2]), .Q(D[1]));
    FDRE #(.INIT(1'b0) ) Lflop2 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[3]), .Q(D[2]));
    FDRE #(.INIT(1'b0) ) Lflop3 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[4]), .Q(D[3]));
    FDRE #(.INIT(1'b0) ) Lflop4 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[5]), .Q(D[4]));
    FDRE #(.INIT(1'b0) ) Lflop5 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[6]), .Q(D[5]));
    FDRE #(.INIT(1'b0) ) Lflop6 (.C(clk), .R(R), .CE(LtoR & qsec), .D(D[7]), .Q(D[6]));
    FDRE #(.INIT(1'b1) ) Lflop7 (.C(clk), .R(R), .CE(LtoR & qsec), .D(1'b1), .Q(D[7]));
    
    assign Q[0] = (RtoL & U[0])|(LtoR & D[0]);
    assign Q[1] = (RtoL & U[1])|(LtoR & D[1]);
    assign Q[2] = (RtoL & U[2])|(LtoR & D[2]);
    assign Q[3] = (RtoL & U[3])|(LtoR & D[3]);
    assign Q[4] = (RtoL & U[4])|(LtoR & D[4]);
    assign Q[5] = (RtoL & U[5])|(LtoR & D[5]);
    assign Q[6] = (RtoL & U[6])|(LtoR & D[6]);
    assign Q[7] = (RtoL & U[7])|(LtoR & D[7]);
    
    
    
    
endmodule
