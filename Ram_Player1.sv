/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Player1Wins
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] palette [5:0];
logic [2:0] index;

// mem has width of 2 bits and a total of 12000 addresses
logic [2:0] mem [0:49151];

assign palette[0] = 24'hFF0000;
assign palette[1] = 24'h000000;
assign palette[2] = 24'h9ff5ff;
assign palette[3] = 24'h004f57;
assign palette[4] = 24'h484848;
assign palette[5] = 24'h8a4bfe;

initial
begin
	 $readmemh("sprite_bytes/Player1_Wins.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= palette[index];
end

endmodule
