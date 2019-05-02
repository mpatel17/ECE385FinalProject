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
module  color_mapper (input			is_tank1, is_tank2, is_bullet1, is_bullet2, tank1_alive, tank2_alive,
							 input			is_wall1, is_wall2, is_wall3, is_wall4,
							 input	[1:0] hit1, hit2,
							 input	[2:0] tank_dir1, tank_dir2,
							 input   [9:0] DrawX, DrawY,       // Current pixel coordinates
							 input	[9:0] tankX1, tankX2, tankY1, tankY2, bulletX1, bulletY1, bulletX2, bulletY2,
							 input	[9:0] wallX1, wallX2, wallX3, wallX4, wallY1, wallY2, wallY3, wallY4,
							 input 	[2:0] count1, count2, count3, count4,
							 input			Clk, Reset, frame_clk,
                      output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );

	 logic [9:0] gameoverX, gameoverY, playerX, playerY;

    logic [7:0] Red, Green, Blue;
	 logic [18:0] tank_addr, bullet_addr, wall_addr_v, wall_addr_h, gameover_addr, p1_addr, p2_addr, death_addr;
	 logic [23:0] RGB_tanku, RGB_tankr, RGB_tankl, RGB_tankd, RGB_bullet, RGB_wall_v, RGB_wall_h, RGB_gameover, RGB_p1, RGB_p2;
	 logic [23:0] RGB_death, RGB_death1, RGB_death2, RGB_death3, RGB_death4, RGB_death5, RGB_normal;
	 logic flag1, flag1_in, flag2, flag2_in;
	 logic [4:0] death_counter;

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 assign gameoverX = 10'd250;
	 assign gameoverY = 10'd200;
	 assign playerX = 10'd314;
	 assign playerY = 10'd232;
	 assign RGB_normal = 24'hb7fe7b;

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
	 frameRAM_Wall_H horizon (.read_address(wall_addr_h), .Clk(Clk),
 									.data_Out(RGB_wall_h)
									);

	 frameRAM_Wall_V verizon (.read_address(wall_addr_v), .Clk(Clk),
 									.data_Out(RGB_wall_v)
									);
									
	 frameRAM_GameOver gameover (.read_address(gameover_addr), .Clk(Clk),
											.data_Out(RGB_gameover)
											);
									
	 frameRAM_Player1 p1wins (.read_address(p1_addr), .Clk(Clk),
									  .data_Out(RGB_p1)
									  );
	 
	 frameRAM_Player2 p2wins (.read_address(p2_addr), .Clk(Clk),
									  .data_Out(RGB_p2)
									  );
									  
	 frameRAM_death1 death1 (.read_address(death_addr), .Clk(Clk),
									 .data_Out(RGB_death1)
									 );
									 
	 frameRAM_death2 death2 (.read_address(death_addr), .Clk(Clk),
									 .data_Out(RGB_death2)
									 );
									 
	 frameRAM_death3 death3 (.read_address(death_addr), .Clk(Clk),
									 .data_Out(RGB_death3)
									 );
									 
	 frameRAM_death4 death4 (.read_address(death_addr), .Clk(Clk),
									 .data_Out(RGB_death4)
									 );
									 
	 frameRAM_death5 death5 (.read_address(death_addr), .Clk(Clk),
									 .data_Out(RGB_death5)
									 );

	 
	
	 always_ff @ (posedge frame_clk or posedge Reset) begin
		if (Reset) begin
			flag1 <= 1'b0;
			flag2 <= 1'b0;
		end
		else begin
			flag1 <= flag1_in;
			flag2 <= flag2_in;
			if (flag1 || flag2) begin
				if (death_counter <= 5'd25)
					death_counter <= death_counter + 1'b1;
				else
					death_counter <= 5'd26;
			end
			else
				death_counter <= 5'd0;
		end
	 end

    always_comb
    begin

		flag1_in = flag1;
		flag2_in = flag2;
		tank_addr = 18'd0;
		bullet_addr = 18'd0;
		wall_addr_h = 18'd0;
		wall_addr_v = 18'd0;
		gameover_addr = 18'd0;
		p1_addr = 18'd0;
		p2_addr = 18'd0;
		death_addr = 18'd0;
		RGB_death = 24'd0;
		
		if(~tank1_alive)
			flag1_in = 1'b1;
		if(~tank2_alive)
			flag2_in = 1'b1;
			
		Red = 8'd183;
		Green = 8'd254;
		Blue = 8'd123;
			
		if((flag1 || flag2) && death_counter > 25) begin
			Red = 8'h00;
			Green = 8'h00;
			Blue = 8'h00;
			
			if(DrawX > 250 && DrawX < 378 && DrawY > 200 && DrawY < 264) begin
					gameover_addr = (DrawX - gameoverX) + ((DrawY - gameoverY) << 7);
					if(RGB_gameover != 24'hFF0000) begin
						Red = RGB_gameover[23:16];
						Green = RGB_gameover[15:8];
						Blue = RGB_gameover[7:0];
					end
				end 
				if(DrawX > 314 && DrawX < 330 && DrawY > 232 && DrawY < 248) begin
					if(flag1) begin
						p1_addr = (DrawX - playerX) + ((DrawY - playerY) << 4);
						if(RGB_p1 != 24'hFF0000) begin
							Red = RGB_p1[23:16];
							Green = RGB_p1[15:8];
							Blue = RGB_p1[7:0];
						end
					end
					
					else begin
						p2_addr = (DrawX - playerX) + ((DrawY - playerY) << 4);
						if(RGB_p2 != 24'hFF0000) begin
							Red = RGB_p2[23:16];
							Green = RGB_p2[15:8];
							Blue = RGB_p2[7:0];
						end
					end
				end
		end else begin
			if (is_tank1 && ~flag1) begin
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
			
			else if (is_tank1 && flag1) begin
				death_addr = (DrawX - tankX1) + ((DrawY - tankY1) << 3'd5);
				if(death_counter >= 0 && death_counter < 5)
					RGB_death = RGB_death1;
				else if(death_counter >= 5 && death_counter < 10)
					RGB_death = RGB_death2;
				else if(death_counter >= 10 && death_counter < 15)
					RGB_death = RGB_death3;
				else if(death_counter >= 15 && death_counter < 20)
					RGB_death = RGB_death4;
				else if(death_counter >= 20 && death_counter < 25)
					RGB_death = RGB_death5;
				else 
					RGB_death = RGB_normal;
				if(RGB_death != 24'hFFFED2) begin
					Red = RGB_death[23:16];
					Green = RGB_death[15:8];
					Blue = RGB_death[7:0];
				end
			end

			else if (is_tank2 && ~flag2) begin 
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
			
			else if(is_tank2 && flag2) begin
				death_addr = (DrawX - tankX2) + ((DrawY - tankY2) << 3'd5);
				if(death_counter >= 0 && death_counter < 5)
					RGB_death = RGB_death1;
				else if(death_counter >= 5 && death_counter < 10)
					RGB_death = RGB_death2;
				else if(death_counter >= 10 && death_counter < 15)
					RGB_death = RGB_death3;
				else if(death_counter >= 15 && death_counter < 20)
					RGB_death = RGB_death4;
				else if(death_counter >= 20 && death_counter < 25)
					RGB_death = RGB_death5;
				else 
					RGB_death = RGB_normal;
				if(RGB_death != 24'hFFFED2) begin
					Red = RGB_death[23:16];
					Green = RGB_death[15:8];
					Blue = RGB_death[7:0];
				end
			end
			
			else if (is_bullet1 && hit1 == 2'b01 )begin
				bullet_addr = (DrawX - bulletX1) + ((DrawY - bulletY1) << 2'd3);
				if (RGB_bullet != 24'hFFFFFF) begin
					Red = RGB_bullet[23:16];
					Green = RGB_bullet[15:8];
					Blue = RGB_bullet[7:0];
				end
				if (DrawX < 9 && DrawY < 9) begin
					Red = 24'd183;
					Green = 24'd254;
					Blue = 24'd123;
				end
			end

			else if (is_bullet2 && hit2 == 2'b01 ) begin
				bullet_addr = (DrawX - bulletX2) + ((DrawY - bulletY2) << 2'd3);
				if (RGB_bullet != 24'hFFFFFF) begin
					Red = RGB_bullet[23:16];
					Green = RGB_bullet[15:8];
					Blue = RGB_bullet[7:0];
				end
				if (DrawX < 9 && DrawY < 9) begin
					Red = 24'd183;
					Green = 24'd254;
					Blue = 24'd123;
				end
			end

			else if (is_wall1 && (count1 < 3)) begin
				wall_addr_h = (DrawX - wallX1) + ((DrawY - wallY1) << 3'd6);
				if (RGB_wall_h != 24'hFF0000) begin
					if(count1 == 0) begin
						Red = RGB_wall_h[23:16];
						Green = RGB_wall_h[15:8];
						Blue = RGB_wall_h[7:0];
					end
					else if(count1 == 1) begin
						Red = (RGB_wall_h[23:16] + 50) % 255;
						Green = (RGB_wall_h[15:8] + 50) % 255;
						Blue = (RGB_wall_h[7:0] + 50) % 255;
					end
					else begin
						Red = (RGB_wall_h[23:16] + 100) % 255;
						Green = (RGB_wall_h[15:8] + 100) % 255;
						Blue = (RGB_wall_h[7:0] + 100) % 255;
					end
				end
			end
			
			else if (is_wall3 && (count3 < 3)) begin
				wall_addr_h = (DrawX - wallX3) + ((DrawY - wallY3) << 3'd6);
				if (RGB_wall_h != 24'hFF0000) begin
					if(count3 == 0) begin
						Red = RGB_wall_h[23:16];
						Green = RGB_wall_h[15:8];
						Blue = RGB_wall_h[7:0];
					end
					else if(count3 == 1) begin
						Red = (RGB_wall_h[23:16] + 50) % 255;
						Green = (RGB_wall_h[15:8] + 50) % 255;
						Blue = (RGB_wall_h[7:0] + 50) % 255;
					end
					else begin
						Red = (RGB_wall_h[23:16] + 100) % 255;
						Green = (RGB_wall_h[15:8] + 100) % 255;
						Blue = (RGB_wall_h[7:0] + 100) % 255;
					end
				end
			end

			else if (is_wall2 && (count2 < 3)) begin
				wall_addr_v = (DrawX - wallX2) + ((DrawY - wallY2) << 3'd5);
				if (RGB_wall_v != 24'hFF0000) begin
					if(count2 == 0) begin
						Red = RGB_wall_v[23:16];
						Green = RGB_wall_v[15:8];
						Blue = RGB_wall_v[7:0];
					end
					else if(count2 == 1) begin
						Red = (RGB_wall_v[23:16] + 50) % 255;
						Green = (RGB_wall_v[15:8] + 50) % 255;
						Blue = (RGB_wall_v[7:0] + 50) % 255;
					end
					else begin
						Red = (RGB_wall_v[23:16] + 100) % 255;
						Green = (RGB_wall_v[15:8] + 100) % 255;
						Blue = (RGB_wall_v[7:0] + 100) % 255;
					end
				end
			end
			
			else if (is_wall4 && (count4 < 3)) begin
				wall_addr_v = (DrawX - wallX4) + ((DrawY - wallY4) << 3'd5);
				if (RGB_wall_v != 24'hFF0000) begin
					if(count4 == 0) begin
						Red = RGB_wall_v[23:16];
						Green = RGB_wall_v[15:8];
						Blue = RGB_wall_v[7:0];
					end
					else if(count4 == 1) begin
						Red = (RGB_wall_v[23:16] + 50) % 255;
						Green = (RGB_wall_v[15:8] + 50) % 255;
						Blue = (RGB_wall_v[7:0] + 50) % 255;
					end
					else begin
						Red = (RGB_wall_v[23:16] + 100) % 255;
						Green = (RGB_wall_v[15:8] + 100) % 255;
						Blue = (RGB_wall_v[7:0] + 100) % 255;
					end
				end
			end
			
		end
	end
endmodule

