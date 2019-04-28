module collision (input [9:0] X1, Y1, X2, Y2, X3, Y3, X4, Y4, //Walls
                  input [9:0] X_Tank1, Y_Tank1, X_Tank2, Y_Tank2, //Tanks
						input [9:0] X_Bullet1, Y_Bullet1, X_Bullet2, Y_Bullet2,
                  input [2:0] tank_dir1, tank_dir2, bullet_dir1, bullet_dir2,
						output can_move1, can_move2, tank_hit1, tank_hit2,
						output [1:0] hit1, hit2
                  );
						
		parameter [9:0] step = 10'd1;
		parameter [9:0] step_b = 10'd5;
		parameter [9:0] neg_step = ~(step) + 1'b1;
		parameter [9:0] neg_step_b = ~(step_b) + 1'b1;
		parameter [9:0] V_Width = 10'd32;
		parameter [9:0] V_Height = 10'd64;
		parameter [9:0] H_Width = 10'd64;
		parameter [9:0] H_Height = 10'd32;
		parameter [9:0] Tank_Width = 10'd32;
		parameter [9:0] Tank_Height = 10'd32;
		parameter [9:0] Bullet_Size = 10'd8;
		
		
		always_comb begin
		
			can_move1 = 1'b1;
			can_move2 = 1'b1;
			hit1 = 2'b01;
			hit2 = 2'b01;
		
			// change to cases w direction
			// tank 1 wall 1 check
			unique case(tank_dir1) 
				3'd1: begin	// moving up
					if ( ((Y_Tank1 + neg_step) == (Y1 + H_Height)) && ((X_Tank1 + Tank_Width) > X1) && (X_Tank1 < (X1 + H_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y2 + V_Height)) && ((X_Tank1 + Tank_Width) > X2) && (X_Tank1 < (X2 + V_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y3 + H_Height)) && ((X_Tank1 + Tank_Width) > X3) && (X_Tank1 < (X3 + H_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + neg_step) == (Y4 + V_Height)) && ((X_Tank1 + Tank_Width) > X4) && (X_Tank1 < (X4 + V_Width)) )
						can_move1 = 1'b0;
				end
				3'd2: begin	// moving right
					if ( ((X_Tank1 + Tank_Width + step) == X1) && ((Y_Tank1 + Tank_Height) > Y1) && (Y_Tank1 < (Y1 + H_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Width + step) == X2) && ((Y_Tank1 + Tank_Height) > Y2) && (Y_Tank1 < (Y2 + V_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Width + step) == X3) && ((Y_Tank1 + Tank_Height) > Y3) && (Y_Tank1 < (Y3 + H_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + Tank_Width + step) == X4) && ((Y_Tank1 + Tank_Height) > Y4) && (Y_Tank1 < (Y4 + V_Height)) )
						can_move1 = 1'b0;
				end
				3'd3: begin	// moving left
					if ( ((X_Tank1 + neg_step) == (X1 + H_Width)) && ((Y_Tank1 + Tank_Height) > Y1) && (Y_Tank1 < (Y1 + H_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X2 + V_Width)) && ((Y_Tank1 + Tank_Height) > Y2) && (Y_Tank1 < (Y2 + V_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X3 + H_Width)) && ((Y_Tank1 + Tank_Height) > Y3) && (Y_Tank1 < (Y3 + H_Height)) )
						can_move1 = 1'b0;
					else if ( ((X_Tank1 + neg_step) == (X4 + V_Width)) && ((Y_Tank1 + Tank_Height) > Y4) && (Y_Tank1 < (Y4 + V_Height)) )
						can_move1 = 1'b0;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Tank1 + Tank_Height + step) == Y1) && ((X_Tank1 + Tank_Width) > X1) && (X_Tank1 < (X1 + H_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Height + step) == Y2) && ((X_Tank1 + Tank_Width) > X2) && (X_Tank1 < (X2 + V_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Height + step) == Y3) && ((X_Tank1 + Tank_Width) > X3) && (X_Tank1 < (X3 + H_Width)) )
						can_move1 = 1'b0;
					else if ( ((Y_Tank1 + Tank_Height + step) == Y4) && ((X_Tank1 + Tank_Width) > X4) && (X_Tank1 < (X4 + V_Width)) )
						can_move1 = 1'b0;
				end
				default:
					can_move1 = 1'b1;
			endcase
			
			unique case(tank_dir2) 
				3'd1: begin	// moving up
					if ( ((Y_Tank2 + neg_step) == (Y1 + H_Height)) && ((X_Tank2 + Tank_Width) > X1) && (X_Tank2 < (X1 + H_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y2 + V_Height)) && ((X_Tank2 + Tank_Width) > X2) && (X_Tank2 < (X2 + V_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y3 + H_Height)) && ((X_Tank2 + Tank_Width) > X3) && (X_Tank2 < (X3 + H_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + neg_step) == (Y4 + V_Height)) && ((X_Tank2 + Tank_Width) > X4) && (X_Tank2 < (X4 + V_Width)) )
						can_move2 = 1'b0;
				end
				3'd2: begin	// moving right
					if ( ((X_Tank2 + Tank_Width + step) == X1) && ((Y_Tank2 + Tank_Height) > Y1) && (Y_Tank2 < (Y1 + H_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Width + step) == X2) && ((Y_Tank2 + Tank_Height) > Y2) && (Y_Tank2 < (Y2 + V_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Width + step) == X3) && ((Y_Tank2 + Tank_Height) > Y3) && (Y_Tank2 < (Y3 + H_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + Tank_Width + step) == X4) && ((Y_Tank2 + Tank_Height) > Y4) && (Y_Tank2 < (Y4 + V_Height)) )
						can_move2 = 1'b0;
				end
				3'd3: begin	// moving left
					if ( ((X_Tank2 + neg_step) == (X1 + H_Width)) && ((Y_Tank2 + Tank_Height) > Y1) && (Y_Tank2 < (Y1 + H_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X2 + V_Width)) && ((Y_Tank2 + Tank_Height) > Y2) && (Y_Tank2 < (Y2 + V_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X3 + H_Width)) && ((Y_Tank2 + Tank_Height) > Y3) && (Y_Tank2 < (Y3 + H_Height)) )
						can_move2 = 1'b0;
					else if ( ((X_Tank2 + neg_step) == (X4 + V_Width)) && ((Y_Tank2 + Tank_Height) > Y4) && (Y_Tank2 < (Y4 + V_Height)) )
						can_move2 = 1'b0;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Tank2 + Tank_Height + step) == Y1) && ((X_Tank2 + Tank_Width) > X1) && (X_Tank2 < (X1 + H_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Height + step) == Y2) && ((X_Tank2 + Tank_Width) > X2) && (X_Tank2 < (X2 + V_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Height + step) == Y3) && ((X_Tank2 + Tank_Width) > X3) && (X_Tank2 < (X3 + H_Width)) )
						can_move2 = 1'b0;
					else if ( ((Y_Tank2 + Tank_Height + step) == Y4) && ((X_Tank2 + Tank_Width) > X4) && (X_Tank2 < (X4 + V_Width)) )
						can_move2 = 1'b0;
				end
				default:
					can_move2 = 1'b1;
			endcase
			
			unique case(bullet_dir1) 
				3'd1: begin	// moving up
					if ( ((Y_Bullet1 + neg_step_b) <= (Y1 + H_Height)) && ((X_Bullet1 + Bullet_Size) > X1) && (X_Bullet1 < (X1 + H_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y2 + V_Height)) && ((X_Bullet1 + Bullet_Size) > X2) && (X_Bullet1 < (X2 + V_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y3 + H_Height)) && ((X_Bullet1 + Bullet_Size) > X3) && (X_Bullet1 < (X3 + H_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + neg_step_b) <= (Y4 + V_Height)) && ((X_Bullet1 + Bullet_Size) > X4) && (X_Bullet1 < (X4 + V_Width)) )
						hit1 = 2'b00;
				end
				3'd2: begin	// moving right
					if ( ((X_Bullet1 + Bullet_Size + step_b) >= X1) && ((Y_Bullet1 + Bullet_Size) > Y1) && (Y_Bullet1 < (Y1 + H_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X2) && ((Y_Bullet1 + Bullet_Size) > Y2) && (Y_Bullet1 < (Y2 + V_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X3) && ((Y_Bullet1 + Bullet_Size) > Y3) && (Y_Bullet1 < (Y3 + H_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + Bullet_Size + step_b) >= X4) && ((Y_Bullet1 + Bullet_Size) > Y4) && (Y_Bullet1 < (Y4 + V_Height)) )
						hit1 = 2'b00;
				end
				3'd3: begin	// moving left
					if ( ((X_Bullet1 + neg_step_b) <= (X1 + H_Width)) && ((Y_Bullet1 + Bullet_Size) > Y1) && (Y_Bullet1 < (Y1 + H_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + neg_step_b) <= (X2 + V_Width)) && ((Y_Bullet1 + Bullet_Size) > Y2) && (Y_Bullet1 < (Y2 + V_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + neg_step_b) <= (X3 + H_Width)) && ((Y_Bullet1 + Bullet_Size) > Y3) && (Y_Bullet1 < (Y3 + H_Height)) )
						hit1 = 2'b00;
					else if ( ((X_Bullet1 + neg_step_b) <= (X4 + V_Width)) && ((Y_Bullet1 + Bullet_Size) > Y4) && (Y_Bullet1 < (Y4 + V_Height)) )
						hit1 = 2'b00;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y1) && ((X_Bullet1 + Bullet_Size) > X1) && (X_Bullet1 < (X1 + H_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y2) && ((X_Bullet1 + Bullet_Size) > X2) && (X_Bullet1 < (X2 + V_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y3) && ((X_Bullet1 + Bullet_Size) > X3) && (X_Bullet1 < (X3 + H_Width)) )
						hit1 = 2'b00;
					else if ( ((Y_Bullet1 + Bullet_Size + step_b) >= Y4) && ((X_Bullet1 + Bullet_Size) > X4) && (X_Bullet1 < (X4 + V_Width)) )
						hit1 = 2'b00;
				end
				default:
					hit1 = 2'b01;
			endcase 
			
			unique case(bullet_dir2) 
				3'd1: begin	// moving up
					if ( ((Y_Bullet2 + neg_step_b) <= (Y1 + H_Height)) && ((X_Bullet2 + Bullet_Size) > X1) && (X_Bullet2 < (X1 + H_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y2 + V_Height)) && ((X_Bullet2 + Bullet_Size) > X2) && (X_Bullet2 < (X2 + V_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y3 + H_Height)) && ((X_Bullet2 + Bullet_Size) > X3) && (X_Bullet2 < (X3 + H_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + neg_step_b) <= (Y4 + V_Height)) && ((X_Bullet2 + Bullet_Size) > X4) && (X_Bullet2 < (X4 + V_Width)) )
						hit2 = 2'b00;
				end
				3'd2: begin	// moving right
					if ( ((X_Bullet2 + Bullet_Size + step_b) >= X1) && ((Y_Bullet2 + Bullet_Size) > Y1) && (Y_Bullet2 < (Y1 + H_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X2) && ((Y_Bullet2 + Bullet_Size) > Y2) && (Y_Bullet2 < (Y2 + V_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X3) && ((Y_Bullet2 + Bullet_Size) > Y3) && (Y_Bullet2 < (Y3 + H_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + Bullet_Size + step_b) >= X4) && ((Y_Bullet2 + Bullet_Size) > Y4) && (Y_Bullet2 < (Y4 + V_Height)) )
						hit2 = 2'b00;
				end
				3'd3: begin	// moving left
					if ( ((X_Bullet2 + neg_step_b) <= (X1 + H_Width)) && ((Y_Bullet2 + Bullet_Size) > Y1) && (Y_Bullet2 < (Y1 + H_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + neg_step_b) <= (X2 + V_Width)) && ((Y_Bullet2 + Bullet_Size) > Y2) && (Y_Bullet2 < (Y2 + V_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + neg_step_b) <= (X3 + H_Width)) && ((Y_Bullet2 + Bullet_Size) > Y3) && (Y_Bullet2 < (Y3 + H_Height)) )
						hit2 = 2'b00;
					else if ( ((X_Bullet2 + neg_step_b) <= (X4 + V_Width)) && ((Y_Bullet2 + Bullet_Size) > Y4) && (Y_Bullet2 < (Y4 + V_Height)) )
						hit2 = 2'b00;
				end	
				3'd4: begin	// moving down
					if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y1) && ((X_Bullet2 + Bullet_Size) > X1) && (X_Bullet2 < (X1 + H_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y2) && ((X_Bullet2 + Bullet_Size) > X2) && (X_Bullet2 < (X2 + V_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y3) && ((X_Bullet2 + Bullet_Size) > X3) && (X_Bullet2 < (X3 + H_Width)) )
						hit2 = 2'b00;
					else if ( ((Y_Bullet2 + Bullet_Size + step_b) >= Y4) && ((X_Bullet2 + Bullet_Size) > X4) && (X_Bullet2 < (X4 + V_Width)) )
						hit2 = 2'b00;
				end
				default:
					hit2 = 2'b01;
			endcase
				
		end
			

//			//Bullet collisions with tanks
//			if (X_Bullet <= X_Tank + Tank_Width) begin
//			  hit = 2'b10;
//			  tank_hit = 1'b1;
//			end
//
//			else if (X_Bullet + Bullet_Width >= X_Tank) begin
//			  hit = 2'b10;
//			  tank_hit = 1'b1;
//			end
//
//			else if (Y_Bullet <= Y_Tank + Tank_Height) begin
//			  hit = 2'b10;
//			  tank_hit = 1'b1;
//			end
//
//			else if (Y_Bullet + Bullet_Height >= Y_Tank) begin
//			  hit = 2'b10;
//			  tank_hit = 1'b1;
//		end
endmodule 