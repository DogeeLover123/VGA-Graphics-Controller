`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 05:59:28 PM
// Design Name: 
// Module Name: Top
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


//module Top(
//    input clk_100MHz,       // from Basys 3
//    input reset,            // btnC on Basys 3
//    output hsync,           // VGA port on Basys 3
//    output vsync,           // VGA port on Basys 3
//    output [11:0] rgb       // to DAC, 3 bits to VGA port on Basys 3
//    );
    
//    wire w_in_display_area, w_p_clock;
//    wire [9:0] w_x, w_y;
//    reg [11:0] rgb_reg;
//    wire[11:0] rgb_next;
    
//    VGA_Graphics_Controller vc(.clk_100MHz(clk_100MHz), .reset(reset), .in_display_area(in_display_area), .hsync(hsync), 
//                      .vsync(vsync), .pixel_clock(w_p_clock), .x(w_x), .y(w_y));
//    Pixel_Generator pg(.clk_100MHz(clk_100MHz), .reset(reset), .vsync(vsync), .in_display_area(in_display_area), 
//                        .x(w_x), .y(w_y), .rgb(rgb_next));
    
//    //update rgb values for every pixel
//    always @(posedge w_p_clock)
//            rgb_reg <= rgb_next;
            
//    assign rgb = rgb_reg;
    
//endmodule

`timescale 1ns / 1ps

module top(
    input clk_100MHz,       // from Basys 3
    input reset,            // btnC on Basys 3
    output hsync,           // VGA port on Basys 3
    output vsync,           // VGA port on Basys 3
    output [11:0] rgb       // to DAC, 3 bits to VGA port on Basys 3
    );
    
    wire w_in_display_area, w_pixel_clock;
    wire [9:0] w_x, w_y;
    reg [11:0] rgb_reg;
    wire[11:0] rgb_next;
    
    VGA_Graphics_Controller vc(.clk_100MHz(clk_100MHz), .reset(reset), .in_display_area(w_in_display_area), .hsync(hsync), 
                      .vsync(vsync), .pixel_clock(w_pixel_clock), .x(w_x), .y(w_y));
    Pixel_Generator pg(.clk_100MHz(clk_100MHz), .reset(reset), .in_display_area(w_in_display_area), 
                        .x(w_x), .y(w_y), .rgb(rgb_next));
    
    always @(posedge clk_100MHz)
        if(w_pixel_clock)
            rgb_reg <= rgb_next;
            
    assign rgb = rgb_reg;
 
endmodule