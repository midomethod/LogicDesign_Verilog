// CMPE 100 Winter 2018
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify it to conform to your project.
`timescale 1ns/1ps

    module lab2_tests();
   reg [7:0] sw;
   reg btnR, btnC, btnL, clkin;
   wire [6:0] seg;
   wire [3:0] an;
   wire dp;
   wire JA;
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.

   TopLevel UUT (
        .sw(sw), .btnL(btnL),.btnC(btnC), .btnR(btnR), .clkin(clkin),
        .seg(seg),.dp(dp), .an(an),.JA(JA)
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
	 
#100;
//"00~03"
    assign sw = 8'b00000000;
    assign btnR = 1'b0;
    assign btnL = 1'b0;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b0;
    assign btnC = 1'b1;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b1;
#100;
//"04~07"
    assign sw = 8'b00000100;
    assign btnL = 1'b0;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b0;
    assign btnC = 1'b1;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b1;
#100;
//"08~0B"
    assign sw = 8'b00001000;
    assign btnL = 1'b0;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b0;
    assign btnC = 1'b1;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b1;
#100;
//"0C~0F"
    assign sw = 8'b00001100;
    assign btnL = 1'b0;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b0;
    assign btnC = 1'b1;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b0;
    #100;
    assign btnL = 1'b1;
    assign btnC = 1'b1;

#100;
//"1F"
    assign sw = 8'b00011100;
#100;
//"2F"
    assign sw = 8'b00101100;
#100;
//"3F"
    assign sw = 8'b00111100;
#100;
//"4F"
    assign sw = 8'b01001100;
#100;
//"5F"
    assign sw = 8'b01011100;
    #100;
//"6F"
    assign sw = 8'b01101100;
    #100;
//"7F"
    assign sw = 8'b01111100;
    #100;
//"8F"
    assign sw = 8'b10001100;
    #100;
//"9F"
    assign sw = 8'b10011100;
    #100;
//"AF"
    assign sw = 8'b10101100;
    #100;
//"BF"
    assign sw = 8'b10111100;
    #100;
//"CF"
    assign sw = 8'b11001100;
    #100;
//"DF"
    assign sw = 8'b11011100;
    #100;
//"EF"
    assign sw = 8'b11101100;
    #100;
//"FF"
    assign sw = 8'b11111100;
    #100;

end
	
endmodule	
