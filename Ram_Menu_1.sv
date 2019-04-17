/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Menu_1
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] menu_palette [11:0];
logic [2:0] index;

// mem has width of 2 bits and a total of 12000 addresses
logic [2:0] mem [0:11999];

assign menu_palette[0] = 24'hFF0000;
assign menu_palette[1] = 24'h000000;
assign menu_palette[2] = 24'h9ff5ff;
assign menu_palette[3] = 24'h004f57;
assign menu_palette[4] = 24'h484848;
assign menu_palette[5] = 24'h8a4bfe;

initial
begin
	 $readmemh("sprite_bytes/Start_Menu_1.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= menu_palette[index];
end

endmodule
