`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 12:44:44 AM
// Design Name: 
// Module Name: FullAdder
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


module FullAdder(
    input A,
    input B,
    input Cin,
    output Cout,
    output S
    );
    
wire [3:0] inS;
wire [3:0] inCout;
wire [1:0] sel;

wire NotCin;

assign NotCin = ~Cin;

assign sel      = {A,B};
assign inS      = {Cin, NotCin, NotCin, Cin};
assign inCout   = {1'b1, Cin, Cin, 1'b0};

m4_1e muxS      (.in(inS), .sel(sel), .o(S));
m4_1e muxCout   (.in(inCout), .sel(sel), .o(Cout));

endmodule
