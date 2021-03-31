`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 10:53:07 PM
// Design Name: 
// Module Name: TopModule
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
    input btnR,
    input btnL,
    input btnU,
    input clkin,
    output [3:0] an,
    output [6:0] seg,
    output [15:0] led
    );
    
    wire clk, digsel, qsec;
    
    lab6_clks slowit (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    wire countUp,countDw,blinkR,blinkL,neg, R, L;
        wire [7:0] U;
        wire [6:0] S;
        wire [3:0] ringOut, selOut;
        wire [11:0] N;
        
    TurkeySM SM(.btnR(btnR), 
                        .btnL(btnL), 
                        .clk(clk), 
                        .countUp(countUp), 
                        .countDw(countDw),
                        .blinkR(blinkR),
                        .blinkL(blinkL)
                        );
                        
    FDRE #(.INIT(1'b0)) SML(.C(clk), .R(blinkL), .CE(blinkR), .D(1'b1), .Q(R));
    FDRE #(.INIT(1'b0)) SMR(.C(clk), .R(blinkR), .CE(blinkL), .D(1'b1), .Q(L));
    
    
                        
     LedDisplay disp(.LtoR(R&~(btnR|btnL)), .RtoL(L&~(btnR|btnL)), .clk(clk), .qsec(qsec), .Q(led[7:0]));
     
     Counter count(.Increment(countUp), .Decrement(countDw), .clk(clk), .negative(neg), .u(U)); 
     
     ringCounter ring(.clk(clk), .advance(digsel), .o(ringOut));
     
     selector select(.sel(ringOut), .N(U), .negative(neg), .H(selOut));
     
     hex7seg(.n(selOut), .seg(S), .e(1'b1));
     
     assign led[8] = ~btnR;
     assign led[15] = ~btnL;
     assign led[14:9] = 6'b000000;
     
     assign an = ~ringOut;
     
     assign seg[0] = (ringOut[2] & ~S[0])|(ringOut[1] & S[0])|(ringOut[0] & S[0]);
     assign seg[1] = (ringOut[2] & ~S[1])|(ringOut[1] & S[1])|(ringOut[0] & S[1]);
     assign seg[2] = (ringOut[2] & ~S[2])|(ringOut[1] & S[2])|(ringOut[0] & S[2]);
     assign seg[3] = (ringOut[2] & ~S[3])|(ringOut[1] & S[3])|(ringOut[0] & S[3]);
     assign seg[4] = (ringOut[2] & ~S[4])|(ringOut[1] & S[4])|(ringOut[0] & S[4]);
     assign seg[5] = (ringOut[2] & ~S[5])|(ringOut[1] & S[5])|(ringOut[0] & S[5]);
     assign seg[6] = (ringOut[2] & ~S[6])|(ringOut[1] & S[6])|(ringOut[0] & S[6]);
    
endmodule
