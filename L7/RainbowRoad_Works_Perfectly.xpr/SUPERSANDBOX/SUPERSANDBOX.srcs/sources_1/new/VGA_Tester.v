`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2020 09:57:33 PM
// Design Name: 
// Module Name: VGA_Tester
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


module VGA_Tester(
        input btnR,//
        input btnL,//
        input btnC,
        input clkin,
        input [15:0] sw,
    output [3:0] an,//
    output [6:0] seg,//
    output [15:0] led,
    output Hsync,//
    output Vsync,//
    output [3:0] vgaRed,//
    output [3:0] vgaGreen,//
    output [3:0] vgaBlue//
    );

lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));    // Note that sw[0] could be used to greset

////////////////////////////////////////////
//  Define the wires
//
//////////////////////////////////////
wire [11:0] red, orange, yellow, green, blue, indigo, violet, white, black, colors; // The colors
wire [9:0]  Hpos, Vpos;             // H and V position of the pointer
wire [9:0] VP4cmp, HP4cmp;          // The pointer position for comparison purposes


wire f, hf, aktiv;                  // Setup wires for the VGA output
wire mvRdL, mvRdR, start;           // Setup wires for detecting input
wire showCar, runGame, gameOver;    // The output wires for the gameSM

////////////////////////////////////
// Predefine the colors
////////////////////////////////////

    assign red      = 12'hf00; 
    assign orange   = 12'hf70; 
    assign yellow   = 12'hff0;
    assign green    = 12'h0f0;
    assign blue     = 12'h00f;
    assign indigo   = 12'h225;
    assign violet   = 12'h80f; 
    assign white    = 12'hfff;
    assign black    = 12'h000;

//////////////////////////////////////
//  Initiate the VGA module
//
////////////////////////////////////////////////
VGA_480x640(
        .clk(clk),//Done
        .color(colors),//Done
        .Vsync(Vsync),//Done
        .Hsync(Hsync),//Done
        .active(aktiv),//Done
        .VGA_R(vgaRed[3:0]),//Done
        .VGA_G(vgaGreen[3:0]),//Done
        .VGA_B(vgaBlue[3:0]),//Done
        .frame(f),//Done
        .halfFrame(hf),//Done
        .Vpos(Vpos),//Done
        .Hpos(Hpos)//Done
        );
        
assign colors = {Hpos[5:0],Vpos[5:0]};

endmodule
