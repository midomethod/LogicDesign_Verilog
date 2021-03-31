`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2019 09:53:59 PM
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
    input [3:0] n,
    output [6:0] seg,
    input e
    );
    
     wire [2:0] select;
     assign select[0] = n[1];
     assign select[1] = n[2];
     assign select[2] = n[3];
   
     m8_1e segA (.e(e), .sel(select[2:0]), .in({1'b0, n[0], n[0], 1'b0, 1'b0, ~n[0], 1'b0, n[0]}), .o(seg[0]));
       
     m8_1e segB (.e(e), .sel(select[2:0]), .in({1'b1, ~n[0], n[0], 1'b0, ~n[0], n[0], 1'b0, 1'b0}), .o(seg[1]));
       
     m8_1e segC (.e(e), .sel(select[2:0]), .in({1'b1, ~n[0], 1'b0, 1'b0, 1'b0, 1'b0, ~n[0], 1'b0}), .o(seg[2]));
       
     m8_1e segD (.e(e), .sel(select[2:0]), .in({n[0], 1'b0, ~n[0], 1'b0, n[0], ~n[0], 1'b0, n[0]}), .o(seg[3]));
           
     m8_1e segE (.e(e), .sel(select[2:0]), .in({1'b0, 1'b0, 1'b0, n[0], n[0], 1'b1, n[0], n[0]}), .o(seg[4]));
       
     m8_1e segF (.e(e), .sel(select[2:0]), .in({1'b0, n[0], 1'b0, 1'b0, n[0], 1'b0, 1'b1, n[0]}), .o(seg[5]));
       
     m8_1e segG (.e(e), .sel(select[2:0]), .in({1'b0, ~n[0], 1'b0, 1'b0, n[0], 1'b0, 1'b0, 1'b1}), .o(seg[6]));
       
    
endmodule
