module collision (input [9:0] X1, Y1, X2, Y2, X3, Y3, X4, Y4, //Walls
                  input [9:0] X_Tank1, Y_Tank1, X_Tank2, Y_Tank2, //Tanks
                  input [2:0] tank_dir1, tank_dir2,
						output can_move1, can_move2
                  );
						
		parameter [9:0] step = 10'd1;
		parameter [9:0] neg_step = ~(step) + 1'b1;
		parameter [9:0] V_Width = 10'd32;
		parameter [9:0] V_Height = 10'd64;
		parameter [9:0] H_Width = 10'd64;
		parameter [9:0] H_Height = 10'd32;
		parameter [9:0] Tank_Width = 10'd32;
		parameter [9:0] Tank_Height = 10'd32;
		
		
		always_comb begin
		
			can_move1 = 1'b1;
			can_move2 = 1'b1;
		
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
				
//			// tank 2 wall 1 check
//			if(tank_dir2 == 3'd1 && Y_Tank2 == (Y1 + H_Height) && (X_Tank2 + Tank_Width) > X1 && X_Tank2 < (X1 + H_Width))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd2 && (X_Tank2 + Tank_Width) == X1 && (Y_Tank2 + Tank_Height) > Y1 && Y_Tank2 < (Y1 + H_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd3 && X_Tank2 == (X1 + H_Width) && (Y_Tank2 + Tank_Height) > Y1 && Y_Tank2 < (Y1 + H_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd4 && (Y_Tank2 + Tank_Height) == Y1 && (X_Tank2 + Tank_Width) > X1 && X_Tank2 < (X1 + H_Width))
//				can_move2 = 1'b0;
//			// tank 2 wall 2 check
//			if(tank_dir2 == 3'd1 && Y_Tank2 == (Y2 + V_Height) && (X_Tank2 + Tank_Width) > X2 && X_Tank2 < (X2 + V_Width))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd2 && (X_Tank2 + Tank_Width) == X2 && (Y_Tank2 + Tank_Height) > Y2 && Y_Tank2 < (Y2 + V_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd3 && X_Tank2 == (X2 + V_Width) && (Y_Tank2 + Tank_Height) > Y2 && Y_Tank2 < (Y2 + V_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd4 && (Y_Tank2 + Tank_Height) == Y2 && (X_Tank2 + Tank_Width) > X2 && X_Tank2 < (X2 + V_Width))
//				can_move2 = 1'b0;
//			// tank 2 wall 3 check
//			if(tank_dir2 == 3'd1 && Y_Tank2 == (Y3 + H_Height) && (X_Tank2 + Tank_Width) > X1 && X_Tank2 < (X3 + H_Width))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd2 && (X_Tank2 + Tank_Width) == X3 && (Y_Tank2 + Tank_Height) > Y3 && Y_Tank2 < (Y3 + H_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd3 && X_Tank2 == (X3 + H_Width) && (Y_Tank2 + Tank_Height) > Y3 && Y_Tank2 < (Y3 + H_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd4 && (Y_Tank2 + Tank_Height) == Y3 && (X_Tank2 + Tank_Width) > X3 && X_Tank2 < (X3 + H_Width))
//				can_move2 = 1'b0;
//			// tank 2 wall 4 check
//			if(tank_dir2 == 3'd1 && Y_Tank2 == (Y4 + V_Height) && (X_Tank2 + Tank_Width) > X4 && X_Tank2 < (X4 + V_Width))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd2 && (X_Tank2 + Tank_Width) == X4 && (Y_Tank2 + Tank_Height) > Y4 && Y_Tank2 < (Y4 + V_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd3 && X_Tank2 == (X4 + V_Width) && (Y_Tank2 + Tank_Height) > Y4 && Y_Tank2 < (Y4 + V_Height))
//				can_move2 = 1'b0;
//			else if(tank_dir2 == 3'd4 && (Y_Tank2 + Tank_Height) == Y4 && (X_Tank2 + Tank_Width) > X4 && X_Tank2 < (X4 + V_Width))
//				can_move2 = 1'b0;
			

//			if (X_Tank <= X1 + H_Width) begin
//			  X_Motion_in = X_Step;
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank <= X2 + V_Width) begin
//			  X_Motion_in = X_Step;
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank <= X3 + H_Width) begin
//			  X_Motion_in = X_Step;
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank <= X4 + V_Width) begin
//			  X_Motion_in = X_Step;
//			  Y_Motion_in = 10'd0;
//			end
//
//			else if (X_Tank + Tank_Width >= X1) begin
//			  X_Motion_in = (~(X_Step) + 10'd1);
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank + Tank_Width >= X2) begin
//			  X_Motion_in = (~(X_Step) + 10'd1);
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank + Tank_Width >= X3) begin
//			  X_Motion_in = (~(X_Step) + 10'd1);
//			  Y_Motion_in = 10'd0;
//			end
//			else if (X_Tank + Tank_Width >= X4) begin
//			  X_Motion_in = (~(X_Step) + 10'd1);
//			  Y_Motion_in = 10'd0;
//			end
//
//			else if (Y_Tank <= Y1 + H_Height) begin
//			  Y_Motion_in = Y_Step;
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank <= Y2 + V_Height) begin
//			  Y_Motion_in = Y_Step;
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank <= Y3 + H_Height) begin
//			  Y_Motion_in = Y_Step;
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank <= Y4 + V_Height) begin
//			  Y_Motion_in = Y_Step;
//			  X_Motion_in = 10'd0;
//			end
//
//			else if (Y_Tank + Tank_Height >= Y1) begin
//			  Y_Motion_in = (~(Y_Step) + 10'd1);
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank + Tank_Height >= Y2) begin
//			  Y_Motion_in = (~(Y_Step) + 10'd1);
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank + Tank_Height >= Y3) begin
//			  Y_Motion_in = (~(Y_Step) + 10'd1);
//			  X_Motion_in = 10'd0;
//			end
//			else if (Y_Tank + Tank_Height >= Y4) begin
//			  Y_Motion_in = (~(Y_Step) + 10'd1);
//			  X_Motion_in = 10'd0;
//			end
//Bullet collisions with walls
//                  if (X_Bullet <= X1 + H_Width) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet <= X2 + V_Width) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet <= X3 + H_Width) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet <= X4 + V_Width) begin
//                    hit = 2'b10;
//                  end
//
//                  else if (X_Bullet + Bullet_Width >= X1) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet + Bullet_Width >= X2) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet + Bullet_Width >= X3) begin
//                    hit = 2'b10;
//                  end
//                  else if (X_Bullet + Bullet_Width >= X4) begin
//                    hit = 2'b10;
//                  end
//
//                  else if (Y_Bullet <= Y1 + H_Height) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet <= Y2 + V_Height) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet <= Y3 + H_Height) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet <= Y4 + V_Height) begin
//                    hit = 2'b10;
//                  end
//
//                  else if (Y_Bullet + Bullet_Height >= Y1) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet + Bullet_Height >= Y2) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet + Bullet_Height >= Y3) begin
//                    hit = 2'b10;
//                  end
//                  else if (Y_Bullet + Bullet_Height >= Y4) begin
//                    hit = 2'b10;
//                  end
//
//                  //Bullet collisions with tanks
//                  if (X_Bullet <= X_Tank + Tank_Width) begin
//                    hit = 2'b10;
//                    tank_hit = 1'b1;
//                  end
//
//                  else if (X_Bullet + Bullet_Width >= X_Tank) begin
//                    hit = 2'b10;
//                    tank_hit = 1'b1;
//                  end
//
//                  else if (Y_Bullet <= Y_Tank + Tank_Height) begin
//                    hit = 2'b10;
//                    tank_hit = 1'b1;
//                  end
//
//                  else if (Y_Bullet + Bullet_Height >= Y_Tank) begin
//                    hit = 2'b10;
//                    tank_hit = 1'b1;
		end
endmodule 