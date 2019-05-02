module  wall (	input 	Clk,                // 50 MHz clock
								Reset,              // Active-high reset signal
								frame_clk,          // The clock indicating a new frame (~60Hz)
					input [9:0]   DrawX, DrawY, // Current pixel coordinates
					output  is_wall1, is_wall2, is_wall3, is_wall4,    // Whether current pixel belongs to wall
					output [9:0] X1, X2, X3, X4, Y1, Y2, Y3, Y4
					);

		parameter [9:0] X_Min = 10'd0;       // Leftmost point on the X axis
	   parameter [9:0] X_Max = 10'd639;     // Rightmost point on the X axis
	   parameter [9:0] Y_Min = 10'd0;       // Topmost point on the Y axis
	   parameter [9:0] Y_Max = 10'd479;     // Bottommost point on the Y axis
		parameter [9:0] Vert_Width = 10'd32;
		parameter [9:0] Vert_Height = 10'd64;
		parameter [9:0] Hor_Width = 10'd64;
		parameter [9:0] Hor_Height = 10'd32;
		
//		logic [9:0] X1_in, Y1_in, X2_in, Y2_in, X3_in, Y3_in, X4_in, Y4_in;

		always_comb begin
			X1 = 10'd150;
			Y1 = 10'd150;
			X2 = 10'd200;
			Y2 = 10'd250;
			X3 = 10'd450;
			Y3 = 10'd300;
			X4 = 10'd400;
			Y4 = 10'd100;
		end
		
//		wall_location wallX1(.wall(1'b0), .location(X4), .location2(X1_in)
//									);
//		wall_location wallY1(.wall(1'b1), .location(Y4), .location2(Y1_in)
//									);
//		wall_location wallX2(.wall(1'b0), .location(X1), .location2(X2_in)
//									);
//		wall_location wallY2(.wall(1'b1), .location(Y1), .location2(Y2_in)
//									);
//		wall_location wallX3(.wall(1'b0), .location(X2), .location2(X3_in)
//									);
//		wall_location wallY3(.wall(1'b1), .location(Y2), .location2(Y3_in)
//									);
//		wall_location wallX4(.wall(1'b0), .location(X3), .location2(X4_in)
//									);
//		wall_location wallY4(.wall(1'b1), .location(Y3), .location2(Y4_in)
//									);
//		
//		always_ff @ (posedge Clk) begin
//			if(Reset) begin
//				X1 <= X1_in;
//				Y1 <= Y1_in;
//				X2 <= X2_in;
//				Y2 <= Y2_in;
//				X3 <= X3_in;
//				Y3 <= Y3_in;
//				X4 <= X4_in;
//				Y4 <= Y4_in;
//			end
//			else begin
//				X1 <= X1;
//				Y1 <= Y1;
//				X2 <= X2;
//				Y2 <= Y2;
//				X3 <= X3;
//				Y3 <= Y3;
//				X4 <= X4;
//				Y4 <= Y4;
//			end
//		end
				
		//Distance for each wall and horizontal and vertical dimensions
		int DistX1, DistX2, DistX3, DistX4, DistY1, DistY2, DistY3, DistY4, Wh, Hh, Wv, Hv;
	   assign DistX1 = DrawX - X1;
	   assign DistY1 = DrawY - Y1;
		assign DistX2 = DrawX - X2;
	   assign DistY2 = DrawY - Y2;
		assign DistX3 = DrawX - X3;
	   assign DistY3 = DrawY - Y3;
		assign DistX4 = DrawX - X4;
	   assign DistY4 = DrawY - Y4;
	   assign Wh = Hor_Width;
		assign Hh = Hor_Height;
		assign Wv = Vert_Width;
		assign Hv = Vert_Height;

	   always_comb begin		// vertical wall_1 1 & 3; horizontal wall_1_flip 2&4
			if ( DistX1 <= Wh && DistX1 >= 0 && DistY1 <= Hh && DistY1 >= 0)
				is_wall1 = 1'b1;
	      else
	         is_wall1 = 1'b0;
			if ( DistX2 <= Wv && DistX2 >= 0 && DistY2 <= Hv && DistY2 >= 0)
				is_wall2 = 1'b1;
			else
				is_wall2 = 1'b0;
			if ( DistX3 <= Wh && DistX3 >= 0 && DistY3 <= Hh && DistY3 >= 0)
				is_wall3 = 1'b1;
			else
				is_wall3 = 1'b0;
			if ( DistX4 <= Wv && DistX4 >= 0 && DistY4 <= Hv && DistY4 >= 0)
				is_wall4 = 1'b1;
			else
				is_wall4 = 1'b0;
	    end

endmodule
