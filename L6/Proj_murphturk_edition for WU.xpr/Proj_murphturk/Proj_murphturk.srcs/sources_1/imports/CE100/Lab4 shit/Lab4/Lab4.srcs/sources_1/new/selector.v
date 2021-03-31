`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 01:10:54 AM
// Design Name: 
// Module Name: selector
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


module selector(
        
     input [3:0] sel,
     input [7:0] N,
     input negative,
     output [3:0] H

    );
    
    assign H[0] = ((sel[2] & negative & 1'b0) | (sel[2] & ~negative & 1'b0) | (sel[1] & N[4]) | (sel[0] & N[0]));
    assign H[1] = ((sel[2] & negative & 1'b0) | (sel[2] & ~negative & 1'b0) | (sel[1] & N[5]) | (sel[0] & N[1]));
    assign H[2] = ((sel[2] & negative & 1'b0) | (sel[2] & ~negative & 1'b0) | (sel[1] & N[6]) | (sel[0] & N[2]));
    assign H[3] = ((sel[2] & negative & 1'b0) | (sel[2] & ~negative & 1'b1) | (sel[1] & N[7]) | (sel[0] & N[3]));
    
endmodule
