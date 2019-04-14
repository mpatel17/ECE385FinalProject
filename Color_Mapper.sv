//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
							  input					is_tank,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] tankX, tankY,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
	 parameter [9:0] Width = 10'd50;
	 parameter [9:0] Height = 10'd50;
	 
    logic [7:0] Red, Green, Blue;
	 logic [18:0] tank_addr;
	 logic [23:0] RGB_curr;
	     
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 frameRAM_Tank_1 tank(.read_address(tank_addr), .Clk(Clk),
								 .data_Out(RGB_curr)
								 );
    
    // Assign color based on is_ball signal
    always_comb
    begin
        if (is_tank == 1'b1) 
        begin
				tank_addr = (DrawX - tankX) + ((DrawY - tankY) * Width);
				Red = RGB_curr & 24'hFF0000 >> 5'b10000;
				Green = RGB_curr & 24'h00FF00 >> 4'b1000;
				Blue = RGB_curr & 24'h0000FF;
        end
        else 
        begin
				tank_addr = 18'b0;
            // Background with nice color gradient
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
    end 
    
endmodule
