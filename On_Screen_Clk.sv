//module timer ( input  Clk,                // 50 MHz clock
//										  Reset,              // Active-high reset signal
//						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
//						output [3:0] one_sec, one_min,
//						output [2:0] ten_sec, ten_min
//						);
//
//logic [22:0] counter;
//logic Clk2;
//logic [3:0] one_sec;
//logic [2:0] ten_sec;
//logic [3:0] one_min;
//logic [2:0] ten_min;
//
//initial begin
//	counter = 23'd0;
//	Clk2 = 1'b0;
//	one_sec = 4'd0;
//	ten_sec = 4'd0;
//	one_min = 4'd0;
//	ten_min = 4'd0;
//end
//
//always_ff @ (posedge Clk) begin
//	if(Reset) begin
// 		counter = 23'd0;
//  	Clk2 = 1'b0;
//  	one_sec = 4'd0;
//  	ten_sec = 4'd0;
//  	one_min = 4'd0;
//  	ten_min = 4'd0;
//	end
//	else begin
//		if (counter < 23'd50000000)
//			counter = counter + 1'b1;
//		else begin
//			counter = 23'd0;
//			Clk2 = ~Clk2;
//		end
//	end
//end
//
//always_ff @ (posedge Clk2) begin
//	if (one_sec < 4'd9)
//		one_sec = one_sec + 1'b1;
//	else begin
//		one_sec = 4'd0;
//		ten_sec = ten_sec + 1'b1;
//	end
//
//	if (ten_sec < 3'd6)
//		ten_sec = ten_sec + 1'b1;
//	else begin
//		ten_sec = 3'd0;
//		one_min = one_min + 1'b1;
//	end
//
//	if (one_min < 4'd9)
//		one_min = one_min + 1'b1;
//	else begin
//		one_min = 4'b0;
//		ten_min = ten_min + 1'b1;
//	end
//
//	if (ten_min < 3'b6)
//		ten_min = ten_min + 1'b1;
//	else
//		ten_min = 3'b0;
//end