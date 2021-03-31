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


module VGA_sim();
    reg [11:0] color;
    reg clkin;
    wire VS,HS,aktiv,f,hf;
    wire [3:0] VGA_R,VGA_G,VGA_B;
    wire [9:0] VP,HP;
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.

   VGA_480x640 UUT (
                .clk(clkin),
                .color(color),//Done
                .Vsync(VS),//Done
                .Hsync(HS),//Done
                .active(aktiv),//Done
                .VGA_R(VGA_R),//Done
                .VGA_G(VGA_G),//Done
                .VGA_B(VGA_B),//Done
                .frame(f),//Done
                .halfFrame(hf),//Done
                .Vpos(VP),//Done
                .Hpos(HP)//Done
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
   
   assign color = 12'hfff;
	 // add your stimuli here
	 // to set signal foo to value 0 use
	 // foo = 1'b0;
	 // to set signal foo to value 1 use
	 // foo = 1'b1;
	 //always advance time my multiples of 100ns
	 // to advance time by 100ns use the following line
end
    
endmodule
