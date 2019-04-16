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
module  color_mapper ( //input              is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
							  input				   is_tank,
//							  input			[2:0] tank_dir,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] tankX, tankY,
							  input					Clk,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
	 parameter [9:0] Width = 10'd32;
	 parameter [9:0] Height = 10'd32;
	 
    logic [7:0] Red, Green, Blue;
	 logic [18:0] tank_addr;
	 logic [23:0] RGB_tanku, RGB_tankr, RGB_tankl, RGB_tankd;
	     
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 frameRAM_Tank_1 tank_u(.read_address(tank_addr), .Clk(Clk),
								  .data_Out(RGB_tanku)
								  );
//	 frameRAM_Tank_2 tank_r(.read_address(tank_addr), .Clk(Clk),
//									.data_Out(RGB_tankr)
//									);
//	 frameRAM_Tank_3 tank_l(.read_address(tank_addr), .Clk(Clk),
//									.data_Out(RGB_tankl)
//									);
//	 frameRAM_Tank_4 tank_d(.read_address(tank_addr), .Clk(Clk),
//									.data_Out(RGB_tankd)
//									);								
    
    always_comb
    begin
			// Background is white
			Red = 8'hff; 
			Green = 8'hff;
			Blue = 8'hff;
			tank_addr = 18'b0;
		
		if (is_tank == 1'b1) begin
//			case(tank_dir) 
			tank_addr = (DrawX - tankX) + ((DrawY - tankY) * Width);
//			3'b001:
				if (RGB_tanku != 24'hFF0000) begin
					Red = RGB_tanku & 24'hFF0000 >> 5'b10000;
					Green = RGB_tanku & 24'h00FF00 >> 4'b1000;
					Blue = RGB_tanku & 24'h0000FF;
				end
      
//			3'b010:
//				if (RGB_tankr != 24'hFF0000) begin
//					Red = RGB_tankr & 24'hFF0000 >> 5'b10000;
//					Green = RGB_tankr & 24'h00FF00 >> 4'b1000;
//					Blue = RGB_tankr & 24'h0000FF;
//				end
//      
//			3'b011:
//				if (RGB_tankl != 24'hFF0000) begin
//					Red = RGB_tankl & 24'hFF0000 >> 5'b10000;
//					Green = RGB_tankl & 24'h00FF00 >> 4'b1000;
//					Blue = RGB_tankl & 24'h0000FF;
//				end
//		
//			3'b100:
//				if (RGB_tankd != 24'hFF0000) begin
//					Red = RGB_tankd & 24'hFF0000 >> 5'b10000;
//					Green = RGB_tankd & 24'h00FF00 >> 4'b1000;
//					Blue = RGB_tankd & 24'h0000FF;
//				end
//			default: ;
//			endcase
		end
	end 
    
endmodule
