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


module fastLED(
                input clk,
                input qS,
                input runGame,
                //////////////////////////////
                output [3:0] out
                );
    
    wire [3:0] Q, D;
    
    assign D[0] = (Q[0]&(~runGame|~qS)) | ((Q[1]|Q[2])&~runGame) | (Q[3]&qS); //INIT
    assign D[1] = (Q[0]&runGame&qS)|(Q[1]&~qS);//showCar
    assign D[2] = (Q[1]&runGame&qS)|(Q[2]&~qS);//runGame
    assign D[3] = (Q[2]&runGame&qS)|(Q[3]&~qS);//gameOver            

    assign out = {Q[0],Q[1],Q[2],Q[3]};

     FDRE #(.INIT(1'b1)) initSt     (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) showCarSt  (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
     FDRE #(.INIT(1'b0)) runGameSt  (.C(clk), .CE(1'b1), .D(D[2]), .Q(Q[2]));
     FDRE #(.INIT(1'b0)) gameOverSt (.C(clk), .CE(1'b1), .D(D[3]), .Q(Q[3]));
     
endmodule
