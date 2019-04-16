/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Background
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [4:0] data_Out
);

// mem has width of 4 bits and a total of 307200 addresses
logic [3:0] mem [0:307199];

initial
begin
	 $readmemh("sprite_bytes/Wood_Background_3_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule
