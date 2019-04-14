module  tank ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               output logic  is_tank,            // Whether current pixel belongs to ball or background
					output logic [9:0] tank_X, tank_Y,
					input logic [7:0] keycode			 // key that is being pressed
              );

	 parameter [9:0] X_Start = 10'd500;
	 parameter [9:0] Y_Start = 10'd240;
    parameter [9:0] X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Y_Step = 10'd1;      // Step size on the Y axis
	 parameter [9:0] Width = 10'd50;
	 parameter [9:0] Height = 10'd50;

    logic [9:0] X_Pos, X_Motion, Y_Pos, Y_Motion;
    logic [9:0] X_Pos_in, X_Motion_in, Y_Pos_in, Y_Motion_in;

	 initial begin
		X_Pos_in = X_Start;
		X_Pos = X_Start;
		X_Motion_in = 10'd0;
		X_Motion = 10'd0;
		Y_Pos_in = Y_Start;
		Y_Pos = Y_Start;
		Y_Motion_in = 10'd0;
		Y_Motion = 10'd0;
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
            X_Motion <= 10'd0;
            Y_Motion <= 10'd0;
        end
        else
        begin
            X_Pos <= X_Pos_in;
            Y_Pos <= Y_Pos_in;
            X_Motion <= X_Motion_in;
            Y_Motion <= Y_Motion_in;
        end
    end
  
	 always_comb
    begin
        // By default, keep motion and position unchanged
        X_Pos_in = X_Pos;
        Y_Pos_in = Y_Pos;
        X_Motion_in = X_Motion;
        Y_Motion_in = Y_Motion;

        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  
			  // check current motion and whether key is pressed to determine what to set X/Y_Motion to
				if( keycode == 8'h1A ) begin	// 'W'
					Y_Motion_in = (~(Y_Step) + 1'b1);
					X_Motion_in = 1'b0;
				end
				else if( keycode == 8'h16 )	begin // 'S'
					Y_Motion_in = Y_Step;
					X_Motion_in = 1'b0;
				end
				else if( keycode == 8'h04 )	begin // 'A'
					X_Motion_in = (~(X_Step) + 1'b1);
					Y_Motion_in = 1'b0;
				end
				else if( keycode == 8'h07 )	begin // 'D'
					X_Motion_in = X_Step;
					Y_Motion_in = 1'b0;
				end
				else begin
					X_Motion_in = 1'b0;
					Y_Motion_in = 1'b0;
				end
            // Be careful when using comparators with "logic" datatype because compiler treats
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Y_Pos - Ball_Size <= Y_Min
            // If Y_Pos is 0, then Y_Pos - Ball_Size will not be -4, but rather a large positive number.
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
				
            // Update the ball's position with its motion
				X_Pos_in = X_Pos + X_Motion;
				Y_Pos_in = Y_Pos + Y_Motion;
        end

end

	 assign tank_X = X_Pos;
	 assign tank_Y = Y_Pos;
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, W, H;
    assign DistX = DrawX - X_Pos;
    assign DistY = DrawY - Y_Pos;
    assign W = Width;
	 assign H = Height;
    always_comb begin
        if ( DistX <= W && DistY <= H )
            is_tank = 1'b1;
        else
            is_tank = 1'b0;

    end

endmodule
