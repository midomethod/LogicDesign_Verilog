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


module slowLED(
                input clk,
                input hS,
                input showCar,
                //////////////////////////////
                output [3:0] out
                );
    
    wire [3:0] Q, D;
    
    assign D[0] = (Q[0]&(~showCar|~hS)) | ((Q[1]|Q[2])&~showCar) | (Q[3]&hS); //INIT
    assign D[1] = (Q[0]&showCar&hS)|(Q[1]&~hS);//showCar
    assign D[2] = (Q[1]&showCar&hS)|(Q[2]&~hS);//showCar
    assign D[3] = (Q[2]&showCar&hS)|(Q[3]&~hS);//gameOver            

    assign out = {1'b1, (Q[1]|Q[2]|Q[3]) , (Q[2]|Q[3]) ,Q[3]};

     FDRE #(.INIT(1'b1)) initSt     (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
     FDRE #(.INIT(1'b0)) showCarSt1  (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
     FDRE #(.INIT(1'b0)) showCarSt2  (.C(clk), .CE(1'b1), .D(D[2]), .Q(Q[2]));
     FDRE #(.INIT(1'b0)) gameOverSt (.C(clk), .CE(1'b1), .D(D[3]), .Q(Q[3]));
     
endmodule
