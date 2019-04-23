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
module  color_mapper (  input			is_tank1, is_tank2, is_shooting1, is_shooting2, is_bullet,
												input 		is_wall1, is_wall2, is_wall3, is_wall4,
												input 		[1:0] hit1, hit2,
											  input			[2:0] tank_dir1, tank_dir2,
				                input     [9:0] DrawX, DrawY,       // Current pixel coordinates
											  input			[9:0] tankX1, tankX2, tankY1, tankY2, bullet_X1, bullet_Y1,
												input 		[9:0] wall_X1, wall_X2, wall_X3, wall_X4, wall_Y1, wall_Y2, wall_Y3, wall_Y4,
											  input			Clk,
                       	output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );

	 parameter [9:0] TankWidth = 10'd32;
	 parameter [9:0] TankHeight = 10'd32;
	 parameter [9:0] BackWidth = 10'd640;

    logic [7:0] Red, Green, Blue;
	 logic [18:0] tank_addr, back_addr, bullet_addr;
	 logic [23:0] RGB_tanku, RGB_tankr, RGB_tankl, RGB_tankd, RGB_back;

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

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
//	 frameRAM_Background back(.read_address(back_addr), .Clk(Clk),
//									  .data_Out(RGB_back)
//									  );
		frameRAM_Bullet bullet(.read_address(bullet_addr), .Clk(Clk),
 									.data_Out(RGB_bullet));

		frameRAM_Wall_H horizon (.read_address(wall_addr), .Clk(Clk),
 									.data_Out(RGB_wall_h));

		frameRAM_Wall_H verizon (.read_address(wall_addr), .Clk(Clk),
 									.data_Out(RGB_wall_v));

    always_comb
    begin
//			back_addr = DrawX + (DrawY * BackWidth);
			Red = 24'hFFFFFF;
			Green = 24'hFFFFFF;
			Blue = 24'hFFFFFF;
			tank_addr = 18'b0;

		if (is_tank1 == 1'b1) begin
			tank_addr = (DrawX - tankX1) + ((DrawY - tankY1) << 3'd5);

			case(tank_dir1)
			3'b001:
				if (RGB_tanku != 24'hFF0000) begin
					Red = RGB_tanku & 24'hFF0000 >> 5'd16;
					Green = RGB_tanku & 24'h00FF00 >> 4'd8;
					Blue = RGB_tanku & 24'h0000FF;
				end

			3'b010:
				if (RGB_tankr != 24'hFF0000) begin
					Red = RGB_tankr & 24'hFF0000 >> 5'd16;
					Green = RGB_tankr & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankr & 24'h0000FF;
				end

			3'b011:
				if (RGB_tankl != 24'hFF0000) begin
					Red = RGB_tankl & 24'hFF0000 >> 5'd16;
					Green = RGB_tankl & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankl & 24'h0000FF;
				end

			3'b100:
				if (RGB_tankd != 24'hFF0000) begin
					Red = RGB_tankd & 24'hFF0000 >> 5'd16;
					Green = RGB_tankd & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankd & 24'h0000FF;
				end
			default: ;
			endcase
		end

		else if (is_tank2 == 1'b1 && mode == 1'b0) begin
			tank_addr = (DrawX - tankX2) + ((DrawY - tankY2) << 3'd5);

			case(tank_dir2)
			3'b001:
				if (RGB_tanku != 24'hFF0000) begin
					Red = RGB_tanku & 24'hFF0000 >> 5'd16;
					Green = RGB_tanku & 24'h00FF00 >> 4'd8;
					Blue = RGB_tanku & 24'h0000FF;
				end

			3'b010:
				if (RGB_tankr != 24'hFF0000) begin
					Red = RGB_tankr & 24'hFF0000 >> 5'd16;
					Green = RGB_tankr & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankr & 24'h0000FF;
				end

			3'b011:
				if (RGB_tankl != 24'hFF0000) begin
					Red = RGB_tankl & 24'hFF0000 >> 5'd16;
					Green = RGB_tankl & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankl & 24'h0000FF;
				end

			3'b100:
				if (RGB_tankd != 24'hFF0000) begin
					Red = RGB_tankd & 24'hFF0000 >> 5'd16;
					Green = RGB_tankd & 24'h00FF00 >> 4'd8;
					Blue = RGB_tankd & 24'h0000FF;
				end
				default: ;
			endcase

			else if (is_tank3 == 1'b1 && mode == 1'b1) begin
				tank_addr = (DrawX - tankX3) + ((DrawY - tankY3) << 3'd5);

				case(tank_dir3)
				3'b001:
					if (RGB_tanku != 24'hFF0000) begin
						Red = RGB_tanku & 24'hFF0000 >> 5'd16;
						Green = RGB_tanku & 24'h00FF00 >> 4'd8;
						Blue = RGB_tanku & 24'h0000FF;
					end

				3'b010:
					if (RGB_tankr != 24'hFF0000) begin
						Red = RGB_tankr & 24'hFF0000 >> 5'd16;
						Green = RGB_tankr & 24'h00FF00 >> 4'd8;
						Blue = RGB_tankr & 24'h0000FF;
					end

				3'b011:
					if (RGB_tankl != 24'hFF0000) begin
						Red = RGB_tankl & 24'hFF0000 >> 5'd16;
						Green = RGB_tankl & 24'h00FF00 >> 4'd8;
						Blue = RGB_tankl & 24'h0000FF;
					end

				3'b100:
					if (RGB_tankd != 24'hFF0000) begin
						Red = RGB_tankd & 24'hFF0000 >> 5'd16;
						Green = RGB_tankd & 24'h00FF00 >> 4'd8;
						Blue = RGB_tankd & 24'h0000FF;
					end
			default: ;
			endcase
		end
		else if (is_bullet) begin
			bullet_addr = (DrawX - bullet_X1) + ((DrawY - bullet_Y1) << 3'd4);
			if (RGB_bullet != 24'hFFFFFF) begin
				Red = RGB_bullet & 24'hFF0000 >> 5'd16;
				Green = RGB_bullet & 24'h00FF00 >> 4'd8;
				Blue = RGB_bullet & 24'h0000FF;
			end
		else if (is_wall1) begin
			hor_wall_addr = (DrawX - wall_X1) + ((DrawY - wall_Y1) << 3'd4);
			if (RGB_wall_h != 24'hFFFFFF) begin
				Red = RGB_wall_h & 24'hFF0000 >> 5'd16;
				Green = RGB_wall_h & 24'h00FF00 >> 4'd8;
				Blue = RGB_wall_h & 24'h0000FF;
			end
		else if (is_wall2) begin
			wall_addr = (DrawX - wall_X2) + ((DrawY - wall_Y2) << 3'd4);
			if (RGB_wall_v != 24'hFFFFFF) begin
				Red = RGB_wall_v & 24'hFF0000 >> 5'd16;
				Green = RGB_wall_v & 24'h00FF00 >> 4'd8;
				Blue = RGB_wall_v & 24'h0000FF;
			end
		else if (is_wall3) begin
			wall_addr = (DrawX - wall_X3) + ((DrawY - wall_Y3) << 3'd4);
			if (RGB_wall_h != 24'hFFFFFF) begin
				Red = RGB_wall_h & 24'hFF0000 >> 5'd16;
				Green = RGB_wall_h & 24'h00FF00 >> 4'd8;
				Blue = RGB_wall_h & 24'h0000FF;
			end
		else if (is_wall4) begin
			wall_addr = (DrawX - wall_X4) + ((DrawY - wall_Y4) << 3'd4);
			if (RGB_wall_v != 24'hFFFFFF) begin
				Red = RGB_wall_v & 24'hFF0000 >> 5'd16;
				Green = RGB_wall_v & 24'h00FF00 >> 4'd8;
				Blue = RGB_wall_v & 24'h0000FF;
			end
	end

endmodule
