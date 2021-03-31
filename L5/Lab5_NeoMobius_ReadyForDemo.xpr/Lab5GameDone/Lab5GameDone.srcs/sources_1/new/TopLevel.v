`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2019 12:28:24 AM
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


module TopLevel(input clkin,
                input btnR,
                input btnU,
                input btnC,
                //input sw15, //Unlike the Spr2019 lab, cheat switch is not needed
                output [15:0] led,
                output [3:0] an,
                output dp,
                output [6:0] seg
                );

wire clk, digsel, qsec;

    lab5_clks clock(    .clkin(clkin),
                        .greset(btnR),  //btnR
                        .clk(clk),
                        .digsel(digsel),
                        .qsec(qsec)
                        );

wire go, stop;
    assign go = btnC;
    assign stop = btnU;

wire [7:0] Timer;
wire ResetTimer;
    
    TimeCounter thyme(  .clk(clk),
                        .CE(qsec),
                        .R(ResetTimer),
                        
                        
                        
                        
                        
                        .Q(Timer)
                        );
                        
    wire fourSec, twoSec;
        assign twoSec = ~Timer[7]&~Timer[6]&~Timer[5]&~Timer[4]&Timer[3]&~Timer[2]&Timer[1]&~Timer[0];
        assign fourSec = ~Timer[7]&~Timer[6]&~Timer[5]&Timer[4]&~Timer[3]&Timer[2]&~Timer[1]&Timer[0];

wire match, LoadTarget, LoadNumbers, SHR, SHL, flashBoth, flashAlt,idle,playphase;
    
    stateMachine mecha( .clk(clk),
                        .fourSec(fourSec),
                        .twoSec(twoSec),
                        .go(go),
                        .stop(stop),
                        .match(match),
                        .loadT(LoadTarget),// Start Game
                        .resetT(ResetTimer),
                        .loadN(LoadNumbers),
                        .SHR(SHR),
                        .SHL(SHL),
                        .flashA(flashAlt),
                        .flashB(flashBoth),
                        .idle(idle),
                        .playphase(playphase)
                        );
        
wire [7:0] rand;
    
    LFSR random(    .clk(clk),
                    .out(rand[7:0])
                    );

wire [7:0] target;
    FDRE #(.INIT(1'b1) ) targ0 (.C(clk), .CE(LoadTarget), .D(rand[0]), .Q(target[0]));
    FDRE #(.INIT(1'b1) ) targ1 (.C(clk), .CE(LoadTarget), .D(rand[1]), .Q(target[1]));
    FDRE #(.INIT(1'b1) ) targ2 (.C(clk), .CE(LoadTarget), .D(rand[2]), .Q(target[2]));
    FDRE #(.INIT(1'b1) ) targ3 (.C(clk), .CE(LoadTarget), .D(rand[3]), .Q(target[3]));
    FDRE #(.INIT(1'b1) ) targ4 (.C(clk), .CE(LoadTarget), .D(rand[4]), .Q(target[4])); 
    FDRE #(.INIT(1'b1) ) targ5 (.C(clk), .CE(LoadTarget), .D(rand[5]), .Q(target[5])); 
    assign target[7:6] = 2'b00;
    
    
wire [15:0] number;// Since this number is no longer random, we wil omit below segment
    /*FDRE #(.INIT(1'b1) ) num0 (.C(clk), .CE(LoadNumbers), .D(rand[0]), .Q(number[0]));
    FDRE #(.INIT(1'b1) ) num1 (.C(clk), .CE(LoadNumbers), .D(rand[1]), .Q(number[1]));
    FDRE #(.INIT(1'b1) ) num2 (.C(clk), .CE(LoadNumbers), .D(rand[2]), .Q(number[2]));
    FDRE #(.INIT(1'b1) ) num3 (.C(clk), .CE(LoadNumbers), .D(rand[3]), .Q(number[3]));
    FDRE #(.INIT(1'b1) ) num4 (.C(clk), .CE(LoadNumbers), .D(rand[4]), .Q(number[4]));
    FDRE #(.INIT(1'b1) ) num5 (.C(clk), .CE(LoadNumbers), .D(rand[5]), .Q(number[5]));
    FDRE #(.INIT(1'b1) ) num6 (.C(clk), .CE(LoadNumbers), .D(rand[6]), .Q(number[6]));
    FDRE #(.INIT(1'b1) ) num7 (.C(clk), .CE(LoadNumbers), .D(rand[7]), .Q(number[7]));
        */
wire utc;        
    count16 inst1(
                        .clk(clk),
                        .Up(qsec&playphase),
                        .LD(idle|utc),
                        .D(16'h0000),
                        .Q(number)
                );
    assign utc = &(~number^16'h0040);

/*wire [3:0] sum;   // Omitted since no more addition in the game
    FourBitAdder add (  .Cin(1'b0),
                        .A(number[7:4]),
                        .B(number[3:0]),
                        .S(sum[3:0])
                        );
*///
        assign match = &(~target[5:0]^number[5:0]);

wire shiftEnable;                       //Must fix shifter
        assign shiftEnable = SHR|SHL;
    LED_Shifter shwifty(    .in(shiftEnable),
                            .SHR(SHL),
                            .SHL(SHR),
                            .clk(clk),
                            .out(led[15:0])
                            );
wire [3:0] RingOut;
RingCounter RC( .advance(digsel),
                .clk(clk),
                .ring(RingOut)
                );

wire [15:0] disp;
    assign disp = {target[7:0],number[7:0]};
        
        wire [3:0] SelectOut;
        Selector Select(    .sel(RingOut),
                            .N(disp),
                            .H(SelectOut)
                            );
            hex7seg h7s(    .n(SelectOut),
                            .seg(seg[6:0])
                            );
                            
                            
/// Fixed to accomodate both of them flashing                                        
assign an[3] = ~(RingOut[3]&~idle&((Timer[0]&~flashBoth)|(~Timer[0]&~flashAlt)));
assign an[2] = ~(RingOut[2]&~idle&((Timer[0]&~flashBoth)|(~Timer[0]&~flashAlt)));
/*assign an[1] = ~(RingOut[1]&(Timer[0]+~flashAlt&~flashBoth)); 
assign an[0] = ~(RingOut[0]&(Timer[0]+~flashAlt&~flashBoth));   */     
assign an[1] = ~((Timer[0]&RingOut[1])|(~flashBoth&RingOut[1]&~flashAlt)); 
assign an[0] = ~((Timer[0]&RingOut[0])|(~flashBoth&RingOut[0]&~flashAlt));   

endmodule
