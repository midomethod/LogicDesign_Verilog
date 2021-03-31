`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2019 02:38:45 PM
// Design Name: 
// Module Name: state_machine
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


module RoadSegSM(   input clk,
                    input f,
                    input hf,
                    input runGame,
                    input [9:0] ld,
                    input R,
                    input L,
                    input [9:0] InitialHPos,
                    input [9:0] InitialVPos,
                    input resetInitialPos,
                    output [9:0] hp,
                    output [9:0] vp
                    );

wire [15:0] HPtemp;
wire LoadHposSoon;
counter16 HP(   .clk(hf),
                .reset(resetInitialPos),
                .init({6'b000000,InitialHPos}),
                .Up(runGame&R&~L),
                .Dw(runGame&L&~R),
                .LD(LoadHposSoon),
                .D(/*LoadHposSoon&*/{6'b000000,ld}/*|~LoadHposSoon&{6'b000000,InitialHPos}*/),
                .Q(HPtemp)
                );
                assign hp = HPtemp[9:0];

wire [15:0] VPtemp;
wire LoadVposSoon;
counter16 VP(   .clk(hf),
                .reset(resetInitialPos),
                .init({6'b000000,InitialVPos}),
                .Up(runGame),
                .LD(LoadVposSoon),
                .D({16'h0000}),
                .Q(VPtemp)
                );
                assign vp = VPtemp[9:0];

assign LoadVposSoon = (VPtemp == 559);
    assign LoadHposSoon = LoadVposSoon;
                  
endmodule
