`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 03:08:22 PM
// Design Name: 
// Module Name: main
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


module main(
        input [0:2] sw,
        input btnC,
        output [0:3] led
    );
    
    assign led[0] = ~btnC;
    assign led[1] = sw[0]&sw[1];
    assign led[2] = sw[0]|sw[1];
    assign led[3] = sw[0]^sw[1]^sw[2];
    
endmodule
