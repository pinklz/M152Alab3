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
    input reset,
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
    
    reg clock;

    wire onehz;
    wire twohz;
    wire seghz;
    wire blinkinghz;
    wire rst;
    wire paus;

    debouncer reset_button(
        .button_in(reset),
        .clk(clk),
        .button_out(rst)
    );

    debouncer pause_button(
        .button_in(pause),
        .clk(clk),
        .button_out(paus)
    );

    clock_divider div(
        .rst(rst),
        .twoHz_clock(twohz),
        .clk(clk),
        .oneHz_clock(onehz),
        .segment_clk(seghz),
        .blinking_clk(blinkinghz)
    );

    reg [1:0] which_digit = 2'b00;
    
    count count_uut(
        .reset(reset),
        .pause(pause),
        .adjust(adj),
        .select(select),
        .clk(clk),
        .min0(min0cnt),
        .min1(min1cnt),
        .sec0(sec0cnt),
        .sec1(sec1cnt)
    );
    
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

    wire[7:0] no_val;
    seven no_value(
        .dig(4'b1111),
        seven_seg_display(no_val)
    )

    reg min = 0;
    reg sec = 0;

    always @(posedge seghz) begin
        //blinking
        if (adj == 2 || adj == 1) begin
            if (select  == 0) begin //minutes 
                if (which_digit == 0) begin
                    which_digit <= 1;
                    an <= 4'b0111;
                    if (blinkinghz == 1) begin
                        seven_seg_display <= sevenmin1;
                    end
                    else begin
                        seven_seg <= no_value;
                    end
                end
                else if (which_digit == 1) begin
                    which_digit <= 2;
                    an <= 4'b1011;
                    if (blinkinghz == 1) begin
                        seven_seg_display <= sevenmin0;
                    end
                    else begin
                        seven_seg <= no_value;
                    end
                end
                else if (which_digit == 2) begin
                    which_digit <= 3;
                    an <= 4'b1101;
                    seven_seg_display <= sevensec1;
                end
                else if (which_digit == 3) begin
                    which_digit <= 0;
                    an <= 4'b1110;
                    seven_seg_display <= sevensec0;
                end
            end

        else begin
            if (which_digit == 0) begin
                which_digit = 1;
                an <= 4'b0111;
                seven_seg_display <= sevenmin1;
            end
            else if (which_digit == 1) begin
                which_digit = 2;
                an <= 4'b1011;
                seven_seg_display <= sevenmin0;
            end
            else if (which_digit == 2) begin
                which_digit = 3;
                an <= 4'b1101;
                if (blinkinghz == 1) begin
                    seven_seg_display <= sevensec1;
                end
                else begin
                    seven_seg_display <= no_value;
                end
            end
            else if (which_digit == 3) begin
                which_digit = 0;
                an <= 4'b1110;
                if (blinkinghz == 1) begin
                    seven_seg_display <= sevensec0;
                end
                else begin
                    seven_seg_display <= no_value;
                end
            end

        end

        else begin
        if (which_digit == 0) begin
            // switch digit
            which_digit <= 1;
            // Choose which 'anode' to light up
            an <= 4'b0111;

            // + light up with the correct digit
            seven_seg_display <= sevenmin1;

            end

        if (which_digit == 1) begin
            // switch digit
            which_digit <= 2;
            // Choose which 'anode' to light up
            an <= 4'b1011;

            // + light up with the correct digit
            seven_seg_display <= sevenmin0;
            end

        if (which_digit == 2) begin
            // switch digit
            which_digit <= 3;
            // Choose which 'anode' to light up
            an <= 4'b1101;

            // + light up with the correct digit
            seven_seg_display <= sevensec1;
            end

        if (which_digit == 3) begin
            // switch digit
            which_digit <= 0;
            // Choose which 'anode' to light up
            an <= 4'b1110;

            // + light up with the correct digit
            seven_seg_display <= sevensec0;
            end
        end
        end
    end