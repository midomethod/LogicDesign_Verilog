`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 10:33:00 PM
// Design Name: 
// Module Name: Lab4test
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


module Lab4test();
    reg [15:0] sw;
    reg btnR, btnU, btnL, btnD, btnC, clkin;
    wire [3:0] an;
    wire [6:0] seg;
    wire [15:0] led;
    wire dp;
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.

   TopLevel UUT (
    .clkin(clkin),
    .btnR(btnR),
    .btnU(btnU),
    .btnD(btnD),
    .btnC(btnC),
    .btnL(btnL),
    .sw(sw),
    .seg(seg),
    .dp(dp),
    .an(an),
    .led(led)
    );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)"      
	
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
	 // add your stimuli here
	 // to set signal foo to value 0 use
	 // foo = 1'b0;
	 // to set signal foo to value 1 use
	 // foo = 1'b1;
	 //always advance time my multiples of 100ns
	 // to advance time by 100ns use the following line
#1000;    
    assign sw = 16'b000000000000;
    assign btnR = 1'b0;
    assign btnU = 1'b0;
    assign btnL = 1'b0;
    assign btnD = 1'b0;
    assign btnC = 1'b0;
    
#100;
    assign btnU = 1'b1;
#100;
    assign btnU = 1'b0;
    
#100;
    assign btnD = 1'b1;
#100;
    assign btnD = 1'b0;
    
#100;
    assign sw = 16'b1010101111001101;
    assign btnL = 1'b1;
#100;
    assign btnL = 1'b0;

#100;
    assign btnC = 1'b1;
        
#1000;
    assign btnC = 1'b0;
    
#100;
        assign sw = 16'b1001100111110000;
        assign btnL = 1'b1;
#100;
        assign btnL = 1'b0;
    
#100;
        assign btnC = 1'b1;
            
#3000;
        assign btnC = 1'b0;

end
    
endmodule
