///*
// * ECE385-HelperTools/PNG-To-Txt
// * Author: Rishi Thakkar
// *
// */
//
//module  frameRAM_Tank_3
//(
//		input [18:0] read_address, 
//		input Clk,
//
//		output logic [23:0] data_Out
//);
//
//logic [23:0] tank_palette [11:0];
//logic [3:0] index;
//
//// mem has width of 4 bits and a total of 2500 addresses
//logic [3:0] mem [0:1023];
//
//assign tank_palette[0] = 24'hFF0000;
//assign tank_palette[1] = 24'h000000;
//assign tank_palette[2] = 24'h142608; 
//assign tank_palette[3] = 24'h3D3D3D;
//assign tank_palette[4] = 24'h5D5D5D; 
//assign tank_palette[5] = 24'h1F390E;
//assign tank_palette[6] = 24'h203D0D;
//assign tank_palette[7] = 24'h2E5315;
//assign tank_palette[8] = 24'h264810;
//assign tank_palette[9] = 24'h112C1D; 
//assign tank_palette[10] = 24'h163925;
//assign tank_palette[11] = 24'h19462C;
//
//initial
//begin
//	 $readmemh("sprite_bytes/Tank_Image_4.txt", mem);
//end
//
//assign index = mem[read_address];
//
//always_ff @ (posedge Clk) begin
//	data_Out <= tank_palette[index];
//end
//
//endmodule
