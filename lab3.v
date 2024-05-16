`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2024 10:32:04 AM
// Design Name: 
// Module Name: lab3
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


module lab3(
    input clk,
    input resett,
    input pause,
    input select,
    input wire [1:0] adj,
    output reg [6:0] seven_seg_display,
    output reg [3:0] an
    
    );
    
    wire [3:0] sec0cnt;
    wire [3:0] sec1cnt;
    wire [3:0] min0cnt;
    wire [3:0] min1cnt;
    
    wire [6:0] sevenmin1;
    wire [6:0] sevenmin0;
    wire [6:0] sevensec0;
    wire [6:0] sevensec1;
    
    seven min1(
        .dig(min1cnt),
        .seven_seg_display(sevenmin1)
       );
       
    seven min0(
           .dig(min0cnt),
           .seven_seg_display(sevenmin0)
          );
          
    seven sec1(
              .dig(sec1cnt),
              .seven_seg_display(sevensec1)
             );
             
    seven sec0(
                 .dig(sec0cnt),
                 .seven_seg_display(sevensec0)
                );
                
    always @(posedge clk)  begin
        seven_seg_display <= sevensec0;
        an <= 4'b1110;
    
    end
endmodule
