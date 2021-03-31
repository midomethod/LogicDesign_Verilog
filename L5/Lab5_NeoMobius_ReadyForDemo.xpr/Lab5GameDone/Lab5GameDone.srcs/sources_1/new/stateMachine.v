`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2019 11:32:44 PM
// Design Name: 
// Module Name: stateMachine
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


module stateMachine(
    input clk,
    input fourSec,
    input twoSec,
    input go,
    input stop,
    input match,
    output loadT,
    output resetT,
    output loadN,
    output SHR,
    output SHL,
    output flashA,
    output flashB,
    output idle,
    output playphase
    );
    
wire [4:0] D;
wire [4:0] Q;
    

SMLogic logic ( .fourSec(fourSec),
                .twoSec(twoSec),
                .go(go),
                .stop(stop),
                .match(match),
                .Q(Q),
                .loadT(loadT),
                .resetT(resetT),
                .loadN(loadN),
                .SHR(SHR),
                .SHL(SHL),
                .flashA(flashA),
                .flashB(flashB),
                .D(D),
                .idle(idle),
                .playphase(playphase)
                );
        
        FDRE #(.INIT(1'b1)) Q0 (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
        FDRE #(.INIT(1'b0)) Q1234[4:1] (.C({4{clk}}), .CE({4{1'b1}}), .D(D[4:1]), .Q(Q[4:1]));
    
endmodule
