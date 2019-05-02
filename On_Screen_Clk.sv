module timer ( input  Clk,                // 50 MHz clock
										  Reset,              // Active-high reset signal
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						output [3:0] one_sec, ten_sec, hund_sec,
						output is_timer_one, is_timer_ten, is_timer_hund
						);

logic [22:0] counter;
logic Clk2;
logic [3:0] one_sec_in;
logic [3:0] ten_sec_in;
logic [3:0] hund_sec_in;

initial begin
	counter = 23'd0;
	Clk2 = 1'b0;
	one_sec = 4'd0;
	ten_sec = 4'd0;
	hund_sec = 4'd0;
end

always_ff @ (posedge Clk) begin
	if(Reset)
		counter <= 23'd0;
	else begin
		if (counter < 23'd50000000)
			counter <= counter + 1'b1;
		else begin
			counter <= 23'd0;
			Clk2 <= ~Clk2;
		end
	end
end

always_ff @ (posedge Clk2 or posedge Reset) begin
	if(Reset) begin
		one_sec <= 4'd0;
		ten_sec <= 4'd0;
		hund_sec <= 4'd0;
	end
	else begin
		one_sec <= one_sec_in;
		ten_sec <= ten_sec_in;
		hund_sec <= hund_sec_in;
	end
end
	
always_comb begin
	one_sec_in = one_sec;
	ten_sec_in = ten_sec;
	hund_sec_in = hund_sec;
	
	one_sec_in = one_sec + 1'b1;
	if(one_sec == 4'd9) begin
		one_sec_in = 4'd0;
		ten_sec_in = ten_sec + 1'b1;
		if(ten_sec == 4'd9) begin
			ten_sec_in = 4'd0;
			hund_sec_in = hund_sec + 1'b1;
			if(hund_sec == 4'd9) 
				hund_sec_in = 4'd0;
		end
	end
end

	int DistX1, DistX2, DistX3, DistY, W, H;
   assign DistX1 = DrawX - 540;
	assign DistX2 = DrawX - 572;
	assign DistX3 = DrawX - 604;
   assign DistY = DrawY;
   assign W = 32;
	assign H = 32;

   always_comb begin
		if ( DistX3 <= W && DistX3 >= 0 && DistY <= H && DistY >= 0)
          is_timer_one = 1'b1;
      else
          is_timer_one = 1'b0;
			 
		if ( DistX2 <= W && DistX2 >= 0 && DistY <= H && DistY >= 0)
          is_timer_ten = 1'b1;
      else
          is_timer_ten = 1'b0;
			 
		if ( DistX1 <= W && DistX1 >= 0 && DistY <= H && DistY >= 0)
          is_timer_hund = 1'b1;
      else
          is_timer_hund = 1'b0;
	end

endmodule 