module tank_ai ( input         Clk,                // 50 MHz clock
										  Reset,              // Active-high reset signal
										  frame_clk,          // The clock indicating a new frame (~60Hz)
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						output logic  is_tank,       		// Whether current pixel belongs to tank or background
						output logic [2:0] tank_dir,
						output logic  is_shooting,	 		//Whether enter is pressed and tank is shooting
						output logic [9:0] tank_X, tank_Y
						);

	parameter [9:0] X_Start = 10'd100;
	parameter [9:0] Y_Start = 10'd380;
   parameter [9:0] X_Min = 10'd0;       // Leftmost point on the X axis
   parameter [9:0] X_Max = 10'd639;     // Rightmost point on the X axis
   parameter [9:0] Y_Min = 10'd0;       // Topmost point on the Y axis
   parameter [9:0] Y_Max = 10'd479;     // Bottommost point on the Y axis
   parameter [9:0] X_Step = 10'd1;      // Step size on the X axis
   parameter [9:0] Y_Step = 10'd1;      // Step size on the Y axis
	parameter [9:0] Width = 10'd32;
	parameter [9:0] Height = 10'd32;

	logic [9:0] X_Pos, X_Motion, Y_Pos, Y_Motion;
   logic [9:0] X_Pos_in, X_Motion_in, Y_Pos_in, Y_Motion_in;
	logic [2:0] tank_dir_in;
	logic [7:0] count, next_count;
	
	enum logic [2:0] {UP, RIGHT, DOWN, LEFT} State, Next_state;
	
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
	 
	 always_ff @ (posedge Clk)
	 begin
		if(Reset) begin
			State <= UP;
			X_Pos <= X_Start;
			Y_Pos <= Y_Start;
			count <= 8'h00;
		end
		else begin
			State <= Next_state;
			X_Pos <= X_Pos_in;
			Y_Pos <= Y_Pos_in;
			count <= next_count;
		end
	end
	
	always_comb begin
		Next_state = State;
		X_Pos_in = X_Pos;
		Y_Pos_in = Y_Pos;
		next_count = 8'h00;
		
		unique case(State)
			UP:
			begin
				if (count > 8'd200)
					Next_state = RIGHT;
				else
					Next_state = UP;
			end
			
			RIGHT:
			begin
				if (count > 8'd100)
					Next_state = DOWN;
				else
					Next_state = RIGHT;
			end
			
			DOWN:
			begin
				if (count > 8'd200)
					Next_state = LEFT;
				else
					Next_state = DOWN;
			end
			
			LEFT:
			begin
				if (count > 8'd100)
					Next_state = UP;
				else
					Next_state = LEFT;
			end 