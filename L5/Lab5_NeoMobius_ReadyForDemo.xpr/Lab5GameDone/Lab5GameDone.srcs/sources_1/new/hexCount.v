`timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 04/25/2019 11:00:16 AM
    // Design Name: 
    // Module Name: countUD4L
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
    
    
    module hexCount(
        input clk,
        input Up,
        input Dw,
        input LD,
        input [3:0] D,
        output [3:0] Q,
        output UTC,
        output DTC
        );
    
    assign UTC = Q[3]&Q[2]&Q[1]&Q[0];
    assign DTC = ~Q[3]&~Q[2]&~Q[1]&~Q[0];
    
    wire nUp, nDw;
    assign nUp = Dw;
    assign nDw = Up;
    
    wire UpEnable, DwEnable, DNEnable; //Makes wires for the enables of Up, Dw, and DN. Don't need LD enable since it is LD itself
    assign UpEnable = nUp&~nDw&~LD;
    assign DwEnable = nDw&~nUp&~LD;
    assign DNEnable = ~LD&(nUp&nDw|~nUp&~nDw);
    
    wire Q0ifDw,Q1ifDw,Q2ifDw,Q3ifDw;
    assign Q0ifDw = Q[0]^DwEnable;
    assign Q1ifDw = Q[1]^(Q[0]&DwEnable);
    assign Q2ifDw = Q[2]^(Q[1]&Q[0]&DwEnable);
    assign Q3ifDw = Q[3]^(Q[2]&Q[1]&Q[0]&DwEnable);
    
    wire Q0ifUp,Q1ifUp,Q2ifUp,Q3ifUp;
    assign Q0ifUp = Q[0]^UpEnable;
    assign Q1ifUp = Q[1]^(~Q[0]&UpEnable);
    assign Q2ifUp = Q[2]^(~Q[1]&~Q[0]&UpEnable);
    assign Q3ifUp = Q[3]^(~Q[2]&~Q[1]&~Q[0]&UpEnable);
    
    wire Q0ifLD,Q1ifLD,Q2ifLD,Q3ifLD;
    assign Q0ifLD = LD&D[0]|~LD&Q[0];
    assign Q1ifLD = LD&D[1]|~LD&Q[1];
    assign Q2ifLD = LD&D[2]|~LD&Q[2];
    assign Q3ifLD = LD&D[3]|~LD&Q[3];
    
    wire D0,D1,D2,D3;
    assign D0 = (Q0ifDw&DwEnable)|(Q0ifUp&UpEnable)|(Q0ifLD&LD)|(Q[0]&DNEnable);
    assign D1 = (Q1ifDw&DwEnable)|(Q1ifUp&UpEnable)|(Q1ifLD&LD)|(Q[1]&DNEnable);
    assign D2 = (Q2ifDw&DwEnable)|(Q2ifUp&UpEnable)|(Q2ifLD&LD)|(Q[2]&DNEnable);
    assign D3 = (Q3ifDw&DwEnable)|(Q3ifUp&UpEnable)|(Q3ifLD&LD)|(Q[3]&DNEnable);  
    
    FDRE #(.INIT(1'b0) ) zeroethBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D0), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) firstBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D1), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) secondBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D2), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) thirdBit (.C(clk), .R(1'b0), .CE(1'b1), .D(D3), .Q(Q[3]));
        
    endmodule
