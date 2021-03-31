`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 09:56:44 AM
// Design Name: 
// Module Name: count_test
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


module Countertest();

reg clkin, Up, Dw, LD;
reg [3:0] Din;
wire UTC, DTC;
wire [3:0] Q;

BCD_UD4L count(.clk(clkin), .Up(Up), .Dw(Dw), .LD(LD), .D(Din), .Q(Q), .UTC(UTC), .DTC(DTC));

 parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clkin = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
        end
    end
    
    initial
    begin
    
    Up = 1'b0;
    Dw = 1'b0;
    LD = 1'b1;
    Din[0] = 1'b0;
    Din[1] = 1'b0;
    Din[2] = 1'b0;
    Din[3] = 1'b0;
    
   #100;
   
    Up = 1'b1;
    Dw = 1'b0;
    LD = 1'b0;
    
   #100;
   
    Up = 1'b0;
      Dw = 1'b0;
      LD = 1'b0;
      
  #100;
         
          Up = 1'b1;
          Dw = 1'b0;
          LD = 1'b0;
          
         #100;
         
          Up = 1'b0;
            Dw = 1'b0;
            LD = 1'b0;

#100;
   
    Up = 1'b1;
    Dw = 1'b0;
    LD = 1'b0;
    
   #100;
   
    Up = 1'b0;
      Dw = 1'b0;
      LD = 1'b0;
   
   #100;
    
    Up = 1'b0;
    Dw = 1'b1;
    LD = 1'b0;
      
   #100;
    
    Up = 1'b1;
    Dw = 1'b1;
    LD = 1'b0;
         
   #100;
    
     Up = 1'b0;
     Dw = 1'b0;
     LD = 1'b1;
     Din[0] = 1'b1;
     Din[1] = 1'b0;
     Din[2] = 1'b1;
     Din[3] = 1'b0;
      
   #100;
     
     Up = 1'b0;
     Dw = 1'b1;
     LD = 1'b1;
     Din[0] = 1'b1;
     Din[1] = 1'b0;
     Din[2] = 1'b0;
     Din[3] = 1'b1;
           
   #100;
   
   Up = 1'b1;
   Dw = 1'b0;
   LD = 1'b1;
   Din[0] = 1'b1;
   Din[1] = 1'b1;
   Din[2] = 1'b0;
   Din[3] = 1'b0;
              
   #100;
    
    Up = 1'b1;
    Dw = 1'b0;
    LD = 1'b1;
    Din[0] = 1'b0;
    Din[1] = 1'b0;
    Din[2] = 1'b1;
    Din[3] = 1'b1;
                 
   #100;
    
    Up = 1'b1;
    Dw = 1'b1;
    LD = 1'b1;
    Din[0] = 1'b1;
    Din[1] = 1'b1;
    Din[2] = 1'b1;
    Din[3] = 1'b1;
                    
   #100;
    
    Up = 1'b1;
    Dw = 1'b0;
    LD = 1'b0;
          
   #100;
   
   Up = 1'b0;
   Dw = 1'b1;
   LD = 1'b0;
            
   #100;
   
   Up = 1'b0;
   Dw = 1'b1;
   LD = 1'b0;
               
   #100;
   
   end
   
endmodule
