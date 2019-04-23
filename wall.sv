module  wall (	input 	Clk,                // 50 MHz clock
												Reset,              // Active-high reset signal
												frame_clk,          // The clock indicating a new frame (~60Hz)
								input [9:0]   DrawX, DrawY, // Current pixel coordinates
								input 	num_walls,		//Tells how many walls should be set up
								output  is_wall1, is_wall2 is_wall3, is_wall4,      // Whether current pixel belongs to wall
								output [9:0] X1, X2, X3, X4, Y1, Y2, Y3, Y4;
							);

	  parameter [9:0] X_Min = 10'd0;       // Leftmost point on the X axis
	  parameter [9:0] X_Max = 10'd639;     // Rightmost point on the X axis
	  parameter [9:0] Y_Min = 10'd0;       // Topmost point on the Y axis
	  parameter [9:0] Y_Max = 10'd479;     // Bottommost point on the Y axis
		parameter [9:0] Vert_Width = 10'd32;
		parameter [9:0] Vert_Height = 10'd64;
		parameter [9:0] Hor_Width = 10'd64;
		parameter [9:0] Hor_Height = 10'd32;

		logic [9:0] X1, X2, X3, X4, Y1, Y2, Y3, Y4;
		logic [9:0] counter;

		always_ff @ (posedge Clk)
 	 	begin
 	 	if(counter < 10'd100)
 			counter = counter + 1'b1;
 	 	else
 			counter = 0;
 	 	end

		case(num_walls)
			1'b0: begin//One wall per direction
				X1 = (counter << (num_walls + 1)) % 10'd639;
				Y1 = (counter << (num_walls + 1)) % 10'd479;
				while (X1 != X2)
					X2 = (counter << (num_walls + 1)) % 10'd639;
				while (Y1 != Y2)
					Y2 = (counter << (num_walls + 1)) % 10'd479;

			1'b1: //Two walls per direction
				X1 = (counter << (num_walls + 1)) % 10'd639;
				Y1 = (counter << (num_walls + 1)) % 10'd479;
				while (X1 != X2)
					X2 = (counter << (num_walls + 1)) % 10'd639;
				while (Y1 != Y2)
					Y2 = (counter << (num_walls + 1)) % 10'd479;
				while (X1 != X3 && X2 != X3)
					X3 = (counter << (num_walls + 1)) % 10'd639;
				while (Y1 != Y3 && Y2 != Y3)
					Y3 = (counter << (num_walls + 1)) % 10'd479;
				while (X1 != X4 && X2 != X4 && X3 != X4)
					X4 = (counter << (num_walls + 1)) % 10'd639;
				while (Y1 != Y3 && Y2 != Y3 && Y3 != Y4)
					Y4 = (counter << (num_walls + 1)) % 10'd479;
			end

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

	    always_comb begin
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
