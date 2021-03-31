`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 10:53:07 PM
// Design Name: 
// Module Name: TopModule
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


module TopLevel(
    input btnR,//
    input btnL,//
    input btnC,//
    input clkin,//
    input [15:0] sw,//
    output [3:0] an,//
    output [6:0] seg,//
    output [15:0] led,//
    output Hsync,//
    output Vsync,//
    output [3:0] vgaRed,//
    output [3:0] vgaGreen,//
    output [3:0] vgaBlue//
    );
    
lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));    // Note that sw[0] could be used to greset

////////////////////////////////////////////
//  Define the wires
//
//////////////////////////////////////
wire resetT, tS, hS, qS, fakeS, newclk, newf, goAsrt;
wire idle, go;
wire [11:0] red, orange, yellow, green, blue, indigo, violet, white, black, colors; // The colors
wire [9:0]  Hpos, Vpos;             // H and V position of the pointer
wire [9:0] VP4cmp, HP4cmp;          // The pointer position for comparison purposes


wire f, hf, aktiv;                  // Setup wires for the VGA output
wire L, R, start;           // Setup wires for detecting input
wire showCar, runGame, gameOver;    // The output wires for the gameSM

////////////////////////////////////
// Predefine the colors
////////////////////////////////////

    assign red      = 12'hf00; 
    assign orange   = 12'hf70; 
    assign yellow   = 12'hff0;
    assign green    = 12'h0f0;
    assign blue     = 12'h00f;
    assign violet   = 12'h225;
    assign indigo   = 12'h80f; 
    assign white    = 12'hfff;
    assign black    = 12'h000;

//////////////////////////////////////
//  Initiate the VGA module
//
////////////////////////////////////////////////
VGA_480x640(
        .clk(clk),//Done
        .color(colors),//Done
        .Vsync(Vsync),//Done
        .Hsync(Hsync),//Done
        .active(aktiv),//Done
        .VGA_R(vgaRed[3:0]),//Done
        .VGA_G(vgaGreen[3:0]),//Done
        .VGA_B(vgaBlue[3:0]),//Done
        .frame(f),//Done
        .halfFrame(hf),//Done
        .Vpos(Vpos),//Done
        .Hpos(Hpos)//Done
        );
    ////////////////////////////////////////////////////////////
    //  The conversion of ptr position so it could be compared to the game field
    //
    //////////////////////////////////////////////////////////////    
    assign VP4cmp = Vpos+80;
    assign HP4cmp = Hpos+80;
////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//  Should be fine up to this point
///////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////
//  Make a module that stores the input for an entire frame
//
///////////////////////////////////////////
/*InputExtender bR(.clk(clk),
                .f(f),
                .in(btnR),
                .out(L));
InputExtender bL(.clk(clk),
                .f(f),
                .in(btnL),
                .out(R));
InputExtender S(.clk(clk),
                .f(f),
                .in(btnC),
                .out(start));*/
assign start = btnC;                
assign R = btnL;
assign L = btnR;

/////////////////////////////////////////
//  Random Number Generator
//
//  Initialize a Linear Feedback Shift Register
//  That only advances every frame when the user 
//  is asserting move right or move left signal.
///////////////////////////////////
    wire [7:0] rnd;
    wire [3:0] tempRnd;
    wire [9:0] RNG;
    wire tempRndIsF;
    LFSR random(    .clk(clk),
                    .f(f),
                    .enable(1'b1),
                    .out(rnd[7:0])
                    );
                
    assign tempRnd[3:0] = rnd[6:3];
    assign tempRndIsF = (tempRnd[3:0] == 4'hf);

    assign RNG = tempRndIsF ? {10'b0000001010} : {6'b000000,tempRnd};

///////////////////////////////////////////////////
//  All of the Road Segments
//  
//  The position notation is offset by 80 on both x and y, so
//  (0,0) on screen would be (80,80) in this notation.
//  We will compare these positions to VP4cmp and HP4cmp
////////////////////////////////////////////////////
wire [9:0] roadWidth;
    assign roadWidth = 8+16*{7'b0000000,sw[6:4]};   // This is the width to be used later for checking   

wire [9:0] roadHeight;
    assign roadHeight = 80;///Originally 80

wire RIP;
    
wire [9:0]  rnp,onp,ynp,gnp,bnp,inp,vnp,    // The new positions
            rhp,ohp,yhp,ghp,bhp,ihp,vhp,    // The current horizontal position
            rvp,ovp,yvp,gvp,bvp,ivp,vvp;    // The current vertical position
            
wire [9:0]  offset;
    assign offset = 8*RNG-56;

assign rnp = ohp + offset;
assign onp = yhp + offset;
assign ynp = ghp + offset;
assign gnp = bhp + offset; 
assign bnp = ihp + offset;
assign inp = vhp + offset;
assign vnp = rhp + offset;     

           
RoadSegSM Red(      .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(rnp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392+2*roadWidth-60),
                    .InitialVPos(0),
                    .hp(rhp[9:0]),
                    .vp(rvp[9:0])
                    );
                    
wire [9:0] redTedge,redBedge,redLedge,redRedge;
    assign redTedge = rvp;
    assign redBedge = rvp+roadHeight-1;
    assign redLedge = rhp;
    assign redRedge = rhp+roadWidth-1;
                                
RoadSegSM Orange(   .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(onp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392+roadWidth-30),
                    .InitialVPos(80),
                    .hp(ohp[9:0]),
                    .vp(ovp[9:0])
                    );
wire [9:0] oraTedge,oraBedge,oraLedge,oraRedge;
    assign oraTedge = ovp;
    assign oraBedge = ovp+roadHeight-1;
    assign oraLedge = ohp;
    assign oraRedge = ohp+roadWidth-1;
                       
RoadSegSM Yellow(   .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(ynp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392),
                    .InitialVPos(160),
                    .hp(yhp[9:0]),
                    .vp(yvp[9:0])
                    );   
                     
wire [9:0] yelTedge,yelBedge,yelLedge,yelRedge;
    assign yelTedge = yvp;
    assign yelBedge = yvp+roadHeight-1;
    assign yelLedge = yhp;
    assign yelRedge = yhp+roadWidth-1;
    
RoadSegSM Green(    .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(gnp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392+roadWidth-30),
                    .InitialVPos(240),
                    .hp(ghp[9:0]),
                    .vp(gvp[9:0])
                    );
wire [9:0] greTedge,greBedge,greLedge,greRedge;
    assign greTedge = gvp;
    assign greBedge = gvp+roadHeight-1;
    assign greLedge = ghp;
    assign greRedge = ghp+roadWidth-1;
        
RoadSegSM Blue(     .f(f),
                    .runGame(runGame),
                    .clk(clk),
                    .hf(hf),
                    .ld(bnp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392),
                    .InitialVPos(320),
                    .hp(bhp[9:0]),
                    .vp(bvp[9:0])
                    );    
wire [9:0] bluTedge,bluBedge,bluLedge,bluRedge;
    assign bluTedge = bvp;
    assign bluBedge = bvp+roadHeight-1;
    assign bluLedge = bhp;
    assign bluRedge = bhp+roadWidth-1;
                    
RoadSegSM Indigo(   .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(inp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392-roadWidth+30),
                    .InitialVPos(400),
                    .hp(ihp[9:0]),
                    .vp(ivp[9:0])
                    );    
wire [9:0] indTedge,indBedge,indLedge,indRedge;
    assign indTedge = ivp;
    assign indBedge = ivp+roadHeight-1;
    assign indLedge = ihp;
    assign indRedge = ihp+roadWidth-1;

RoadSegSM Violet(   .f(f),
                    .clk(clk),
                    .hf(hf),
                    .runGame(runGame),
                    .ld(vnp[9:0]),
                    .R(R),
                    .L(L),
                    .resetInitialPos(/*btnC*/RIP),
                    .InitialHPos(392),
                    .InitialVPos(480),
                    .hp(vhp[9:0]),
                    .vp(vvp[9:0])
                    );
wire [9:0] vioTedge,vioBedge,vioLedge,vioRedge;
    assign vioTedge = vvp;
    assign vioBedge = vvp+roadHeight-1;
    assign vioLedge = vhp;
    assign vioRedge = vhp+roadWidth-1;

///////////////////////////////////////////
//
//
//
///////////////////////////////////////////
wire carOn;
//CarSM whiteCar(.f(f), .hS(), .blink(showCar|gameOver), .carOn(carOn), .resetHS());

wire [9:0] chp, cvp;
    assign chp = 392;
    assign cvp = 472;
wire [9:0] carw, carh;
    assign carw = 16;
    assign carh = 16;
wire [9:0] carTedge,carBedge,carRedge,carLedge;
    assign carTedge = cvp;
    assign carBedge = cvp+carh-1;
    assign carLedge = chp;
    assign carRedge = chp+carw-1;

////////////////////////////////////////
//  Come up with the match logic
//  
//  We have {   car }{  T   }{  edge    }
//              red     B
//              ora     L
//              yel     R
//              gre
//              blu
//              ind
//              vio
//
//
//
//
//
//
//
////////////////////////////////////////////////
wire match;
    
wire    onRH,onRV,onR, //carOnRedHoriZontally,Vertically,CarOnRed    
        onOH,onOV,onO,
        onYH,onYV,onY,
        onGH,onGV,onG,
        onBH,onBV,onB,
        onIH,onIV,onI,
        onVH,onVV,onV;        

assign      onRH    =   ( (carLedge<=redRedge) & (carLedge>=redLedge) )| 
                        ( (carRedge<=redRedge) & (carRedge>=redLedge) )|
                        ( (redLedge<=carRedge) & (redLedge>=carLedge) )| 
                        ( (redRedge<=carRedge) & (redRedge>=carLedge) );
assign      onRV    =   ( (carTedge<=redBedge) & (carTedge>=redTedge) )|
                        ( (carBedge<=redBedge) & (carBedge>=redTedge) )|
                        ( (redTedge<=carBedge) & (redTedge>=carTedge) )|
                        ( (redBedge<=carBedge) & (redBedge>=carTedge) ); 
    assign  onR     = onRH&onRV;  
assign      onOH    =   ( (carLedge<=oraRedge) & (carLedge>=oraLedge) )| 
                        ( (carRedge<=oraRedge) & (carRedge>=oraLedge) )|
                        ( (oraLedge<=carRedge) & (oraLedge>=carLedge) )| 
                        ( (oraRedge<=carRedge) & (oraRedge>=carLedge) );
assign      onOV    =   ( (carTedge<=oraBedge) & (carTedge>=oraTedge) )|
                        ( (carBedge<=oraBedge) & (carBedge>=oraTedge) )|
                        ( (oraTedge<=carBedge) & (oraTedge>=carTedge) )|
                        ( (oraBedge<=carBedge) & (oraBedge>=carTedge) ); 
    assign  onO     = onOH&onOV;  
assign      onYH    =   ( (carLedge<=yelRedge) & (carLedge>=yelLedge) )| 
                        ( (carRedge<=yelRedge) & (carRedge>=yelLedge) )|
                        ( (yelLedge<=carRedge) & (yelLedge>=carLedge) )| 
                        ( (yelRedge<=carRedge) & (yelRedge>=carLedge) );
assign      onYV    =   ( (carTedge<=yelBedge) & (carTedge>=yelTedge) )|
                        ( (carBedge<=yelBedge) & (carBedge>=yelTedge) )|
                        ( (yelTedge<=carBedge) & (yelTedge>=carTedge) )|
                        ( (yelBedge<=carBedge) & (yelBedge>=carTedge) ); 
    assign  onY     = onYH&onYV;
assign      onGH    =   ( (carLedge<=greRedge) & (carLedge>=greLedge) )| 
                        ( (carRedge<=greRedge) & (carRedge>=greLedge) )|
                        ( (greLedge<=carRedge) & (greLedge>=carLedge) )| 
                        ( (greRedge<=carRedge) & (greRedge>=carLedge) );
assign      onGV    =   ( (carTedge<=greBedge) & (carTedge>=greTedge) )|
                        ( (carBedge<=greBedge) & (carBedge>=greTedge) )|
                        ( (greTedge<=carBedge) & (greTedge>=carTedge) )|
                        ( (greBedge<=carBedge) & (greBedge>=carTedge) ); 
    assign  onG     = onGH&onGV;  
assign      onBH    =   ( (carLedge<=bluRedge) & (carLedge>=bluLedge) )| 
                        ( (carRedge<=bluRedge) & (carRedge>=bluLedge) )|
                        ( (bluLedge<=carRedge) & (bluLedge>=carLedge) )| 
                        ( (bluRedge<=carRedge) & (bluRedge>=carLedge) );
assign      onBV    =   ( (carTedge<=bluBedge) & (carTedge>=bluTedge) )|
                        ( (carBedge<=bluBedge) & (carBedge>=bluTedge) )|
                        ( (bluTedge<=carBedge) & (bluTedge>=carTedge) )|
                        ( (bluBedge<=carBedge) & (bluBedge>=carTedge) ); 
    assign  onB     = onBH&onBV;
assign      onIH    =   ( (carLedge<=indRedge) & (carLedge>=indLedge) )| 
                        ( (carRedge<=indRedge) & (carRedge>=indLedge) )|
                        ( (indLedge<=carRedge) & (indLedge>=carLedge) )| 
                        ( (indRedge<=carRedge) & (indRedge>=carLedge) );
assign      onIV    =   ( (carTedge<=indBedge) & (carTedge>=indTedge) )|
                        ( (carBedge<=indBedge) & (carBedge>=indTedge) )|
                        ( (indTedge<=carBedge) & (indTedge>=carTedge) )|
                        ( (indBedge<=carBedge) & (indBedge>=carTedge) ); 
assign  onI     = onIH&onIV;  
assign      onVH    =   ( (carLedge<=vioRedge) & (carLedge>=vioLedge) )| 
                        ( (carRedge<=vioRedge) & (carRedge>=vioLedge) )|
                        ( (vioLedge<=carRedge) & (vioLedge>=carLedge) )| 
                        ( (vioRedge<=carRedge) & (vioRedge>=carLedge) );
assign      onVV    =   ( (carTedge<=vioBedge) & (carTedge>=vioTedge) )|
                        ( (carBedge<=vioBedge) & (carBedge>=vioTedge) )|
                        ( (vioTedge<=carBedge) & (vioTedge>=carTedge) )|
                        ( (vioBedge<=carBedge) & (vioBedge>=carTedge) ); 
    assign  onV     = onVH&onVV;     

assign      match   = (onR|onO|onY|onG|onB|onI|onV);

//////////////////////////////////////////////////////////////
//  DO SOME SHIT WITH COLORS RIGHT HERE
//  VP4cmp & HP4cmp will be compared with redLedge etc to evaluate expressions for when the colors are aktiv
//////////////////////////////////////////////////////////////
wire ptrOnCar,ptrOnRed,ptrOnOra,ptrOnYel,ptrOnGre,ptrOnBlu,ptrOnInd,ptrOnVio;
assign ptrOnCar = (VP4cmp>=carTedge)&(VP4cmp<=carBedge)&(HP4cmp>=carLedge)&(HP4cmp<=carRedge);
assign ptrOnRed = (VP4cmp>=redTedge)&(VP4cmp<=redBedge)&(HP4cmp>=redLedge)&(HP4cmp<=redRedge);
assign ptrOnOra = (VP4cmp>=oraTedge)&(VP4cmp<=oraBedge)&(HP4cmp>=oraLedge)&(HP4cmp<=oraRedge);
assign ptrOnYel = (VP4cmp>=yelTedge)&(VP4cmp<=yelBedge)&(HP4cmp>=yelLedge)&(HP4cmp<=yelRedge);
assign ptrOnGre = (VP4cmp>=greTedge)&(VP4cmp<=greBedge)&(HP4cmp>=greLedge)&(HP4cmp<=greRedge);
assign ptrOnBlu = (VP4cmp>=bluTedge)&(VP4cmp<=bluBedge)&(HP4cmp>=bluLedge)&(HP4cmp<=bluRedge);
assign ptrOnInd = (VP4cmp>=indTedge)&(VP4cmp<=indBedge)&(HP4cmp>=indLedge)&(HP4cmp<=indRedge);
assign ptrOnVio = (VP4cmp>=vioTedge)&(VP4cmp<=vioBedge)&(HP4cmp>=vioLedge)&(HP4cmp<=vioRedge);

assign colors   = (ptrOnCar & carOn) ? white : (
                  ptrOnRed ? red : ( 
                  ptrOnOra ? orange : ( 
                  ptrOnYel ? yellow : ( 
                  ptrOnGre ? green : ( 
                  ptrOnBlu ? blue : (
                  ptrOnInd ? indigo : ( 
                  ptrOnVio ? violet : black
                  )))))));

/////////////////////////////////////////////
// Make the timer
//
////////////////////////////////////////////
wire [16:0] Timerino,timeruno;
counter16 tmrn( .clk(f),
                .init(16'h0000),
                .reset(resetT),
                .Up(1'b1),
                .Q(Timerino)
                );

//// assign twoSec
EdgeDetector thirth (   .clk(f), .in(Timerino[7]), .out(tS));
//// assign halSec
EdgeDetector firth (    .clk(f), .in(Timerino[5]), .out(hS));
//// assign quaSec
EdgeDetector seconth (  .clk(f), .in(Timerino[4]), .out(qS));

/////////////////////
//  led shifter 1
///////////////////////
//wire [15:0] ledWhenGR;
//FDRE #(.INIT(16'h8000) ) ledgr(.C(qS), .R({16{go}}), .CE(1'b1), .D({ledWhenGR[0],ledWhenGR[15:1]}), .Q(ledWhenGR)); 

//wire [3:0] ledCtDwn, ledWhenCD;
//FDRE #(.INIT(4'h8) ) ledcd(.C(hS), .R({4{start}}), .CE(1'b1), .D({1'b1,ledCtDwn[3:1]}), .Q(ledCtDwn));
//    assign ledWhenCD = {ledCtDwn[3],3'b0,ledCtDwn[2],3'b0,ledCtDwn[1],3'b0,ledCtDwn[0],3'b0}; 


//wire [15:0] ledWhenNeither;
//    assign ledWhenNeither = 0;
    
//assign led =    runGame ? ledWhenGR:(
//                showCar ? ledWhenCD:ledWhenNeither);    

///////////////////////////////////////////////////////////////////    
GameSM game(
                .f(f),
                .onRoad(match),
                .start(start),
                .twoSec(tS),
                //////////////////////////////
                .resetT(resetT),
                .go(go),
                .goAsrt(goAsrt),
                .idle(idle),
                .showCar(showCar),
                .runGame(runGame),
                .gameOver(gameOver),
                .resetInitialPos(RIP)
                );
                
    assign carOn = (~gameOver&~showCar)|(gameOver|showCar)&~Timerino[5];

wire [15:0] scoreCt;
//assign scoreCt = 16'hcafe;

    
wire [3:0] RingOut;
RingCounter Ring (.advance(digsel),.clk(clk),.ring(RingOut[3:0]));
wire [3:0] selectOut;
Selector select (.sel(RingOut[3:0]),.N(scoreCt),.H(selectOut[3:0])); // There may be no issue with this since
hex7seg segs (.n(selectOut[3:0]),.seg(seg[6:0]));

assign an[0] = (~RingOut[0])|(gameOver&Timerino[5]); 
assign an[1] = (~RingOut[1])|(gameOver&Timerino[5]); 
assign an[2] = (~RingOut[2])|(gameOver&Timerino[5]); 
assign an[3] = (~RingOut[3])|(gameOver&Timerino[5]); 

//lab7_clks not_so_slow1 (.clkin(clkin), .greset(sw[0]), .clk(newclk), .digsel());   
VGA_480x640 dakjn(    .clk(clk), .frame(newf));

counter16 tmrun(.clk(newf),
                .init(16'h0000),
                .reset(resetT),
                .Up(1'b1),
                .Q(timeruno)
                );

counter16 abcd( .clk(newf),
                .Up(runGame&fakeS),
                .LD(goAsrt),
                .Q(scoreCt),
                .D(16'd0)    
                );

EdgeDetector fifth (    .clk(newf), .in(timeruno[4]), .out(fakeS));//This timeruno[n] has severe consequences for the running speed of the entire game, even though it is on a separate branch from the rest of the working game

wire [3:0] runLED;


endmodule