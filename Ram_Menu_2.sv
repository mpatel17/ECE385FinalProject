/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Menu_2
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] menu_palette [11:0];
logic index;

// mem has width of 1 bit and a total of 8192 addresses
logic mem [0:8191];

assign menu_palette[0] = 24'hffffff;
assign menu_palette[1] = 24'h8a4bfe;

initial
begin
	 $readmemh("sprite_bytes/Start_Menu_2.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= menu_palette[index];
end

endmodule
