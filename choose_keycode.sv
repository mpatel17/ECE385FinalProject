module choose_keycode ( input logic [15:0] keycode,
								output logic [7:0] keycode_p1,
								output logic [7:0] keycode_p2
							 );
							 
	logic [7:0] keycode1, keycode2;
	
	assign keycode1 = keycode[15:8];
	assign keycode2 = keycode[7:0];
	
	always_comb begin
		if (keycode1 == 8'h1a || keycode1 == 8'h16 || keycode1 == 8'h04 || keycode1 == 8'h07 || keycode1 == 8'h2c) begin
			keycode_p1 = keycode1;
			keycode_p2 = keycode2;
		end
		else begin
			keycode_p1 = keycode2;
			keycode_p2 = keycode1;
		end
		
	end
							 
endmodule
