`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2024 04:20:35 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
input wire clk,
input wire reset,
output wire twoHz_clock,
output wire oneHz_clock,
output wire segment_clk,
output wire blinking_clk
    );
    
    localparam toOneHz = 100000000;
    localparam toTwoHz = 50000000;
    localparam two_divider = 2500000;
    localparam one_divider = 5000000;
    
    //
    
    //For segment clock frequency of 500hz
    localparam toSegmentHz = 10000; //1000
    
    //For blinking clock freqeuncy of 5hz
    localparam toBlinkingHz = 20000000;
    
    reg [31:0] twoHz_clock_counter;
    reg [31:0] oneHz_clock_counter;
    reg [31:0] segment_clock_counter;
    reg [31:0] blinking_clock_counter;

    reg two;
    reg one;
    reg seg;
    reg blnk;


    always @(posedge clk or posedge reset) begin
        // 1 Hz
        if (reset == 1) begin
            oneHz_clock_counter <= 32'b0;
            one <= 0;
        end
        else if (oneHz_clock_counter == toOneHz - 1) begin
            one <= ~oneHz_clock;
            oneHz_clock_counter <= 32'b0;
        end
        else begin
            oneHz_clock_counter <= oneHz_clock_counter + 32'b1;
            one <= oneHz_clock;
        end

        // 2 Hz
        if (reset == 1) begin
            two <= 0;
            twoHz_clock_counter <= 32'b0;
        end
        else if (twoHz_clock_counter == toTwoHz - 1) begin
            two <= ~twoHz_clock;
            twoHz_clock_counter <= 32'b0;
        end
        else begin
            twoHz_clock_counter <= twoHz_clock_counter + 32'b1;
            two <= twoHz_clock;
        end

        if (reset == 1) begin 
            segment_clock_counter <= 32'b0;
            seg <= 1;
        end
        else if (segment_clock_counter == toSegmentHz - 1) begin
            segment_clock_counter <= 32'b0;
            seg <= ~segment_clk;
        end
        else begin
            segment_clock_counter <= segment_clock_counter + 32'b1;
            seg <= segment_clk;
        end


        // Blinking 
        if (reset == 1) begin 
            blinking_clock_counter <= 32'b0;
            blnk <= 1;
        end
        else if (blinking_clock_counter == toBlinkingHz - 1) begin
            blinking_clock_counter <= 32'b0;
            blnk <= ~blinking_clk;
        end
        else begin
            blinking_clock_counter <= blinking_clock_counter + 32'b1;
            blnk <= blinking_clk;
        end

    end 



    assign twoHz_clock = two;
    assign oneHz_clock = one;
    assign segment_clk = seg;
    assign blinking_clk = blnk;


endmodule  