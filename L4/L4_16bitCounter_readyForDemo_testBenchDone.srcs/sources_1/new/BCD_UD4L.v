`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 07:27:35 PM
// Design Name: 
// Module Name: BCD_UD4L
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


module BCD_UD4L(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [3:0] D,
    output [3:0] Q,
    output UTC,
    output DTC
    );
    
    wire UpEnable, DwEnable, DNEnable; //Makes wires for the enables of Up, Dw, and DN. Don't need LD enable since it is LD itself
    assign UpEnable = Up&~Dw&~LD;
    assign DwEnable = Dw&~Up&~LD;
    assign DNEnable = ~LD&(Up&Dw|~Up&~Dw);
    
wire Q0ifUp,Q1ifUp,Q2ifUp,Q3ifUp;
    assign Q0ifUp = Q[0]^UpEnable;
    assign Q1ifUp = (~Q[0]&Q[1])|(Q[1]&~UpEnable)|(UpEnable&Q[0]&~Q[1]&~Q[3]);
    assign Q2ifUp = (Q[2]&~UpEnable)|(Q[2]&~Q[1])|(Q[2]&~Q[0])|(UpEnable&~Q[2]&Q[1]&Q[0]);//fixedthis line
    assign Q3ifUp = (~Q[0]&Q[3])|(~UpEnable&~Q[1]&Q[3])|(UpEnable&Q[0]&Q[1]&Q[2]);

wire Q0ifDw,Q1ifDw,Q2ifDw,Q3ifDw;
    assign Q0ifDw = (DwEnable&~Q[0])|(~DwEnable&Q[0]);
    assign Q1ifDw = (~DwEnable&Q[1])|(DwEnable&Q[0]&Q[1])|(DwEnable&Q[2]&~Q[1]&~Q[0])|(DwEnable&Q[3]&~Q[1]&~Q[0]);
    assign Q2ifDw = (~DwEnable&Q[2])|(DwEnable&~Q[0]&Q[3])|(Q[0]&Q[2])|(Q[1]&Q[2]);
    assign Q3ifDw = (Q[3]&Q[0])|(Q[3]&~DwEnable)|(DwEnable&~Q[0]&~Q[1]&~Q[2]&~Q[3]);
    
wire OverLimit;
    assign OverLimit = (D[3]&D[1])|(D[3]&D[2]);
    
wire Q0ifLD,Q1ifLD,Q2ifLD,Q3ifLD;
    assign Q0ifLD = (OverLimit&1'b1)|(~OverLimit&D[0]);
    assign Q1ifLD = (OverLimit&1'b0)|(~OverLimit&D[1]);
    assign Q2ifLD = (OverLimit&1'b0)|(~OverLimit&D[2]);
    assign Q3ifLD = (OverLimit&1'b1)|(~OverLimit&D[3]);
    
wire D0,D1,D2,D3;
    assign D0 = (Q0ifDw&DwEnable)|(Q0ifUp&UpEnable)|(Q0ifLD&LD)|(Q[0]&DNEnable);
    assign D1 = (Q1ifDw&DwEnable)|(Q1ifUp&UpEnable)|(Q1ifLD&LD)|(Q[1]&DNEnable);
    assign D2 = (Q2ifDw&DwEnable)|(Q2ifUp&UpEnable)|(Q2ifLD&LD)|(Q[2]&DNEnable);
    assign D3 = (Q3ifDw&DwEnable)|(Q3ifUp&UpEnable)|(Q3ifLD&LD)|(Q[3]&DNEnable);  
    
    FDRE #(.INIT(1'b0) ) zeroethBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D0), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) firstBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D1), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) secondBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D2), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) thirdBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D3), .Q(Q[3]));   
    
assign UTC = Q[3]&~Q[2]&~Q[1]&Q[0];
assign DTC = ~Q[3]&~Q[2]&~Q[1]&~Q[0];   
 
endmodule
