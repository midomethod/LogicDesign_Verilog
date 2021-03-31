`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2019 08:20:36 PM
// Design Name: 
// Module Name: TimeCounter
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


module TimeCounter(
    input clk,
    input CE,
    input R,
    output [7:0] Q
    );

wire UTC1;
    
hexCount first4bits (   .clk(clk),
                        .Up(CE),
                        .LD(R),
                        .D(4'b0000),
                        .Q(Q[3:0]),
                        .UTC(UTC1)
                     );

wire Up;
    assign Up = CE&UTC1;

hexCount second4bits (
                        .clk(clk),
                        .Up(Up),
                        .LD(R),
                        .D(4'b0000),
                        .Q(Q[7:4])
                    );                     
        

endmodule
