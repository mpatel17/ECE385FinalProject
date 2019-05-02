module  frameRAM_death1
(
		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [23:0] palette [0:9];
logic [3:0] index;

// mem has width of 2 bits and a total of 12000 addresses
logic [3:0] mem [0:1023];

assign palette[0] = 24'hfffed2;
assign palette[1] = 24'h350202;
assign palette[2] = 24'h500000;
assign palette[3] = 24'hd54014;
assign palette[4] = 24'hfd6e44;
assign palette[5] = 24'hfda24a;
assign palette[6] = 24'hfdd761;
assign palette[7] = 24'hf0ee8d;
assign palette[8] = 24'hfffd74;
assign palette[9] = 24'hfffeb7;

initial
begin
	 $readmemh("sprite_bytes/sprite_1.txt", mem);
end

assign index = mem[read_address];

always_ff @ (posedge Clk) begin
	data_Out <= palette[index];
end

endmodule 