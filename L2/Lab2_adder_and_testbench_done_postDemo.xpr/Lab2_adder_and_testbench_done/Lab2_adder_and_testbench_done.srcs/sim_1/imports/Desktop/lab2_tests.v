// CSE 100 Winter 2020
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify it to conform to your project.
`timescale 1ns/1ps

module lab2_tests();
   
   reg sw0, sw1, sw2, sw3, sw4, sw5, sw6;
   wire CA,CB,CC,CD,CE,CF,CG,DP,AN0,AN1,AN2,AN3;
   wire [0:6] sw;
        assign sw[0] = sw0;
        assign sw[1] = sw1;
        assign sw[2] = sw2;
        assign sw[3] = sw3;
        assign sw[4] = sw4;
        assign sw[5] = sw5;
        assign sw[6] = sw6;
    wire [0:3] an;
        assign AN0 = an[0];
        assign AN1 = an[1];
        assign AN2 = an[2];
        assign AN3 = an[3];               
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.

   threeBitAdder UTT (
        .sw(sw),.seg({CA,CB,CC,CD,CE,CF,CG}),.dp(DP),.an(an)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
    initial
    begin	

        sw0=1'b0;
        sw1=1'b0;
        sw2=1'b0;
        sw3=1'b0;
        sw4=1'b0;
        sw5=1'b0;
        sw6=1'b0;
        // sum is 0 
	    //-------------  Current Time:  0ns
	    #100;  //This advances time by 100 units (ns in this case)
	    sw0 = 1'b1;
        // sum is 1
        // -------------  Current Time:  100ns
        #100;
        sw1 = 1'b1;
        // sum is 2
        // -------------  Current Time:  200ns
        #100;
        sw4 = 1'b1;
        // sum is 3
        // -------------  Current Time:  300ns
        #100;
        sw0 = 1'b0;
		  sw5 = 1'b1;
        // sum is 4
        // -------------  Current Time:  400ns
        #100;
        sw0 = 1'b1;
        // sum is 5
        // -------------  Current Time:  500ns
        #100;
        sw1 = 1'b0;
        sw2 = 1'b1;
        // sum is 6
        // -------------  Current Time:  600ns
        #200;
        sw1 = 1'b1;
        // sum is 7
        // -------------  Current Time:  700ns
        #100;
        sw4 = 1'b0;
        sw5 = 1'b0;
        sw6 = 1'b1;
        // sum is 8
        // -------------  Current Time:  800ns
        #100;
        sw4 = 1'b1;
        // sum is 9
        // -------------  Current Time:  900ns
        #100;
        sw1 = 1'b0;
        sw2 = 1'b0;
        sw3 = 1'b1;
        // sum is 10
        // -------------  Current Time:  1000ns

	    #100;  //This advances time by 100 units (ns in this case)
	    sw1 = 1'b1;
        // sum is 11
        //-------------  Current Time:  1100ns
        #100;  //This advances time by 100 units (ns in this case)
	    sw1 = 1'b0;
	       sw2 = 1'b1;
        // sum is 12
        //-------------  Current Time:  1200ns
        #100;  //This advances time by 100 units (ns in this case)
	    sw1 = 1'b1;
        // sum is 13
        //-------------  Current Time:  1300ns	
        #100;  //This advances time by 100 units (ns in this case)
	    sw4 = 1'b0;
	       sw5 = 1'b1;
        // sum is 14
        //-------------  Current Time:  1400ns	

        #100;  //This advances time by 100 units (ns in this case)
	    sw4 = 1'b1;
        // sum is 15
        //-------------  Current Time:  1500ns	
    //
	// complete this testbentch  so that all 
	// 16 hex values are generated
    end
endmodule	
