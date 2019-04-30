/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_six
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] tank_palette [11:0];
logic index;

// mem has width of 1 bit and a total of 1024 addresses
logic mem [0:1023];

assign clk_palette[0] = 24'hFFFFFF;
assign clk_palette[1] = 24'h000000;

initial
begin
	 $readmemh("sprite_bytes/Six_Sprite.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= clk_palette[index];
end

endmodule
