module collision (input Clk, Reset,
						input [9:0] X1, Y1, X2, Y2, X3, Y3, X4, Y4, //Walls
                  input [9:0] X_Tank1, Y_Tank1, X_Tank2, Y_Tank2, //Tanks
						input [9:0] saveX1, saveY1, saveX2, saveY2,
						input [9:0] X_Bullet1, Y_Bullet1, X_Bullet2, Y_Bullet2,
                  input [2:0] tank_dir1, tank_dir2, bullet_dir1, bullet_dir2,
						output can_move1, can_move2, tank1_alive, tank2_alive,
						output [1:0] hit1, hit2,
						output [2:0] count1, count2, count3, count4
                  );
						
		parameter [9:0] step = 10'd1;
		parameter [9:0] step_b = 10'd5;
		parameter [9:0] neg_step = ~(step) + 1'b1;
		parameter [9:0] neg_step_b = ~(step_b) + 1'b1;
		parameter [9:0] V_Width = 10'd32;
		parameter [9:0] V_Height = 10'd64;
		parameter [9:0] H_Width = 10'd64;
		parameter [9:0] H_Height = 10'd32;
		parameter [9:0] Tank_Size = 10'd32;
		parameter [9:0] Bullet_Size = 10'd8;
		
		logic [2:0] count1_in, count2_in, count3_in, count4_in;
				
		always_ff @ (posedge Clk or posedge Reset) begin
			if(Reset) begin
				count1 <= 3'd0;
				count2 <= 3'd0;
				count3 <= 3'd0;
				count4 <= 3'd0;
			end
			else begin
				if(count1 == 4)
					count1 <= 3'd4;
				else
					count1 <= count1_in;
				if(count2 == 4)
					count2 <= 3'd4;
				else
					count2 <= count2_in;
				if(count3 == 4)
					count3 <= 3'd4;
				else
					count3 <= count3_in;
				if(count4 == 4)
					count4 <= 3'd4;
				else
					count4 <= count4_in;
			end
		end
		
		always_comb begin

			can_move1 = 1'b1;
			can_move2 = 1'b1;
			hit1 = 2'b01;
			hit2 = 2'b01;
			tank1_alive = 1'b1;
			tank2_alive = 1'b1;
			
			count1_in = count1;
			count2_in = count2;
			count3_in = count3;
			count4_in = count4;
		
			// change to cases w direction
			// tank 1 wall 1 check
			unique case(tank_dir1) 
				3'd1: begin	// moving up
					if ( ((Y_Tank1 + neg_step) == (Y1 + H_Height)) && ((X_Tank1 + Tank_Size) > X1) && (X_Tank1 < (X1 + H_Width)) && (count1 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y2 + V_Height)) && ((X_Tank1 + Tank_Size) > X2) && (X_Tank1 < (X2 + V_Width)) && (count2 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y3 + H_Height)) && ((X_Tank1 + Tank_Size) > X3) && (X_Tank1 < (X3 + H_Width)) && (count3 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y4 + V_Height)) && ((X_Tank1 + Tank_Size) > X4) && (X_Tank1 < (X4 + V_Width)) && (count4 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y_Tank2 + Tank_Size)) && ((X_Tank1 + Tank_Size) > X_Tank2) && (X_Tank1 < (X_Tank2 + Tank_Size)) )
						can_move1 = 1'b0;
				end
				3'd2: begin	// moving right
					if ( ((X_Tank1 + Tank_Size + step) == X1) && ((Y_Tank1 + Tank_Size) > Y1) && (Y_Tank1 < (Y1 + H_Height)) && (count1 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Size + step) == X2) && ((Y_Tank1 + Tank_Size) > Y2) && (Y_Tank1 < (Y2 + V_Height)) && (count2 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Size + step) == X3) && ((Y_Tank1 + Tank_Size) > Y3) && (Y_Tank1 < (Y3 + H_Height)) && (count3 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Size + step) == X4) && ((Y_Tank1 + Tank_Size) > Y4) && (Y_Tank1 < (Y4 + V_Height)) && (count4 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Size + step) == X_Tank2) && ((Y_Tank1 + Tank_Size) > Y_Tank2) && (Y_Tank1 < (Y_Tank2 + Tank_Size)) )
						can_move1 = 1'b0;
				end
				3'd3: begin	// moving left
					if ( ((X_Tank1 + neg_step) == (X1 + H_Width)) && ((Y_Tank1 + Tank_Size) > Y1) && (Y_Tank1 < (Y1 + H_Height)) && (count1 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X2 + V_Width)) && ((Y_Tank1 + Tank_Size) > Y2) && (Y_Tank1 < (Y2 + V_Height)) && (count2 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X3 + H_Width)) && ((Y_Tank1 + Tank_Size) > Y3) && (Y_Tank1 < (Y3 + H_Height)) && (count3 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X4 + V_Width)) && ((Y_Tank1 + Tank_Size) > Y4) && (Y_Tank1 < (Y4 + V_Height)) && (count4 < 3) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X_Tank2 + Tank_Size)) && ((Y_Tank1 + Tank_Size) > Y_Tank2) && (Y_Tank1 < (Y_Tank2 + Tank_Size)) )
						can_move1 = 1'b0;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Tank1 + Tank_Size + step) == Y1) && ((X_Tank1 + Tank_Size) > X1) && (X_Tank1 < (X1 + H_Width)) && (count1 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Size + step) == Y2) && ((X_Tank1 + Tank_Size) > X2) && (X_Tank1 < (X2 + V_Width)) && (count2 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Size + step) == Y3) && ((X_Tank1 + Tank_Size) > X3) && (X_Tank1 < (X3 + H_Width)) && (count3 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Size + step) == Y4) && ((X_Tank1 + Tank_Size) > X4) && (X_Tank1 < (X4 + V_Width)) && (count4 < 3) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Size + step) == Y_Tank2) && ((X_Tank1 + Tank_Size) > X_Tank2) && (X_Tank1 < (X_Tank2 + Tank_Size)) )
						can_move1 = 1'b0;
				end
				default:
					can_move1 = 1'b1;
			endcase
			
			unique case(tank_dir2) 
				3'd1: begin	// moving up
					if ( ((Y_Tank2 + neg_step) == (Y1 + H_Height)) && ((X_Tank2 + Tank_Size) > X1) && (X_Tank2 < (X1 + H_Width)) && (count1 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y2 + V_Height)) && ((X_Tank2 + Tank_Size) > X2) && (X_Tank2 < (X2 + V_Width)) && (count2 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y3 + H_Height)) && ((X_Tank2 + Tank_Size) > X3) && (X_Tank2 < (X3 + H_Width)) && (count3 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y4 + V_Height)) && ((X_Tank2 + Tank_Size) > X4) && (X_Tank2 < (X4 + V_Width)) && (count4 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y_Tank1 + Tank_Size)) && ((X_Tank2 + Tank_Size) > X_Tank1) && (X_Tank2 < (X_Tank1 + Tank_Size)) )
						can_move2 = 1'b0;
				end
				3'd2: begin	// moving right
					if ( ((X_Tank2 + Tank_Size + step) == X1) && ((Y_Tank2 + Tank_Size) > Y1) && (Y_Tank2 < (Y1 + H_Height)) && (count1 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Size + step) == X2) && ((Y_Tank2 + Tank_Size) > Y2) && (Y_Tank2 < (Y2 + V_Height)) && (count2 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Size + step) == X3) && ((Y_Tank2 + Tank_Size) > Y3) && (Y_Tank2 < (Y3 + H_Height)) && (count3 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Size + step) == X4) && ((Y_Tank2 + Tank_Size) > Y4) && (Y_Tank2 < (Y4 + V_Height)) && (count4 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Size + step) == X_Tank1) && ((Y_Tank2 + Tank_Size) > Y_Tank1) && (Y_Tank2 < (Y_Tank1 + Tank_Size)) )
						can_move2 = 1'b0;
				end
				3'd3: begin	// moving left
					if ( ((X_Tank2 + neg_step) == (X1 + H_Width)) && ((Y_Tank2 + Tank_Size) > Y1) && (Y_Tank2 < (Y1 + H_Height)) && (count1 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X2 + V_Width)) && ((Y_Tank2 + Tank_Size) > Y2) && (Y_Tank2 < (Y2 + V_Height)) && (count2 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X3 + H_Width)) && ((Y_Tank2 + Tank_Size) > Y3) && (Y_Tank2 < (Y3 + H_Height)) && (count3 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X4 + V_Width)) && ((Y_Tank2 + Tank_Size) > Y4) && (Y_Tank2 < (Y4 + V_Height)) && (count4 < 3) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X_Tank1 + Tank_Size)) && ((Y_Tank2 + Tank_Size) > Y_Tank1) && (Y_Tank2 < (Y_Tank1 + Tank_Size)) )
						can_move2 = 1'b0;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Tank2 + Tank_Size + step) == Y1) && ((X_Tank2 + Tank_Size) > X1) && (X_Tank2 < (X1 + H_Width)) && (count1 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Size + step) == Y2) && ((X_Tank2 + Tank_Size) > X2) && (X_Tank2 < (X2 + V_Width)) && (count2 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Size + step) == Y3) && ((X_Tank2 + Tank_Size) > X3) && (X_Tank2 < (X3 + H_Width)) && (count3 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Size + step) == Y4) && ((X_Tank2 + Tank_Size) > X4) && (X_Tank2 < (X4 + V_Width)) && (count4 < 3) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Size + step) == Y_Tank1) && ((X_Tank2 + Tank_Size) > X_Tank1) && (X_Tank2 < (X_Tank1 + Tank_Size)) )
						can_move2 = 1'b0;
				end
				default:
					can_move2 = 1'b1;
			endcase
			
			unique case(bullet_dir1) 
				3'd1: begin	// moving up
					if ( ((Y_Bullet1 + neg_step_b) <= (Y1 + H_Height)) && ((X_Bullet1 + Bullet_Size) > X1) && (X_Bullet1 < (X1 + H_Width)) && (saveY1 > (Y1 + H_Height)) && (count1 <= 3) ) begin
						hit1 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y2 + V_Height)) && ((X_Bullet1 + Bullet_Size) > X2) && (X_Bullet1 < (X2 + V_Width)) && (saveY1 > (Y2 + V_Height)) && (count2 <= 3) ) begin
						hit1 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y3 + H_Height)) && ((X_Bullet1 + Bullet_Size) > X3) && (X_Bullet1 < (X3 + H_Width)) && (saveY1 > (Y3 + H_Height)) && (count3 <= 3) ) begin
						hit1 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y4 + V_Height)) && ((X_Bullet1 + Bullet_Size) > X4) && (X_Bullet1 < (X4 + V_Width)) && (saveY1 > (Y4 + V_Height)) && (count4 <= 3) ) begin
						hit1 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((Y_Bullet1 + neg_step_b) <= (Y_Tank2 + Tank_Size)) && ((Y_Bullet1 + Bullet_Size + neg_step_b) >= Y_Tank2) ) begin
						if ( ((X_Bullet1 + Bullet_Size) > X_Tank2) && (X_Bullet1 < (X_Tank2 + Tank_Size)) && (saveY1 > (Y_Tank2 + Tank_Size)) ) begin
							hit1 = 2'b00;
							tank2_alive = 1'b0;
						end
					end
				end
				3'd2: begin	// moving right
					if ( ((X_Bullet1 + Bullet_Size + step_b) >= X1) && ((Y_Bullet1 + Bullet_Size) > Y1) && (Y_Bullet1 < (Y1 + H_Height)) && ((saveX1 + Tank_Size) < X1) && (count1 <= 3) ) begin
						hit1 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X2) && ((Y_Bullet1 + Bullet_Size) > Y2) && (Y_Bullet1 < (Y2 + V_Height)) && ((saveX1 + Tank_Size) < X2) && (count2 <= 3) ) begin
						hit1 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X3) && ((Y_Bullet1 + Bullet_Size) > Y3) && (Y_Bullet1 < (Y3 + H_Height)) && ((saveX1 + Tank_Size) < X3) && (count3 <= 3) ) begin
						hit1 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X4) && ((Y_Bullet1 + Bullet_Size) > Y4) && (Y_Bullet1 < (Y4 + V_Height)) && ((saveX1 + Tank_Size) < X4) && (count4 <= 3) ) begin
						hit1 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((X_Bullet1 + Bullet_Size + step_b) >= X_Tank2) && ((X_Bullet1 + step_b) <= (X_Tank2 + Tank_Size)) ) begin
						if ( ((Y_Bullet1 + Bullet_Size) > Y_Tank2) && (Y_Bullet1 < (Y_Tank2 + Tank_Size)) && ((saveX1 + Tank_Size) < X_Tank2) ) begin
							hit1 = 2'b00;
							tank2_alive = 1'b0;
						end
					end
				end
				3'd3: begin	// moving left
					if ( ((X_Bullet1 + neg_step_b) <= (X1 + H_Width)) && ((Y_Bullet1 + Bullet_Size) > Y1) && (Y_Bullet1 < (Y1 + H_Height)) && (saveX1 > (X1 + H_Width)) && (count1 <= 3) ) begin
						hit1 = 2'b00;
						count1_in = count1 + 1'b1;
						end
					else if ( ((X_Bullet1 + neg_step_b) <= (X2 + V_Width)) && ((Y_Bullet1 + Bullet_Size) > Y2) && (Y_Bullet1 < (Y2 + V_Height)) && (saveX1 > (X2 + V_Width)) && (count2 <= 3) ) begin
						hit1 = 2'b00;
						count2_in = count2 + 1'b1;
						end
					else if ( ((X_Bullet1 + neg_step_b) <= (X3 + H_Width)) && ((Y_Bullet1 + Bullet_Size) > Y3) && (Y_Bullet1 < (Y3 + H_Height)) && (saveX1 > (X3 + H_Width)) && (count3 <= 3) ) begin
						hit1 = 2'b00;
						count3_in = count3 + 1'b1;
						end
					else if ( ((X_Bullet1 + neg_step_b) <= (X4 + V_Width)) && ((Y_Bullet1 + Bullet_Size) > Y4) && (Y_Bullet1 < (Y4 + V_Height)) && (saveX1 > (X4 + V_Width)) && (count4 <= 3) ) begin 
						hit1 = 2'b00;
						count4_in = count4 + 1'b1;
						end
					if ( ((X_Bullet1 + neg_step_b) <= (X_Tank2 + Tank_Size)) && ((X_Bullet1 + Bullet_Size + neg_step_b) >= X_Tank2) ) begin
						if ( ((Y_Bullet1 + Bullet_Size) > Y_Tank2) && (Y_Bullet1 < (Y_Tank2 + Tank_Size)) && (saveX1 > (X_Tank2 + Tank_Size)) ) begin
							hit1 = 2'b00;
							tank2_alive = 1'b0;
						end
					end
				end	
				3'd4: begin	// moving down
					if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y1) && ((X_Bullet1 + Bullet_Size) > X1) && (X_Bullet1 < (X1 + H_Width)) && ((saveY1 + Tank_Size) < Y1) && (count1 <= 3) ) begin
						hit1 = 2'b00;
						count1_in = count1 + 1'b1;
						end
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y2) && ((X_Bullet1 + Bullet_Size) > X2) && (X_Bullet1 < (X2 + V_Width)) && ((saveY1 + Tank_Size) < Y2) && (count2 <= 3) ) begin
						hit1 = 2'b00;
						count2_in = count2 + 1'b1;
						end
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y3) && ((X_Bullet1 + Bullet_Size) > X3) && (X_Bullet1 < (X3 + H_Width)) && ((saveY1 + Tank_Size) < Y3) && (count3 <= 3) ) begin
						hit1 = 2'b00;
						count3_in = count3 + 1'b1;
						end
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y4) && ((X_Bullet1 + Bullet_Size) > X4) && (X_Bullet1 < (X4 + V_Width)) && ((saveY1 + Tank_Size) < Y4) && (count4 <= 3) ) begin
						hit1 = 2'b00;
						count4_in = count4 + 1'b1;
						end
					if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y_Tank2) && ((Y_Bullet1 + step_b) <= (Y_Tank2 + Tank_Size)) ) begin
						if ( ((X_Bullet1 + Bullet_Size) > X_Tank2) && (X_Bullet1 < (X_Tank2 + Tank_Size)) && ((saveY1 + Tank_Size) < Y_Tank2) ) begin
							hit1 = 2'b00;
							tank2_alive = 1'b0;
						end
					end
				end
				default:
					hit1 = 2'b01;
			endcase 
			
			unique case(bullet_dir2) 
				3'd1: begin	// moving up
					if ( ((Y_Bullet2 + neg_step_b) <= (Y1 + H_Height)) && ((X_Bullet2 + Bullet_Size) > X1) && (X_Bullet2 < (X1 + H_Width)) && (saveY2 > (Y1 + H_Height)) && (count1 <= 3) ) begin
						hit2 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y2 + V_Height)) && ((X_Bullet2 + Bullet_Size) > X2) && (X_Bullet2 < (X2 + V_Width)) && (saveY2 > (Y2 + V_Height)) && (count2 <= 3) ) begin
						hit2 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y3 + H_Height)) && ((X_Bullet2 + Bullet_Size) > X3) && (X_Bullet2 < (X3 + H_Width)) && (saveY2 > (Y3 + H_Height)) && (count3 <= 3) ) begin
						hit2 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y4 + V_Height)) && ((X_Bullet2 + Bullet_Size) > X4) && (X_Bullet2 < (X4 + V_Width)) && (saveY2 > (Y4 + V_Height)) && (count4 <= 3) ) begin
						hit2 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((Y_Bullet2 + neg_step_b) <= (Y_Tank1 + Tank_Size)) && ((Y_Bullet2 + Bullet_Size + neg_step_b) >= Y_Tank1) ) begin
						if ( ((X_Bullet2 + Bullet_Size) > X_Tank1) && (X_Bullet2 < (X_Tank1 + Tank_Size)) && (saveY2 > (Y_Tank1 + Tank_Size)) ) begin
							hit2 = 2'b00;
							tank1_alive = 1'b0;
						end
					end
				end
				3'd2: begin	// moving right
					if ( ((X_Bullet2 + Bullet_Size + step_b) >= X1) && ((Y_Bullet2 + Bullet_Size) > Y1) && (Y_Bullet2 < (Y1 + H_Height)) && ((saveX2 + Tank_Size) < X1) && (count1 <= 3) ) begin
						hit2 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X2) && ((Y_Bullet2 + Bullet_Size) > Y2) && (Y_Bullet2 < (Y2 + V_Height)) && ((saveX2 + Tank_Size) < X2) && (count2 <= 3) ) begin
						hit2 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X3) && ((Y_Bullet2 + Bullet_Size) > Y3) && (Y_Bullet2 < (Y3 + H_Height)) && ((saveX2 + Tank_Size) < X3) && (count3 <= 3) ) begin
						hit2 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X4) && ((Y_Bullet2 + Bullet_Size) > Y4) && (Y_Bullet2 < (Y4 + V_Height)) && ((saveX2 + Tank_Size) < X4) && (count4 <= 3) ) begin
						hit2 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((X_Bullet2 + Bullet_Size + step_b) >= X_Tank1) && ((X_Bullet2 + step_b) <= (X_Tank1 + Tank_Size)) ) begin
						if ( ((Y_Bullet2 + Bullet_Size) > Y_Tank1) && (Y_Bullet2 < (Y_Tank1 + Tank_Size)) && ((saveX2 + Tank_Size) < X_Tank1) ) begin
							hit2 = 2'b00;	
							tank1_alive = 1'b0;
						end
					end
				end
				3'd3: begin	// moving left
					if ( ((X_Bullet2 + neg_step_b) <= (X1 + H_Width)) && ((Y_Bullet2 + Bullet_Size) > Y1) && (Y_Bullet2 < (Y1 + H_Height)) && (saveX2 > (X1 + H_Width)) && (count1 <= 3) ) begin
						hit2 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((X_Bullet2 + neg_step_b) <= (X2 + V_Width)) && ((Y_Bullet2 + Bullet_Size) > Y2) && (Y_Bullet2 < (Y2 + V_Height)) && (saveX2 > (X2 + V_Width)) && (count2 <= 3) ) begin
						hit2 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((X_Bullet2 + neg_step_b) <= (X3 + H_Width)) && ((Y_Bullet2 + Bullet_Size) > Y3) && (Y_Bullet2 < (Y3 + H_Height)) && (saveX2 > (X3 + H_Width)) && (count3 <= 3) ) begin
						hit2 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((X_Bullet2 + neg_step_b) <= (X4 + V_Width)) && ((Y_Bullet2 + Bullet_Size) > Y4) && (Y_Bullet2 < (Y4 + V_Height)) && (saveX2 > (X4 + V_Width)) && (count4 <= 3) ) begin
						hit2 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((X_Bullet2 + neg_step_b) <= (X_Tank1 + Tank_Size)) && ((X_Bullet2 + Bullet_Size + neg_step_b) >= X_Tank1) ) begin
						if ( ((Y_Bullet2 + Bullet_Size) > Y_Tank1) && (Y_Bullet2 < (Y_Tank1 + Tank_Size)) && (saveX2 > (X_Tank1 + Tank_Size)) ) begin
							hit2 = 2'b00;
							tank1_alive = 1'b0;
						end
					end
				end	
				3'd4: begin	// moving down
					if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y1) && ((X_Bullet2 + Bullet_Size) > X1) && (X_Bullet2 < (X1 + H_Width)) && ((saveY2 + Tank_Size) < Y1) && (count1 <= 3) ) begin
						hit2 = 2'b00;
						count1_in = count1 + 1'b1;
					end
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y2) && ((X_Bullet2 + Bullet_Size) > X2) && (X_Bullet2 < (X2 + V_Width)) && ((saveY2 + Tank_Size) < Y2) && (count2 <= 3) ) begin
						hit2 = 2'b00;
						count2_in = count2 + 1'b1;
					end
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y3) && ((X_Bullet2 + Bullet_Size) > X3) && (X_Bullet2 < (X3 + H_Width)) && ((saveY2 + Tank_Size) < Y3) && (count3 <= 3) ) begin
						hit2 = 2'b00;
						count3_in = count3 + 1'b1;
					end
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y4) && ((X_Bullet2 + Bullet_Size) > X4) && (X_Bullet2 < (X4 + V_Width)) && ((saveY2 + Tank_Size) < Y4) && (count4 <= 3) ) begin
						hit2 = 2'b00;
						count4_in = count4 + 1'b1;
					end
					if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y_Tank1) && ((Y_Bullet2 + step_b) <= (Y_Tank1 + Tank_Size)) ) begin
						if ( ((X_Bullet2 + Bullet_Size) > X_Tank1) && (X_Bullet2 < (X_Tank1 + Tank_Size)) && ((saveY2 + Tank_Size) < Y_Tank1) ) begin
							hit2 = 2'b00;
							tank1_alive = 1'b0;
						end
					end
				end
				default:
					hit2 = 2'b01;
			endcase
				
		end
			
endmodule 