//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module tanks_toplevel( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3,
             // VGA Interface
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );

    logic Reset_h, Clk;
    logic [15:0] keycode;
	 logic [15:0] keycode2;
	 logic [7:0] keycode_p1;
	 logic [7:0] keycode_p2;

    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end

    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;

	 logic [9:0] DrawX, DrawY; //startx1, starty1, startx2, starty2;
	 logic [9:0] tank_X1, tank_X2, tank_Y1, tank_Y2, bullet_X1, bullet_Y1, bullet_X2, bullet_Y2;
	 logic [9:0] wallX1, wallX2, wallX3, wallX4, wallY1, wallY2, wallY3, wallY4;
	 logic is_tank1, is_tank2, is_bullet1, is_bullet2, is_shooting1, is_shooting2;
	 logic is_wall1, is_wall2, is_wall3, is_wall4;
	 logic frame_clk;
	 logic [1:0] hit1, hit2;
	 logic [2:0] tank_dir1, tank_dir2;
	 logic [7:0] count;
	 logic Clk_2;

	 parameter[9:0] startx1 = 10'd140;
	 parameter[9:0] starty1 = 10'd240;
	 parameter[9:0] startx2 = 10'd500;
	 parameter[9:0] starty2 = 10'd240;

    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),
                            .OTG_ADDR(OTG_ADDR),
                            .OTG_RD_N(OTG_RD_N),
                            .OTG_WR_N(OTG_WR_N),
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );

     tanks_soc nios_system(
                             .clk_clk(Clk),
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR),
                             .sdram_wire_ba(DRAM_BA),
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),
                             .sdram_wire_cs_n(DRAM_CS_N),
                             .sdram_wire_dq(DRAM_DQ),
                             .sdram_wire_dqm(DRAM_DQM),
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N),
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),
									  .keycode2_export(keycode2),
                             .otg_hpi_address_external_connection_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );

    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));

    // TODO: Fill in the connections for the rest of the modules
    VGA_controller vga_controller_instance(.Clk(Clk), .Reset(Reset_h),
															.VGA_HS(VGA_HS), .VGA_VS(VGA_VS),
															.VGA_CLK(VGA_CLK),
															.VGA_BLANK_N(VGA_BLANK_N), .VGA_SYNC_N(VGA_SYNC_N),
															.DrawX(DrawX), .DrawY(DrawY));

	 choose_keycode choose(.keycode(keycode),
								  .keycode_p1(keycode_p1), .keycode_p2(keycode_p2)
								  );

   menu menu_select( .Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS),
                     .DrawX(DrawX), .DrawY(DrawY),
                     .keycode(keycode_p2),
                     .menu_num(menu_num), .start_game(start_game)
                    );

	 tank_key tank_p1(.Clk(Clk), .Reset(Reset_h),
						  .frame_clk(VGA_VS),
						  .X_Start(startx1), .Y_Start(starty1),
						  .DrawX(DrawX), .DrawY(DrawY),
						  .is_tank(is_tank1), .is_bullet(is_bullet1),
						  .tank_dir(tank_dir1),
						  .is_shooting(is_shooting1), .hit(hit1),
						  .tank_X(tank_X1), .tank_Y(tank_Y1),
						  .bullet_X(bullet_X1), .bullet_Y(bullet_Y1),
						  .keycode(keycode_p1)
						  );

	 tank_key tank_p3(.Clk(Clk), .Reset(Reset_h),
							.frame_clk(VGA_VS),
							.X_Start(startx2), .Y_Start(starty2),
							.DrawX(DrawX), .DrawY(DrawY),
							.is_tank(is_tank2), .is_bullet(is_bullet2),
							.tank_dir(tank_dir2),
							.is_shooting(is_shooting2), .hit(hit2),
							.tank_X(tank_X2), .tank_Y(tank_Y2),
							.bullet_X(bullet_X2), .bullet_Y(bullet_Y2),
							.keycode(keycode_p2)
							);

//	 tank_ai tank_p2(.Clk(Clk), .Reset(Reset_h),
//						  .frame_clk(VGA_VS),
//						  .DrawX(DrawX), .DrawY(DrawY),
//						  .is_tank(is_tank2),
//						  .tank_dir(tank_dir2),
//						  .tank_X(tank_X2), .tank_Y(tank_Y2),
//						  .count(count),
//						  .Clk_2(Clk_2)
//						  );

	 wall walls(.Clk(Clk), .Reset(Reset_h),
					.frame_clk(frame_clk),
					.DrawX(DrawX), .DrawY(DrawY),
					.is_wall1(is_wall1), .is_wall2(is_wall2), .is_wall3(is_wall3), .is_wall4(is_wall4),
					.X1(wallX1), .X2(wallX2), .X3(wallX3), .X4(wallX4),
					.Y1(wallY1), .Y2(wallY2), .Y3(wallY3), .Y4(wallY4)
					);

    color_mapper color_instance( .start_game(start_game), .menu_num(menu_num), .menuX(menuX), .menuY(menuY), menuboxX(menuboxX), .menuboxY(menuboxY),
                      .is_tank1(is_tank1), .is_tank2(is_tank2), .is_bullet1(is_bullet1), .is_bullet2(is_bullet2),
											//.is_shooting1(is_shooting1), .is_shooting2(is_shooting2),
											.is_wall1(is_wall1), .is_wall2(is_wall2), .is_wall3(is_wall3), .is_wall4(is_wall4),
											.hit1(hit1), .hit2(hit2),
											.tank_dir1(tank_dir1), .tank_dir2(tank_dir2),
											.DrawX(DrawX), .DrawY(DrawY),
											.tankX1(tank_X1), .tankX2(tank_X2), .tankY1(tank_Y1), .tankY2(tank_Y2),
											.wallX1(wallX1), .wallX2(wallX2), .wallX3(wallX3), .wallX4(wallX4),
											.wallY1(wallY1), .wallY2(wallY2), .wallY3(wallY3), .wallY4(wallY4),
											.bulletX1(bullet_X1), .bulletY1(bullet_Y1), .bulletX2(bullet_X2), .bulletY2(bullet_Y2),
											.Clk(Clk),
											.VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

    // Display keycode on hex display
    HexDriver hex_inst_0 (keycode_p1[3:0], HEX0);
    HexDriver hex_inst_1 (keycode_p1[7:4], HEX1);
	 HexDriver hex_inst_2 (keycode_p2[3:0], HEX2);
	 HexDriver hex_inst_3 (keycode_p2[7:4], HEX3);

endmodule
