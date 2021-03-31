`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2019 02:48:02 PM
// Design Name: 
// Module Name: SmSim
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


module SmSim(

    );
    
    reg btnL, btnR, clk;
    wire Increment, Decrement, ledLtoR, ledRtoL;
    
    state_machine state(
          .btnR(btnR),
          .btnL(btnL),
          .Increment(Increment),
          .Decrement(Decrement),
          .ledLtoR(ledLtoR),
          .ledRtoL(ledRtoL),
          .clk(clk)
    );
    
     parameter PERIOD = 10;
          parameter real DUTY_CYCLE = 0.5;
          parameter OFFSET = 2;
      
          initial    // Clock process for clkin
          begin
              #OFFSET
                clk = 1'b1;
              forever
              begin
                  #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;
              end
          end
          
          initial
          begin
          
          btnL = 1'b0;
          btnR = 1'b0;
          clk = 1'b0;
          #2000;
          
          btnL = 1'b1;
          btnR = 1'b1;
          #100;
          
          btnL = 1'b0;
          #100;
          
          btnL = 1'b1;
          #100;
          
          btnR = 1'b0;
          #100;
          
          btnL = 1'b0;
          #500;
          
           btnR = 1'b1;
           #100;
                    
           btnL = 1'b1;
           #100;
      
           btnL = 1'b0;
           #100;
           btnR = 1'b0;
           #100;
           
           btnL = 1'b1;
           #100;
           
           btnR = 1'b1;
           #100;
           
           btnL = 1'b0;
           #100;
           
           btnR = 1'b0;
           #100;
           
           
          end
    
endmodule
