`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 09:04:30 PM
// Design Name: 
// Module Name: CounterSim
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


module CounterSim(

    );
    
    
        reg Increment, Decrement, clk;
        wire [7:0] u;
        wire negative;
        
        Counter count(.Increment(Increment), .Decrement(Decrement), .clk(clk), .u(u), .negative(negative));
        
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
              
              Increment = 1'b0;
              Decrement = 1'b0;
              #100;
              
              Increment = 1'b1;
              Decrement = 1'b0;
              #100;
              
              Increment = 1'b0;
              Decrement = 1'b1;
              #300; 
               
              Increment = 1'b0;
              Decrement = 1'b0;
              #100; 
              end
        

endmodule
