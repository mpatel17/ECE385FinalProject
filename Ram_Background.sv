/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM_Background
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] tank_palette [10:0];
logic [3:0] index;

// mem has width of 4 bits and a total of 307200 addresses
logic [3:0] mem [0:307199];

assign tank_palette[0] = 24'hFF0000;
assign tank_palette[1] = 24'h3B2012;
assign tank_palette[2] = 24'h4B2A15; 
assign tank_palette[3] = 24'h5B3719;
assign tank_palette[4] = 24'h774425; 
assign tank_palette[5] = 24'hA05B2A;
assign tank_palette[6] = 24'hAB672D;
assign tank_palette[7] = 24'hBA6F32;
assign tank_palette[8] = 24'h3B2011;
assign tank_palette[9] = 24'h462612; 
assign tank_palette[10] = 24'h754324;

initial
begin
	 $readmemh("sprite_bytes/Wood_Background_3_1.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out<= tank_palette[index];
end

endmodule
