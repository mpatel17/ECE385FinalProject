module wall_location(
					input Clk, Reset,
					input Wall,
					input [9:0] location,
					output [9:0] location2
);

logic [9:0] maxX = 10'd640;
logic [9:0] maxY = 10'd480;

logic [9:0] location2;

always_comb begin
	location2[0]  = location[0] ^ location[1];
	location2[1]  = location [1] & location[2];
	location2[2]  = !location[2];
	location2[3]  = !location[3]  ^  !location[4];
	location2[4]  = !location[4] & location[5];
	location2[5]  = location[5];
	location2[6]  = !location[6];
	location2[7]  = location[6] ^ !location[7];
	location2[8]  = location[8];
	location2[9]  = location[8] &  location[9];

	if (wall == 1'b0)
		location2 = location2 % maxX;
	else if (wall == 1'b1)
		location2 = location2 % maxY;

end

endmodule
