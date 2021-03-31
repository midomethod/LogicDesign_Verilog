`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 02:43:15 AM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg(
    input [3:0] n, //The input is a 4 bit = 1 hex
    output [6:0] seg //Privides output to the individual segments
    );

wire NotN3;
assign NotN3 = ~n[3];

wire [2:0] sel;
assign sel = n[2:0];

wire [7:0] in0;
assign in0 = {1'b0, 1'b0, n[3], NotN3, n[3], 1'b0, NotN3, 1'b0};    
m8_1e seg0 (.in(in0), .sel(sel), .o(seg[0])); 

wire [7:0] in1;    
assign in1 = {n[3], 1'b1, NotN3, n[3], n[3], 1'b0, 1'b0, 1'b0};
m8_1e seg1 (.in(in1), .sel(sel), .o(seg[1]));

wire [7:0] in2; 
assign in2 = {n[3], n[3], 1'b0, n[3], 1'b0, NotN3, 1'b0, 1'b0}; 
m8_1e seg2 (.in(in2), .sel(sel), .o(seg[2]));

wire [7:0] in3;
assign in3 = {1'b1, 1'b0, 1'b0, NotN3, 1'b0, n[3], 1'b1, 1'b0};   
m8_1e seg3 (.in(in3), .sel(sel), .o(seg[3]));

wire [7:0] in4;
assign in4 = {NotN3, 1'b0, NotN3, NotN3, NotN3, 1'b0, 1'b1, 1'b0};   
m8_1e seg4 (.in(in4), .sel(sel), .o(seg[4]));

wire [7:0] in5; 
assign in5 = {NotN3, 1'b0, n[3], 1'b0, NotN3, NotN3, NotN3, 1'b0};
m8_1e seg5 (.in(in5), .sel(sel),  .o(seg[5]));

wire [7:0] in6;
assign in6 = {NotN3, 1'b0, 1'b0, n[3], 1'b0, 1'b0, NotN3, NotN3};    
m8_1e seg6 (.in(in6), .sel(sel), .o(seg[6]));

endmodule
