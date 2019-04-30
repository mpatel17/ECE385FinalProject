module choose_keycode ( input logic [15:0] keycode,
								output logic [7:0] keycode_p1,
								output logic [7:0] keycode_p2
							 );
							 
	logic [7:0] keycode1, keycode2;
	
	assign keycode1 = keycode[15:8];
	assign keycode2 = keycode[7:0];
	
	always_comb begin
		keycode_p1 = 8'h00;
		keycode_p2 = 8'h00;
		if (keycode1 == 8'h1a || keycode1 == 8'h16 || keycode1 == 8'h04 || keycode1 == 8'h07 || keycode1 == 8'h2c) 
			keycode_p1 = keycode1;
		else if (keycode1 == 8'h52 || keycode1 == 8'h51 || keycode1 == 8'h50 || keycode1 == 8'h4f || keycode1 == 8'h28)
			keycode_p2 = keycode1;
		if (keycode2 == 8'h1a || keycode2 == 8'h16 || keycode2 == 8'h04 || keycode2 == 8'h07 || keycode2 == 8'h2c) 
			keycode_p1 = keycode2;
		else if (keycode2 == 8'h52 || keycode2 == 8'h51 || keycode2 == 8'h50 || keycode2 == 8'h4f || keycode2 == 8'h28)
			keycode_p2 = keycode2;
	end
							 
endmodule
