`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2019 02:38:45 PM
// Design Name: 
// Module Name: state_machine
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


module CarSM(
                input f,
                input hS,
                input blink,
                output resetHS,
                output carOn
                );
    
    wire [2:0] Q, D;
    
    CSMlogic logic( 
                    .hS(hS),
                    .blink(blink),
                    .resetHS(resetHS),
                    .carOn(carOn),
                    .D(D),
                    .Q(Q)
                    );   
                  
     FDRE #(.INIT(1'b1)) on         (.C(f), .CE(1'b1), .D(D[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) blinkOff   (.C(f), .CE(1'b1), .D(D[1]), .Q(Q[1]));
     FDRE #(.INIT(1'b0)) blinkOn    (.C(f), .CE(1'b1), .D(D[2]), .Q(Q[2]));

endmodule
