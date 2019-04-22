/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Bullet
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);


logic [23:0] palette [2:0];
logic [1:0] index;

// mem has width of 3 bits and a total of 175 addresses
logic [1:0] mem [0:256];

assign palette[0] = 24'hFFFFFF;
assign palette[1] = 24'hFFC90E;
assign palette[2] = 24'h000000;

initial
begin
	 $readmemh("sprite_bytes/Bullet.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out<= palette[index];
end

endmodule
