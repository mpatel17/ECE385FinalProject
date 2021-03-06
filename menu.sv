module  menu ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input logic [7:0] keycode,			 // key that is being pressed
               output logic [1:0] menu_num,      //Which menu sprite to use (blank, single, double)
               output logic start_game
               output [9:0] menuX, menuY, menuboxX, menuboxY
              );

	 logic [1:0] menu_num_in;
    logic [9:0] menuboxX_in, menuboxY;

	 initial begin
		 menu_num = 2'b00;
		 menu_num_in = 2'b00;
		 start_game = 1'b0;
		 menuboxX = 10'b00;
		 menuboxX_in = 10'b00;
		 menuboxY = 10'b00;
		 menuboxY_in = 10'b00;
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
            menu_num = 2'b00;
            menu_num_in = 2'b00;
            menuboxX_in = 10'b00;
            menuboxY_in = 10'b00;
            start_game = 1'b0;
        end
        else
        begin
            menu_num = menu_num_in;
            menuboxX = menuboxX_in;
            menuboxY = menuboxY_in;
        end
    end

	 always_comb
    begin
        // By default, keep menu unchanging
        menu_num_in = menu_num;
        menuboxX_in = menuboxX;
        menuboxY_in = menuboxY;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
			  // check which menu sprite to display
				if( keycode == 8'h51 )	// 'Down'
					menu_num_in = 2'b10;
				menuboxX = 10'b00;
				menuboxY = 10'b00;

				else if( keycode == 8'h52 )	// 'Up'
					menu_num_in = 2'b01;
				menuboxX = 10'b00;
				menuboxY = 10'b00;

				else if( keycode == 8'h58 && menu_num != 2'b00) // 'Enter'
				  if (menu_num == 2'b01)
            start_game = 1'b1;
          if (menu_num == 2'b10)
            start_game = 1'b1;
        end
      end
endmodule
