`include "GLOBAL.sv"
module waifu (
	 input   logic         clk,
    input   logic [10:0]  x, y,
    output  logic [23:0]  waifuColor
  );

  logic [$clog2(`WAIF_TOTAL_PIX) - 1 : 0] idx, idx_y, idx_x;
    
  assign idx_y = (y << 8) - (y << 3) - (`WAIF_START_Y*`WAIF_H_PIX);
  assign idx_x = x - `WAIF_START_X;

  always_comb begin
    if (y < `WAIF_START_Y)
      idx = 0;
    else begin
      if (x < `WAIF_START_X || x >= `WAIF_END_X)
        idx = idx_y;
      else
        idx = idx_y + idx_x;        
    end
  end
  
  waifu_rom rom(
	.address(idx),
	.clock (clk),
	.q(waifuColor));
	
endmodule
