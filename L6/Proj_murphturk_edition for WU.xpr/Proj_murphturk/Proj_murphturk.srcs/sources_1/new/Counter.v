`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 08:37:43 PM
// Design Name: 
// Module Name: Counter
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


module Counter(
    input Increment,
    input Decrement,
    input clk,
    output [7:0] u,
    output negative
    );

    wire [7:0] t, Q, negQ;
    
    assign t[0] = (Increment & ~Decrement & (Increment ^ Q[0])) | (~Increment & Decrement & (Decrement ^ Q[0]) ) | (~Increment & ~Decrement & Q[0]);
    assign t[1] = (Increment & ~Decrement & (Q[1] ^ (Increment & Q[0]))) | (~Increment & Decrement & ~(Q[1]^ (Decrement & Q[0]))) | (~Increment & ~Decrement & Q[1]);
    assign t[2] = (Increment & ~Decrement & (Q[2] ^ (Increment & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[2]^~(Decrement & Q[1] | Q[0]))) | (~Increment & ~Decrement & Q[2]);
    assign t[3] = (Increment & ~Decrement & (Q[3] ^ (Increment & Q[2] & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[3]^~(Decrement & Q[2] | Q[1] | Q[0]))) | (~Increment & ~Decrement & Q[3]);
    assign t[4] = (Increment & ~Decrement & (Q[4] ^ (Increment & Q[3] & Q[2] & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[4]^~(Decrement & Q[3] | Q[2] | Q[1] | Q[0]))) | (~Increment & ~Decrement & Q[4]);
    assign t[5] = (Increment & ~Decrement & (Q[5] ^ (Increment & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[5]^~(Decrement & Q[4] | Q[3] | Q[2] | Q[1] | Q[0]))) | (~Increment & ~Decrement & Q[5]);
    assign t[6] = (Increment & ~Decrement & (Q[6] ^ (Increment & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[6]^~(Decrement & Q[5] | Q[4] | Q[3] | Q[2] | Q[1] | Q[0]))) | (~Increment & ~Decrement & Q[6]);
    assign t[7] = (Increment & ~Decrement & (Q[7] ^ (Increment & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]))) | (~Increment & Decrement & (Q[7]^~(Decrement & Q[6] | Q[5] | Q[4] | Q[3] | Q[2] | Q[1] | Q[0])) ) | (~Increment & ~Decrement & Q[7]);
    
    FDRE #(.INIT(1'b0) ) Dflop0 (.C(clk), .R(), .CE(1), .D(t[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) Dflop1 (.C(clk), .R(), .CE(1), .D(t[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) Dflop2 (.C(clk), .R(), .CE(1), .D(t[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) Dflop3 (.C(clk), .R(), .CE(1), .D(t[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) Dflop4 (.C(clk), .R(), .CE(1), .D(t[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0) ) Dflop5 (.C(clk), .R(), .CE(1), .D(t[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0) ) Dflop6 (.C(clk), .R(), .CE(1), .D(t[6]), .Q(Q[6]));
    FDRE #(.INIT(1'b0) ) Dflop7 (.C(clk), .R(), .CE(1), .D(t[7]), .Q(Q[7]));
    
    assign negQ = -Q;
    assign negative = Q[7];
    
    assign u[0] = (~negative & Q[0]) | (negative & negQ[0]);
    assign u[1] = (~negative & Q[1]) | (negative & negQ[1]);
    assign u[2] = (~negative & Q[2]) | (negative & negQ[2]);
    assign u[3] = (~negative & Q[3]) | (negative & negQ[3]);
    assign u[4] = (~negative & Q[4]) | (negative & negQ[4]);
    assign u[5] = (~negative & Q[5]) | (negative & negQ[5]);
    assign u[6] = (~negative & Q[6]) | (negative & negQ[6]);
    assign u[7] = (~negative & Q[7]) | (negative & negQ[7]);
    
    
endmodule

