`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2020 03:29:46 PM
// Design Name: 
// Module Name: InputExtender
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


module InputExtender(   input clk,
                        input f,
                        input in,
                        output out
                        );
    
FDRE #(.INIT(1'b0) ) zeroethBit (.C(clk), .R(1'b0), .CE(f), .D(in), .Q(out));    
endmodule
