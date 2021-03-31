`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     UCSC    
// Engineer:    Midori Q Kanuma
// 
// Create Date: 1/15/2020 11:47:13 PM
// Design Name: Lab 2: 3 bit addre with carry-in
// Module Name: threeBitAdder
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


module threeBitAdder(
    input [0:6] sw,
    output [0:6] seg,
    output dp,
    output [0:3] an
    );
    
    wire [0:2] a, b;
    wire cin;
    
    assign cin = sw[0];
    assign a[0] = sw[1];
    assign a[1] = sw[2];
    assign a[2] = sw[3];
    assign b[0] = sw[4];
    assign b[1] = sw[5];
    assign b[2] = sw[6];
    
    wire [0:3] s;
    wire d, e;
    
    fullAdder   zeroethBit   (.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .cout(d));
    fullAdder   firstBit    (.a(a[1]), .b(b[1]), .cin(d), .s(s[1]), .cout(e));
    fullAdder   secondBit   (.a(a[2]), .b(b[2]), .cin(e), .s(s[2]), .cout(s[3]));
    
    wire [0:3] w;
    
    assign w[0] = s[0];
    assign w[1] = s[1];
    assign w[2] = s[2];
    assign w[3] = s[3];
    
    SSDconverter adderToDisplay (.n(w[0:3]),
                                 .seg(seg[0:6]),
                                 .dp(dp), .an(an[0:3]));

endmodule
