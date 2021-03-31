`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2019 11:30:25 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input clk,
    input f,
    input enable,
    output [7:0] out
    );
    
wire [7:0] rnd;
wire in;
    assign in = rnd[0]^rnd[5]^rnd[6]^rnd[7];
    
        FDRE #(.INIT(1'b1) ) reg0 (.C(clk), .R(1'b0), .CE(f&enable), .D(in), .Q(rnd[0]));  
            assign out[0] = rnd[0];
            
        FDRE #(.INIT(1'b0) ) reg1 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[0]), .Q(rnd[1]));     
            assign out[1] = rnd[1];
            
        FDRE #(.INIT(1'b0) ) reg2 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[1]), .Q(rnd[2]));  
            assign out[2] = rnd[2]; 
            
        FDRE #(.INIT(1'b0) ) reg3 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[2]), .Q(rnd[3])); 
            assign out[3] = rnd[3];
            
        FDRE #(.INIT(1'b0) ) reg4 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[3]), .Q(rnd[4]));
            assign out[4] = rnd[4];
            
        FDRE #(.INIT(1'b0) ) reg5 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[4]), .Q(rnd[5]));  
            assign out[5] = rnd[5];
            
        FDRE #(.INIT(1'b0) ) reg6 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[5]), .Q(rnd[6])); 
            assign out[6] = rnd[6];
            
        FDRE #(.INIT(1'b0) ) reg7 (.C(clk), .R(1'b0), .CE(f&enable), .D(out[6]), .Q(rnd[7])); 
            assign out[7] = rnd[7];

endmodule
