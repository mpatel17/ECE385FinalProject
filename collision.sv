module collision (input [9:0] X1, X2, X3, X4, Y1, Y2, Y3, Y4, //Walls
                  input [9:0] V_Width, V_Height, H_Width, H_Height, //Wall dimensions
                  input [9:0] X_Tank, Y_Tank, //Tanks
                  input [9:0] Tank_Width, Tank_Height, //Tank dimensions
                  input [9:0] X_Bullet, Y_Bullet, //Bullets
                  input [1:0] hit,
                  input [9:0] Bullet_Width, Bullet_Height  //Bullet dimensions
                  );

                  //Tank collisions with walls
                  if (X_Tank <= X1 + H_Width) begin
                    X_Motion_in = X_Step;
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank <= X2 + V_Width) begin
                    X_Motion_in = X_Step;
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank <= X3 + H_Width) begin
                    X_Motion_in = X_Step;
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank <= X4 + V_Width) begin
                    X_Motion_in = X_Step;
                    Y_Motion_in = 10'd0;
                  end

                  else if (X_Tank + Tank_Width >= X1) begin
                    X_Motion_in = (~(X_Step) + 10'd1);
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank + Tank_Width >= X2) begin
                    X_Motion_in = (~(X_Step) + 10'd1);
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank + Tank_Width >= X3) begin
                    X_Motion_in = (~(X_Step) + 10'd1);
                    Y_Motion_in = 10'd0;
                  end
                  else if (X_Tank + Tank_Width >= X4) begin
                    X_Motion_in = (~(X_Step) + 10'd1);
                    Y_Motion_in = 10'd0;
                  end

                  else if (Y_Tank <= Y1 + H_Height) begin
                    Y_Motion_in = Y_Step;
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank <= Y2 + V_Height) begin
                    Y_Motion_in = Y_Step;
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank <= Y3 + H_Height) begin
                    Y_Motion_in = Y_Step;
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank <= Y4 + V_Height) begin
                    Y_Motion_in = Y_Step;
                    X_Motion_in = 10'd0;
                  end

                  else if (Y_Tank + Tank_Height >= Y1) begin
                    Y_Motion_in = (~(Y_Step) + 10'd1);
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank + Tank_Height >= Y2) begin
                    Y_Motion_in = (~(Y_Step) + 10'd1);
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank + Tank_Height >= Y3) begin
                    Y_Motion_in = (~(Y_Step) + 10'd1);
                    X_Motion_in = 10'd0;
                  end
                  else if (Y_Tank + Tank_Height >= Y4) begin
                    Y_Motion_in = (~(Y_Step) + 10'd1);
                    X_Motion_in = 10'd0;
                  end

                  //Bullet collisions with walls
                  if (X_Bullet <= X1 + H_Width) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet <= X2 + V_Width) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet <= X3 + H_Width) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet <= X4 + V_Width) begin
                    hit = 2'b10;
                  end

                  else if (X_Bullet + Bullet_Width >= X1) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet + Bullet_Width >= X2) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet + Bullet_Width >= X3) begin
                    hit = 2'b10;
                  end
                  else if (X_Bullet + Bullet_Width >= X4) begin
                    hit = 2'b10;
                  end

                  else if (Y_Bullet <= Y1 + H_Height) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet <= Y2 + V_Height) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet <= Y3 + H_Height) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet <= Y4 + V_Height) begin
                    hit = 2'b10;
                  end

                  else if (Y_Bullet + Bullet_Height >= Y1) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet + Bullet_Height >= Y2) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet + Bullet_Height >= Y3) begin
                    hit = 2'b10;
                  end
                  else if (Y_Bullet + Bullet_Height >= Y4) begin
                    hit = 2'b10;
                  end

                  //Bullet collisions with tanks
                  if (X_Bullet <= X_Tank + Tank_Width) begin
                    hit = 2'b10;
                    tank_hit = 1'b1;
                  end

                  else if (X_Bullet + Bullet_Width >= X_Tank) begin
                    hit = 2'b10;
                    tank_hit = 1'b1;
                  end

                  else if (Y_Bullet <= Y_Tank + Tank_Height) begin
                    hit = 2'b10;
                    tank_hit = 1'b1;
                  end

                  else if (Y_Bullet + Bullet_Height >= Y_Tank) begin
                    hit = 2'b10;
                    tank_hit = 1'b1;
                  end
