`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2024 11:14:28 AM
// Design Name: 
// Module Name: stopwatch_tb
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


module stopwatch_tb;

    reg pause;
    reg reset;
    reg [1:0] adjust;
    reg select;
    reg clk;
    reg clk_adj;

    wire [3:0] min0;
    wire [3:0] min1;
    wire [3:0] sec0;
    wire [3:0] sec1;

    wire clock;
    
    integer itr = 0;

count count_uut(
    .reset(reset),
    .pause(pause),
    .adjust(adjust),
    .select(select),
    .clk(clk),
    .min0(min0),
    .min1(min1),
    .sec0(sec0),
    .sec1(sec1)
);

initial begin
    reset = 1;
    #100;
    clk = 0;
    pause = 0;
    adjust = 0;
    select = 0;
    clk_adj = 0;
    reset = 0;
    
    #100;
    
end

always begin
    #10 clk = ~clk;
    /*
    while(itr != 100) begin
        $display("Num iterations: %d", itr);
        itr = itr + 1;
    end
    */
end
endmodule
