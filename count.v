`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2024 10:35:44 AM
// Design Name: 
// Module Name: count
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

`timescale 1ns / 1ps

module count(
    input wire reset,
    input wire pause,
    input wire adjust,
    input wire select,
    input wire clk,
    input wire clk_adj,
    
    output wire [3:0] min0,
    output wire [3:0] min1,
    output wire [3:0] sec0,
    output wire [3:0] sec1

    );
    
    reg [3:0] min1cnt = 4'b0000; //Initialize them all to 0
    reg [3:0] min0cnt = 4'b0000;
    reg [3:0] sec0cnt = 4'b0000;
    reg [3:0] sec1cnt = 4'b0000;
    
    reg clock;
    
    reg paused = 0;

    // Check for adjust signal
    always begin
        if (adjust == 0) begin
            clock = clk;
        end
        else begin
            clock = clk_adj;
        end
    end
    
    always @(posedge clk or posedge pause) begin
        if (pause) begin
            paused <= ~paused;
        end
        else begin
            paused <= paused;
        end  
    end
    

    
    // Set up reset
    always @(posedge clock) 
        begin    
        
        
        if (reset) begin
            min1cnt <= 4'b0000; //Reset all time values to 0
            min0cnt <= 4'b0000;
            sec0cnt <= 4'b0000;
            sec1cnt <= 4'b0000;
        end 
        
        
        //Regular clock 
        if (adjust == 0 && ~paused) begin
            if (sec0cnt == 9 && sec1cnt == 5) begin // If need to overflow into minutes
                sec0cnt <= 0;
                sec1cnt <= 0; //reset seconds to 0
                
                //If minutes also overflow
                if (min0cnt == 5 && min1cnt == 9) begin
                    min0cnt <= 4'b0;
                    min1cnt <= 4'b0;
                    end
                //if need to update 10s minute
                else if (min0cnt == 9) begin
                    min0cnt <= 4'b0;
                    min1cnt <= min1cnt + 1;
                    end
                else begin
                // Otherwise, increment minutes normally
                    min0cnt <= min0cnt + 1;
                    end
                    
            end
            else if (sec0cnt == 9) begin
                sec0cnt <= 4'b0;
                sec1cnt <= sec1cnt + 1;
                end
            else begin
                sec0cnt <= sec0cnt + 1;
                end
        end

        //Increase

        //Seconds
        else if (adjust == 1 && ~paused && select) begin
            if (sec0cnt == 9 && sec1cnt == 5) begin
                sec0cnt <= 4'b0;
                sec1cnt <= 4'b0;
            end
            else if (sec0cnt == 9 ) begin
                sec0cnt <= 4'b0;
                sec1cnt <= sec1cnt + 1;
            end
            else begin
                sec0cnt <= sec0cnt + 1;
            end
        end

        //minutes
        else if (adjust == 1 && ~paused && ~select) begin
            if (min0cnt == 9 && min1cnt == 9) begin
                min0cnt <= 4'b0;
                min1cnt <= 4'b0;
            end
            else if (min0cnt == 9) begin
                min0cnt <= 4'b0;
                min1cnt <= min1cnt + 1;
            end
            else begin
                min0cnt <= min0cnt + 1;
            end
        end    
    end
       
    assign min1 = min1cnt;
    assign min0 = min0cnt;
    assign sec1 = sec1cnt;
    assign sec0 = sec0cnt;

endmodule
