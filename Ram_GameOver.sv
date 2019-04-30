/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_GameOver
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] palette [1:0];
logic [2:0] index;

// mem has width of 2 bits and a total of 12000 addresses
logic [2:0] mem [0:8191];

assign palette[0] = 24'h000000;
assign palette[1] = 24'hffffff;

initial
begin
	 $readmemh("sprite_bytes/Game_Over.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= palette[index];
end

endmodule