module  tank_key ( input         Clk,                // 50 MHz clock
										  Reset,              // Active-high reset signal
										  frame_clk,          // The clock indicating a new frame (~60Hz)
						input 		  player,
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						output logic  is_tank, is_bullet,
						output logic [2:0] tank_dir, bullet_dir,
						output logic [9:0] tank_X, tank_Y, saveX, saveY,
						output logic [1:0] hit,
						output logic [9:0] bullet_X, bullet_Y,
						input logic [7:0] keycode,			 // key that is being pressed
						input logic can_move
					  );

	 if(player == 1'b0) begin
		 parameter X_Start [9:0] = 10'd100;
		 parameter Y_Start [9:0] = 10'd240;
	 end
	 else if(player == 1'b1) begin
		 parameter X_Start [9:0] = 10'd540;
		 parameter Y_Start [9:0] = 10'd240;
	 end
    parameter [9:0] X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Y_Step = 10'd1;      // Step size on the Y axis
	 parameter [9:0] Bullet_Step = 10'd5;
	 parameter [9:0] Width = 10'd32;
	 parameter [9:0] Height = 10'd32;
	 parameter [9:0] Bullet_Width = 10'd8;
	 parameter [9:0] Bullet_Height = 10'd8;

    logic [9:0] X_Pos, X_Motion, Y_Pos, Y_Motion;
    logic [9:0] X_Pos_in, X_Motion_in, Y_Pos_in, Y_Motion_in, saveX_in, saveY_in;
	 logic [9:0] X_Bullet_in, Y_Bullet_in, X_Bullet, Y_Bullet;
	 logic [9:0] X_Bullet_Mot_In, X_Bullet_Mot, Y_Bullet_Mot_In, Y_Bullet_Mot;
	 logic [2:0] tank_dir_in, bullet_dir_in;
	 logic [1:0] hit_in;

	 initial begin
		X_Pos_in = X_Start;
		X_Pos = X_Start;
		Y_Pos_in = Y_Start;
		Y_Pos = Y_Start;
		X_Motion_in = 10'd0;
		X_Motion = 10'd0;
		Y_Motion_in = 10'd0;
		Y_Motion = 10'd0;
		X_Bullet_in = 10'd0;
		Y_Bullet_in = 10'd0;
		X_Bullet = 10'd0;
		Y_Bullet = 10'd0;
		X_Bullet_Mot_In = 10'd0;
		Y_Bullet_Mot_In = 10'd0;
		X_Bullet_Mot = 10'd0;
		Y_Bullet_Mot = 10'd0;
		tank_dir = 3'd1;
		tank_dir_in = 3'd1;
		bullet_dir = 3'd1;
		bullet_dir_in = 3'd1;
		hit = 2'b00;
		hit_in = 2'b00;	//00 = no bullet on screen, 01 = bullet on screen, 10 = bullet hit wall
	 end
	 
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            X_Pos <= X_Start;
            Y_Pos <= Y_Start;
				saveX <= X_Start;
				saveY <= Y_Start;
            X_Motion <= 10'd0;
            Y_Motion <= 10'd0;
				X_Bullet <= 10'd0;
				Y_Bullet <= 10'd0;
				X_Bullet_Mot <= 10'd0;
				Y_Bullet_Mot <= 10'd0;
				tank_dir <= 3'd1;
				hit <= 2'b00;	//No bullet on screen
				bullet_dir <= 3'd1;
        end
        else
        begin
            X_Pos <= X_Pos_in;
            Y_Pos <= Y_Pos_in;
				saveX <= saveX_in;
				saveY <= saveY_in;
            X_Motion <= X_Motion_in;
            Y_Motion <= Y_Motion_in;
				X_Bullet <= X_Bullet_in;
				Y_Bullet <= Y_Bullet_in;
				X_Bullet_Mot <= X_Bullet_Mot_In;
				Y_Bullet_Mot <= Y_Bullet_Mot_In;
				tank_dir <= tank_dir_in;
				bullet_dir <= bullet_dir_in;
				hit <= hit_in;
        end
    end
  
	 always_comb
    begin
        // By default, keep motion and position unchanged and not shooting
        X_Pos_in = X_Pos;
        Y_Pos_in = Y_Pos;
		  saveX_in = saveX;
		  saveY_in = saveY;
        X_Motion_in = X_Motion;
        Y_Motion_in = Y_Motion;
		  tank_dir_in = tank_dir;
		  bullet_dir_in = bullet_dir;
		  X_Bullet_in = X_Bullet;
		  Y_Bullet_in = Y_Bullet;
		  X_Bullet_Mot_In = X_Bullet_Mot;
		  Y_Bullet_Mot_In = Y_Bullet_Mot;
		  hit_in = hit;

        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  			
			  // check current motion and whether key is pressed to determine what to set X/Y_Motion to
				if( keycode == 8'h1A || keycode == 8'h52 ) begin	// 'W' or up
					Y_Motion_in = (~(Y_Step) + 1'b1);
					X_Motion_in = 1'b0;
					tank_dir_in = 3'd1;
				end
				else if( keycode == 8'h16 || keycode == 8'h51 )	begin // 'S' or down
					Y_Motion_in = Y_Step;
					X_Motion_in = 1'b0;
					tank_dir_in = 3'd4;
				end
				else if( keycode == 8'h04 || keycode == 8'h50 )	begin // 'A' or left
					X_Motion_in = (~(X_Step) + 1'b1);
					Y_Motion_in = 1'b0;
					tank_dir_in = 3'd3;
				end
				else if( keycode == 8'h07 || keycode == 8'h4f )	begin // 'D' or right
					X_Motion_in = X_Step;
					Y_Motion_in = 1'b0;
					tank_dir_in = 3'd2;
				end
				else begin
					X_Motion_in = 1'b0;
					Y_Motion_in = 1'b0;
				end
				
				if( (keycode == 8'h2c || keycode == 8'h28) && hit == 2'b00) begin // 'Enter'
				  X_Motion_in = X_Motion; //Keeps track of previous x motion, so tank can keep moving in that direction
				  Y_Motion_in = Y_Motion; //Keeps track of previous y motion, so tank can keep moving in that direction
				  saveX_in = X_Pos;
				  saveY_in = Y_Pos;
				  hit_in = 2'b01;
				  case (tank_dir)
						3'd1:
						begin
							bullet_dir_in = 3'd1;
							X_Bullet_in = X_Pos + 9'h10; //Bullet comes out of top center
							Y_Bullet_in = Y_Pos; //Bullet comes out of top center
							X_Bullet_Mot_In = 1'b0;
							Y_Bullet_Mot_In = (~(Bullet_Step) + 1'b1);
						end
						3'd2:
						begin
							bullet_dir_in = 3'd2;
							X_Bullet_in = X_Pos + 9'h20; //Bullet comes out of right center
							Y_Bullet_in = Y_Pos + 9'h10; //Bullet comes out of right center
							X_Bullet_Mot_In = Bullet_Step;
							Y_Bullet_Mot_In = 1'b0;
						end
						3'd3:
						begin
							bullet_dir_in = 3'd3;
							X_Bullet_in = X_Pos; //Bullet comes out of left center
							Y_Bullet_in = Y_Pos + 9'h10; //Bullet comes out of left center
							X_Bullet_Mot_In = (~(Bullet_Step) + 1'b1);
							Y_Bullet_Mot_In = 1'b0;
						end
						3'd4:
						begin
							bullet_dir_in = 3'd4;
							X_Bullet_in = X_Pos + 9'h10; //Bullet comes out of bottom center
							Y_Bullet_in = Y_Pos + 9'h20; //Bullet comes out of bottom center
							X_Bullet_Mot_In = 1'b0;
							Y_Bullet_Mot_In = Bullet_Step;
						end
						default: ;
				  endcase
				end
				else begin
					X_Bullet_in = X_Bullet + X_Bullet_Mot;	//Bullet will come out of appropriate direction
					Y_Bullet_in = Y_Bullet + Y_Bullet_Mot; //Bullet will come out of appropriate direction
				end
				

            if( Y_Pos + Height >= Y_Max ) begin // Ball is at the bottom edge, BOUNCE!
                Y_Motion_in = (~(Y_Step) + 1'b1); // 2's complement.
					 X_Motion_in = 1'b0; 
				end
            else if ( Y_Pos <= Y_Min ) begin  // Ball is at the top edge, BOUNCE!
                Y_Motion_in = Y_Step;
					 X_Motion_in = 1'b0;
				end
            if( X_Pos + Width >= X_Max ) begin // Ball is at the right edge, BOUNCE!
                X_Motion_in = (~(X_Step) + 1'b1);  // 2's complement.
					 Y_Motion_in = 1'b0;
				end
            else if ( X_Pos <= X_Min ) begin // Ball is at the left edge, BOUNCE!
                X_Motion_in = X_Step;     
					 Y_Motion_in = 1'b0;
				end
				
				if( ~can_move ) begin
					case(tank_dir) 
						3'd4: begin
							Y_Motion_in = (~(Y_Step) + 1'b1); // 2's complement.
							X_Motion_in = 1'b0; 
						end
						3'd1: begin
							Y_Motion_in = Y_Step;
							X_Motion_in = 1'b0;
						end
						3'd2: begin
							X_Motion_in = (~(X_Step) + 1'b1);  // 2's complement.
							Y_Motion_in = 1'b0;
						end
						3'd3: begin
							X_Motion_in = X_Step;     
							Y_Motion_in = 1'b0;
						end
						default: ;
					endcase
				end
				
				if( Y_Bullet + Bullet_Height >= Y_Max )  begin
					hit_in = 2'b00;
					X_Bullet_Mot_In = 1'b0;
					Y_Bullet_Mot_In = 1'b0;
				end
				else if ( Y_Bullet <= Y_Min )  begin
					hit_in = 2'b00;
					X_Bullet_Mot_In = 1'b0;
					Y_Bullet_Mot_In = 1'b0;
				end
				else if( X_Bullet + Bullet_Width >= X_Max )  begin
					hit_in = 2'b00;
					X_Bullet_Mot_In = 1'b0;
					Y_Bullet_Mot_In = 1'b0;
				end
				else if ( X_Bullet <= X_Min ) begin
					hit_in = 2'b00;
					X_Bullet_Mot_In = 1'b0;
					Y_Bullet_Mot_In = 1'b0;
				end
				
				X_Pos_in = X_Pos + X_Motion;
				Y_Pos_in = Y_Pos + Y_Motion;
        end

	 end
	 
	 assign tank_X = X_Pos;
	 assign tank_Y = Y_Pos; 
	 assign bullet_X = X_Bullet;
	 assign bullet_Y = Y_Bullet;
	 
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, W, H, DistXB, DistYB, Wb, Hb;
    assign DistX = DrawX - X_Pos;
    assign DistY = DrawY - Y_Pos;
	 assign DistXB = DrawX - X_Bullet;
	 assign DistYB = DrawY - Y_Bullet;
    assign W = Width;
	 assign H = Height;
	 assign Wb = Bullet_Width;
	 assign Hb = Bullet_Height;
    always_comb begin
        if ( DistX <= W && DistX >= 0 && DistY <= H && DistY >= 0)
            is_tank = 1'b1;
        else
            is_tank = 1'b0;
				
		  if ( DistXB <= Wb && DistXB >= 0 && DistYB <= Hb && DistYB >= 0)
				is_bullet = 1'b1;
		  else
				is_bullet = 1'b0;
	 end

endmodule
