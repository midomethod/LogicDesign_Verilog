`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 09:40:11 PM
// Design Name: 
// Module Name: TopLevel
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


module TopLevel(
    input clkin,
    input btnR,
    input btnU,
    input btnD,
    input btnC,
    input btnL,
    input [15:0] sw,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );

lab4_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));    //The clock conversion provided for this lab

wire [15:0] Q; //The values stored in the 16-bit register

wire b15_12_areF;
    assign b15_12_areF = Q[15]&Q[14]&Q[13]&Q[12];
wire b11_8_areF;
    assign b11_8_areF = Q[11]&Q[10]&Q[9]&Q[8];
wire b7_4_areF;
    assign b7_4_areF = Q[7]&Q[6]&Q[5]&Q[4];
wire b3_0_aboveC;
    assign b3_0_aboveC = Q[3]&Q[2];
wire noCEdge;
    assign noCEdge = b15_12_areF&b11_8_areF&b7_4_areF&b3_0_aboveC;
wire advanceC;
    assign advanceC = btnC&~noCEdge; //
 
wire UpEdge;
EdgeDetector BtnU (.in(btnU),.clk(clk),.out(UpEdge)); 
wire UpEnable;
    assign UpEnable = UpEdge|advanceC;
   
wire DwEdge;
EdgeDetector BtnD (.in(btnD),.clk(clk),.out(DwEdge)); 

        /// The edge detectors are done at this point:
wire UTC, DTC;
counter16 count16 (.clk(clk),.Up(UpEnable),.Dw(DwEdge),.LD(btnL),.D(sw[15:0]),.Q(Q[15:0]),.UTC(UTC),.DTC(DTC));

wire [3:0] RingOut;
RingCounter Ring (.advance(digsel),.clk(clk),.ring(RingOut[3:0]));

wire [3:0] selectOut;
Selector select (.sel(RingOut[3:0]),.N(Q[15:0]),.H(selectOut[3:0])); // selects most significant 4 bits if ringout=1000 and least significant 4 bits if ringout=0

assign dp = ~((RingOut[2]&UTC)|(RingOut[1]&DTC)); // If 

hex7seg segs (.n(selectOut[3:0]),.seg(seg[6:0])); //it's reasonable to assume that this part is working since it shows correct numbers

assign an = ~RingOut; //I'm assuming this issue has been resolved since all of the 7 segment display is lit up now
assign led = sw;    //This part works as intended
endmodule
