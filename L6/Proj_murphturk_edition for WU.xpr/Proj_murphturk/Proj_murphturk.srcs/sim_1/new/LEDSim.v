`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 10:03:59 PM
// Design Name: 
// Module Name: LEDSim
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


module LEDSim(

    );
    reg clk, RtoL, LtoR;
    wire [7:0] Q;
    
    LedDisplay led_disp(.clk(clk), .Q(Q), .RtoL(RtoL), .LtoR(LtoR));
    
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
        
        RtoL = 0;
        LtoR = 0;
        #100;
        
        RtoL = 1;
        LtoR = 0;
        #200;
        
        RtoL = 0;
        LtoR = 0;
        #100;
  
        RtoL = 0;
        LtoR = 1;
        #100;      
        
        end
  
endmodule
