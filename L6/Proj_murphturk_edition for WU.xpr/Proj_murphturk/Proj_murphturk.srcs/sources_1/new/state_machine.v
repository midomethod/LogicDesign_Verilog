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


module TurkeySM(
    input btnR,
    input btnL,
    output countUp,
    output countDw,
    output blinkR,
    output blinkL,
    input clk
    );
    
    wire [8:0] Q, D;
    
    TSMlogic logic( .btnR(btnR),
                   .btnL(btnL),
                   .Q(Q),
                   .countUp(countUp),
                   .countDw(countDw),
                   .blinkR(blinkR),
                   .blinkL(blinkL),
                   .D(D)
                  );   
                  
     FDRE #(.INIT(1'b1)) state0(.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) state1(.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
     FDRE #(.INIT(1'b0)) state2(.C(clk), .CE(1'b1), .D(D[2]), .Q(Q[2]));
     FDRE #(.INIT(1'b0)) state3(.C(clk), .CE(1'b1), .D(D[3]), .Q(Q[3]));
     FDRE #(.INIT(1'b0)) state4(.C(clk), .CE(1'b1), .D(D[4]), .Q(Q[4]));
     FDRE #(.INIT(1'b0)) state5(.C(clk), .CE(1'b1), .D(D[5]), .Q(Q[5]));
     FDRE #(.INIT(1'b0)) state6(.C(clk), .CE(1'b1), .D(D[6]), .Q(Q[6]));
     FDRE #(.INIT(1'b0)) state7(.C(clk), .CE(1'b1), .D(D[7]), .Q(Q[7]));
     FDRE #(.INIT(1'b0)) state8(.C(clk), .CE(1'b1), .D(D[8]), .Q(Q[8]));
     
endmodule
