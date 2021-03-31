`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2019 08:56:47 PM
// Design Name: 
// Module Name: LED_Shifter
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


module LED_Shifter(
        input in,
        input SHR,
        input SHL,
        input clk,
        output [15:0] out
    );
    
wire [15:0] Q;

wire CE;
    assign CE = 1'b1; //ties enable high

wire D0;
    assign D0 = (1'b1&in&SHL)|(Q[1]&in&SHR)|(Q[0]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q0 (.C(clk), .R(reset), .CE(CE), .D(D0), .Q(Q[0]));
wire D1;
    assign D1 = (Q[0]&in&SHL)|(Q[2]&in&SHR)|(Q[1]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q1 (.C(clk), .R(reset), .CE(CE), .D(D1), .Q(Q[1]));
wire D2;
    assign D2 = (Q[1]&in&SHL)|(Q[3]&in&SHR)|(Q[2]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q2 (.C(clk), .R(reset), .CE(CE), .D(D2), .Q(Q[2]));
wire D3;
    assign D3 = (Q[2]&in&SHL)|(Q[4]&in&SHR)|(Q[3]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q3 (.C(clk), .R(reset), .CE(CE), .D(D3), .Q(Q[3]));
wire D4;
    assign D4 = (Q[3]&in&SHL)|(Q[5]&in&SHR)|(Q[4]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q4 (.C(clk), .R(reset), .CE(CE), .D(D4), .Q(Q[4]));
wire D5;
    assign D5 = (Q[4]&in&SHL)|(Q[6]&in&SHR)|(Q[5]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q5 (.C(clk), .R(reset), .CE(CE), .D(D5), .Q(Q[5]));
wire D6;
    assign D6 = (Q[5]&in&SHL)|(Q[7]&in&SHR)|(Q[6]&(~in|(in&~SHL&~SHR)));  
        FDRE #(.INIT(1'b0) ) Q6 (.C(clk), .R(reset), .CE(CE), .D(D6), .Q(Q[6]));
wire D7;
    assign D7 = (Q[6]&in&SHL)|(Q[8]&in&SHR)|(Q[7]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q7 (.C(clk), .R(reset), .CE(CE), .D(D7), .Q(Q[7]));
wire D8;
    assign D8 = (Q[7]&in&SHL)|(Q[9]&in&SHR)|(Q[8]&(~in|(in&~SHL&~SHR)));   
        FDRE #(.INIT(1'b0) ) Q8 (.C(clk), .R(reset), .CE(CE), .D(D8), .Q(Q[8]));
wire D9;
    assign D9 = (Q[8]&in&SHL)|(Q[10]&in&SHR)|(Q[9]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q9 (.C(clk), .R(reset), .CE(CE), .D(D9), .Q(Q[9]));
wire D10;
    assign D10 = (Q[9]&in&SHL)|(Q[11]&in&SHR)|(Q[10]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q10 (.C(clk), .R(reset), .CE(CE), .D(D10), .Q(Q[10]));
wire D11;
    assign D11 = (Q[10]&in&SHL)|(Q[12]&in&SHR)|(Q[11]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q11 (.C(clk), .R(reset), .CE(CE), .D(D11), .Q(Q[11]));
wire D12;
    assign D12 = (Q[11]&in&SHL)|(Q[13]&in&SHR)|(Q[12]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q12 (.C(clk), .R(reset), .CE(CE), .D(D12), .Q(Q[12]));
wire D13;
    assign D13 = (Q[12]&in&SHL)|(Q[14]&in&SHR)|(Q[13]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q13 (.C(clk), .R(reset), .CE(CE), .D(D13), .Q(Q[13]));
wire D14;
    assign D14 = (Q[13]&in&SHL)|(Q[15]&in&SHR)|(Q[14]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q14 (.C(clk), .R(reset), .CE(CE), .D(D14), .Q(Q[14]));
wire D15;
    assign D15 = (Q[14]&in&SHL)|(1'b0&in&SHR)|(Q[15]&(~in|(in&~SHL&~SHR)));
        FDRE #(.INIT(1'b0) ) Q15 (.C(clk), .R(reset), .CE(CE), .D(D15), .Q(Q[15]));
assign out[15:0] = Q[15:0];
 
endmodule
