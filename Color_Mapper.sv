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
module  color_mapper ( input				   is_tank1, is_tank2, is_bullet, is_shooting1, //is_shooting2,
							  input			[1:0] hit1,
							  input			[2:0] tank_dir1, tank_dir2,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] tankX1, tankX2, tankY1, tankY2, bulletX1, bulletY1,
							  input					Clk,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );

	 parameter [9:0] TankWidth = 10'd32;
	 parameter [9:0] TankHeight = 10'd32;

    logic [7:0] Red, Green, Blue;
	 logic [18:0] tank_addr, bullet_addr;
	 logic [23:0] RGB_tanku, RGB_tankr, RGB_tankl, RGB_tankd, RGB_bullet;
	 logic mode;

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 assign mode = 1'b0;

	 frameRAM_Tank_1 tank_u(.read_address(tank_addr), .Clk(Clk),
								  .data_Out(RGB_tanku)
								  );
	 frameRAM_Tank_2 tank_r(.read_address(tank_addr), .Clk(Clk),
									.data_Out(RGB_tankr)
									);
	 frameRAM_Tank_3 tank_l(.read_address(tank_addr), .Clk(Clk),
									.data_Out(RGB_tankl)
									);
	 frameRAM_Tank_4 tank_d(.read_address(tank_addr), .Clk(Clk),
									.data_Out(RGB_tankd)
									);
	 frameRAM_Bullet bullet(.read_address(bullet_addr), .Clk(Clk),
 									.data_Out(RGB_bullet)
									);

    always_comb
    begin
	 
			Red = 24'hFFFFFF;
			Green = 24'hFFFFFF;
			Blue = 24'hFFFFFF;
			tank_addr = 18'd0;
			bullet_addr = 18'd0;

		if (is_tank1 == 1'b1) begin
			tank_addr = (DrawX - tankX1) + ((DrawY - tankY1) << 3'd5);

			case(tank_dir1)
			3'b001:
				if (RGB_tanku != 24'hFF0000) begin
					Red = RGB_tanku[23:16];
					Green = RGB_tanku[15:8];
					Blue = RGB_tanku[7:0];
				end

			3'b010:
				if (RGB_tankr != 24'hFF0000) begin
					Red = RGB_tankr[23:16];
					Green = RGB_tankr[15:8];
					Blue = RGB_tankr[7:0];
				end

			3'b011:
				if (RGB_tankl != 24'hFF0000) begin
					Red = RGB_tankl[23:16];
					Green = RGB_tankl[15:8];
					Blue = RGB_tankl[7:0];
				end

			3'b100:
				if (RGB_tankd != 24'hFF0000) begin
					Red = RGB_tankd[23:16];
					Green = RGB_tankd[15:8];
					Blue = RGB_tankd[7:0];
				end
			default: ;
			endcase
		end

		else if (is_tank2 == 1'b1 ) begin //&& mode == 1'b0) begin
			tank_addr = (DrawX - tankX2) + ((DrawY - tankY2) << 3'd5);

			case(tank_dir2)
			3'b001:
				if (RGB_tanku != 24'hFF0000) begin
					Red = RGB_tanku[23:16];
					Green = RGB_tanku[15:8];
					Blue = RGB_tanku[7:0];
				end

			3'b010:
				if (RGB_tankr != 24'hFF0000) begin
					Red = RGB_tankr[23:16];
					Green = RGB_tankr[15:8];
					Blue = RGB_tankr[7:0];
				end

			3'b011:
				if (RGB_tankl != 24'hFF0000) begin
					Red = RGB_tankl[23:16];
					Green = RGB_tankl[15:8];
					Blue = RGB_tankl[7:0];
				end

			3'b100:
				if (RGB_tankd != 24'hFF0000) begin
					Red = RGB_tankd[23:16];
					Green = RGB_tankd[15:8];
					Blue = RGB_tankd[7:0];
				end
				
			default: ;
			endcase
		end
		
		else if (is_bullet == 1'b1 && hit1 == 2'b01) begin
			bullet_addr = (DrawX - bulletX1) + ((DrawY - bulletY1) << 3'd4);
			if (RGB_bullet != 24'hFFFFFF) begin
				Red = RGB_bullet[23:16];
				Green = RGB_bullet[15:8];
				Blue = RGB_bullet[7:0];
			end
		end
		
	end

endmodule

//		else if (is_tank3 == 1'b1 && mode == 1'b1) begin
//			tank_addr = (DrawX - tankX3) + ((DrawY - tankY3) << 3'd5);
//
//			case(tank_dir3)
//			3'b001:
//				if (RGB_tanku != 24'hFF0000) begin
//					Red = RGB_tanku & 24'hFF0000 >> 5'd16;
//					Green = RGB_tanku & 24'h00FF00 >> 4'd8;
//					Blue = RGB_tanku & 24'h0000FF;
//				end
//
//			3'b010:
//				if (RGB_tankr != 24'hFF0000) begin
//					Red = RGB_tankr & 24'hFF0000 >> 5'd16;
//					Green = RGB_tankr & 24'h00FF00 >> 4'd8;
//					Blue = RGB_tankr & 24'h0000FF;
//				end
//
//			3'b011:
//				if (RGB_tankl != 24'hFF0000) begin
//					Red = RGB_tankl & 24'hFF0000 >> 5'd16;
//					Green = RGB_tankl & 24'h00FF00 >> 4'd8;
//					Blue = RGB_tankl & 24'h0000FF;
//				end
//
//			3'b100:
//				if (RGB_tankd != 24'hFF0000) begin
//					Red = RGB_tankd & 24'hFF0000 >> 5'd16;
//					Green = RGB_tankd & 24'h00FF00 >> 4'd8;
//					Blue = RGB_tankd & 24'h0000FF;
//				end
//			default: ;
//			endcase
//		end

