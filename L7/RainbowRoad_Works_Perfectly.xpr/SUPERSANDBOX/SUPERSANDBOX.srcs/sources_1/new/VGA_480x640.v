`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2020 09:53:37 PM
// Design Name: 
// Module Name: VGA_480x640
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


module VGA_480x640(
        input   clk,//Done
        input   [11:0] color,//Done
        output  Vsync,//Done
        output  Hsync,//Done
        output  active,//Done
        output  [3:0] VGA_R,//Done
        output  [3:0] VGA_G,//Done
        output  [3:0] VGA_B,//Done
        output  frame,//Done
        output  halfFrame,//Done
        output  [9:0] Vpos,//Done
        output  [9:0] Hpos//Done
    );

///////////////////////////////////////////////////////////////////////////
//  Simply split the bus into the 3 output bus  
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
    
wire [15:0] hori;
wire [15:0] vert;
wire horimax, vertmax;
    
counter16 hpos(
        .clk(clk),
        .Up(1'b1),
        .LD(horimax),
        .D(16'h0000),
        .Q(hori[15:0])
        );

assign horimax = (hori==799);
assign Hsync = ~((hori<=750)&(hori>=655));
assign Hpos[9:0] = hori[9:0];

counter16 vpos(
        .clk(clk),
        .Up(horimax),
        .LD(vertmax),
        .D(16'h0000),
        .Q(vert[15:0])
        );

assign vertmax = (vert==524);
assign Vsync = ~((vert<=490)&(vert>=489));
assign Vpos[9:0] = vert[9:0];

assign frame = (hori==798) & (vert==523);//Goes high at the end of screen sweep
assign halfFrame = (hori==797)&(vert==522)|frame;//Goes high twice at the end of the screen sweep

assign active = (hori<=639)&(hori>=0)&(vert<=479)&(vert>=0);  

assign VGA_R[3:0] = active*color[11:8];
assign VGA_G[3:0] = active*color[7:4];
assign VGA_B[3:0] = active*color[3:0];
    
endmodule
