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
	logic Clk_2;
	logic [13:0] counter;
	
	enum logic [2:0] {UP, RIGHT, DOWN, LEFT, PAUSE1, PAUSE2, PAUSE3, PAUSE4} State, Next_state;
	
	initial begin
		X_Pos_in = X_Start;
		X_Pos = X_Start;
		X_Motion_in = 10'd0;
		X_Motion = 10'd0;
		Y_Pos_in = Y_Start;
		Y_Pos = Y_Start;
		Y_Motion_in = 10'd0;
		Y_Motion = 10'd0;
		counter = 14'd0;
		Clk_2 = 1'b0;
	 end
	 
	 // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	 
	 always_ff @ (posedge Clk)
	 begin
	 if(counter < 10000)
		counter = counter + 1; 
	 else 
		counter = 0; 
		Clk_2 = (Clk_2 + 1) % 2 ; 
	 end
	 
	 
	 
	 always_ff @ (posedge Clk_2)
	 begin
		if(Reset) begin
			State <= UP;
			X_Pos <= X_Start;
			Y_Pos <= Y_Start;
			count <= 8'h00;
			tank_dir <= 3'd1;
			X_Motion <= 10'd0;
			Y_Motion <= 10'd0;
		end
		else begin
			State <= Next_state;
			X_Pos <= X_Pos_in;
			Y_Pos <= Y_Pos_in;
			count <= next_count;
			tank_dir <= tank_dir_in;
			X_Motion <= X_Motion_in;
			Y_Motion <= Y_Motion_in;
		end
	end
	
	always_comb begin
		Next_state = State;
		X_Pos_in = X_Pos;
		Y_Pos_in = Y_Pos;
		next_count = 8'h00;
		tank_dir_in = tank_dir;
		X_Motion_in = X_Motion;
		Y_Motion_in = Y_Motion;
		
		if (frame_clk_rising_edge)
		begin
		
			unique case(State)
				UP:
				begin
					if (count > 8'd200)
						Next_state = PAUSE1;
					else
						Next_state = UP;
				end
				
				RIGHT:
				begin
				
					if (count > 8'd100)
						Next_state = PAUSE2;
					else
						Next_state = RIGHT;
				end
				
				DOWN:
				begin
					if (count > 8'd200)
						Next_state = PAUSE3;
					else
						Next_state = DOWN;
				end
				
				LEFT:
				begin
					if (count > 8'd100)
						Next_state = PAUSE4;
					else
						Next_state = LEFT;
				end 
				
				PAUSE1:
					Next_state = RIGHT;
					
				PAUSE2:
					Next_state = DOWN;
					
				PAUSE3:
					Next_state = LEFT;
				
				PAUSE4:
					Next_state = UP;
				
				default: ;
			endcase
			
			unique case(State)
				UP:
				begin
					next_count = count + 1'b1;
					Y_Motion_in = (~(Y_Step) + 1'b1); 
					X_Motion_in = 10'd0;
					tank_dir_in = 3'd1;
				end
				
				PAUSE1:
					next_count = 8'h00;
				
				RIGHT:
				begin
					next_count = count + 1'b1;
					Y_Motion_in = 10'd0;
					X_Motion_in = X_Step;
					tank_dir_in = 3'd2;
				end
				
				PAUSE2:
					next_count = 8'h00;
				
				DOWN:
				begin
					next_count = count + 1'b1;
					Y_Motion_in = Y_Step;
					X_Motion_in = 10'd0;
					tank_dir_in = 3'd4;
				end
				
				PAUSE3:
					next_count = 8'h00;
				
				LEFT:
				begin
					next_count = count + 1'b1;
					Y_Motion_in = 10'd0;
					X_Motion_in = (~(X_Step) + 1'b1);
					tank_dir_in = 3'd3;
				end
				
				PAUSE4:
					next_count = 8'h00;
				
				default: ;
			endcase 
			
			X_Pos_in = X_Pos + X_Motion;
			Y_Pos_in = Y_Pos + Y_Motion;
			
		end
		
	end
	
	assign tank_X = X_Pos;
	assign tank_Y = Y_Pos;
		
	int DistX, DistY, W, H;
   assign DistX = DrawX - X_Pos;
   assign DistY = DrawY - Y_Pos;
   assign W = Width;
	assign H = Height;
   always_comb begin
       if ( DistX <= W && DistX >= 0 && DistY <= H && DistY >= 0)
           is_tank = 1'b1;
       else
           is_tank = 1'b0;;
   end 
	
endmodule 