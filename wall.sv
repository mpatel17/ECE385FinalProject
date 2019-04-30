module  wall (	input 	Clk,                // 50 MHz clock
								Reset,              // Active-high reset signal
								frame_clk,          // The clock indicating a new frame (~60Hz)
					input [9:0]   DrawX, DrawY, // Current pixel coordinates
//					input 	num_walls,		//Tells how many walls should be set up
					output  is_wall1, is_wall2, is_wall3, is_wall4, is_any_wall,     // Whether current pixel belongs to wall
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

		logic [9:0] counter;
		
		assign is_any_wall = is_wall1 || is_wall2 || is_wall3 || is_wall4;

		assign X1 = 10'd50;
		assign Y1 = 10'd100;
		assign X2 = 10'd400;
		assign Y2 = 10'd200;
		assign X3 = 10'd320;
		assign Y3 = 10'd240;
		assign X4 = 10'd600;
		assign Y4 = 10'd400;
				
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


//module  wall (	input 	Clk,                // 50 MHz clock
//								Reset,              // Active-high reset signal
//					input [9:0]   DrawX, DrawY, // Current pixel coordinates
//					input [9:0]		SW,
//					output  is_wall1, is_wall2, is_wall3, is_wall4,    // Whether current pixel belongs to wall
//					output [9:0] X1, X2, X3, X4, Y1, Y2, Y3, Y4
//					);
//
//		parameter [9:0] Vert_Width = 10'd32;
//		parameter [9:0] Vert_Height = 10'd64;
//		parameter [9:0] Hor_Width = 10'd64;
//		parameter [9:0] Hor_Height = 10'd32;
//
//		wall_location wallX1(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b0), .location(SW), .location2(X1)
//												);
//		wall_location wallY1(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b1), .location(SW), .location2(Y1)
//												);
//		wall_location wallX2(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b0), .location(X1), .location2(X2)
//												);
//		wall_location wallY2(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b1), .location(Y1), .location2(Y2)
//												);
//		wall_location wallX3(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b0), .location(X2), .location2(X3)
//												);
//		wall_location wallY3(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b1), .location(Y2), .location2(Y3)
//												);
//		wall_location wallX4(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b0), .location(X3), .location2(X4)
//												);
//		wall_location wallY4(.Clk(Clk), .Reset(Reset),
//												.Wall(1'b1), .location(Y3), .location2(Y4)
//												);
//
//		// assign X1 = 10'd10;
//		// assign Y1 = 10'd20;
//		// assign X2 = 10'd400;
//		// assign Y2 = 10'd200;
//		// assign X3 = 10'd320;
//		// assign Y3 = 10'd240;
//		// assign X4 = 10'd600;
//		// assign Y4 = 10'd400;
//
//		//Distance for each wall and horizontal and vertical dimensions
//		int DistX1, DistX2, DistX3, DistX4, DistY1, DistY2, DistY3, DistY4, Wh, Hh, Wv, Hv;
//	   assign DistX1 = DrawX - X1;
//	   assign DistY1 = DrawY - Y1;
//		assign DistX2 = DrawX - X2;
//	   assign DistY2 = DrawY - Y2;
//		assign DistX3 = DrawX - X3;
//	   assign DistY3 = DrawY - Y3;
//		assign DistX4 = DrawX - X4;
//	   assign DistY4 = DrawY - Y4;
//	   assign Wh = Hor_Width;
//		assign Hh = Hor_Height;
//		assign Wv = Vert_Width;
//		assign Hv = Vert_Height;
//
//	   always_comb begin		// vertical wall_1 1 & 3; horizontal wall_1_flip 2&4
//			if ( DistX1 <= Wh && DistX1 >= 0 && DistY1 <= Hh && DistY1 >= 0)
//				is_wall1 = 1'b1;
//	      else
//	         is_wall1 = 1'b0;
//			if ( DistX2 <= Wv && DistX2 >= 0 && DistY2 <= Hv && DistY2 >= 0)
//				is_wall2 = 1'b1;
//			else
//				is_wall2 = 1'b0;
//			if ( DistX3 <= Wh && DistX3 >= 0 && DistY3 <= Hh && DistY3 >= 0)
//				is_wall3 = 1'b1;
//			else
//				is_wall3 = 1'b0;
//			if ( DistX4 <= Wv && DistX4 >= 0 && DistY4 <= Hv && DistY4 >= 0)
//				is_wall4 = 1'b1;
//			else
//				is_wall4 = 1'b0;
//	    end
//
//endmodule