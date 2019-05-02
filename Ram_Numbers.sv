module  frameRAM_numbers
(
		input [18:0] read_address,
		input Clk,
		output logic [23:0] data_Out
);

logic [23:0] palette [0:1];
logic [1:0] index;

// mem has width of 2 bits and a total of 12000 addresses
logic [1:0] mem [0:10239];

assign palette[0] = 24'hffffff;
assign palette[1] = 24'h000000;

initial
begin
	 $readmemh("sprite_bytes/Number_Sprite.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= palette[index];
end

endmodule 