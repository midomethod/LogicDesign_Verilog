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


module GameSM(
                input f,
                input onRoad,
                input start,
                input twoSec,
                //////////////////////////////
                output go, goAsrt,
                output idle,
                output resetT,
                output showCar,
                output runGame,
                output gameOver,
                output resetInitialPos
                );
    
    wire [3:0] Q, D;
    
    assign D[0] = Q[0]&~start; //INIT
    assign D[1] = (Q[1]&~twoSec)|((Q[0]|Q[3])&start);//showCar
    assign D[2] = Q[2]&onRoad|Q[1]&twoSec;//runGame
    assign D[3] = Q[3]&~start|Q[2]&~onRoad;//gameOver            
    
    assign resetT = (Q[0]|Q[3])&start|~onRoad&Q[2] ;
    assign showCar = Q[1];
    assign runGame = Q[2];
    assign gameOver = Q[3];
    assign resetInitialPos = start&Q[3]|Q[0];
    assign idle = Q[0];
    assign go = Q[1]&twoSec;
    assign goAsrt = start&(Q[3]|Q[0]);
                  
     FDRE #(.INIT(1'b1)) initSt     (.C(f), .CE(1'b1), .D(D[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) showCarSt  (.C(f), .CE(1'b1), .D(D[1]), .Q(Q[1]));
     FDRE #(.INIT(1'b0)) runGameSt  (.C(f), .CE(1'b1), .D(D[2]), .Q(Q[2]));
     FDRE #(.INIT(1'b0)) gameOverSt (.C(f), .CE(1'b1), .D(D[3]), .Q(Q[3]));
     
endmodule
