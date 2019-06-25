`include "GLOBAL.sv"

module draw_field_clk (
    input   logic           clk,
    input   field_t         f,
    input   logic [10:0]    x, y,
    output  color_t         color,
    output  logic           drawEnable
  );

  logic [$clog2(`BLOCK_PIXEL) - 1 : 0] x_mod, y_mod;
  logic [`FIELD_HORIZONTAL_WIDTH - 1 : 0] x_field;
  logic [`FIELD_VERTICAL_WIDTH - 1 : 0] y_field;

  assign x_mod = (x - `FIELD_START_X) % `BLOCK_PIXEL;
  assign y_mod = (y - `FIELD_START_Y) % `BLOCK_PIXEL;
  assign x_field = (x - `FIELD_START_X) / `BLOCK_PIXEL;
  assign y_field = (y - `FIELD_START_Y) / `BLOCK_PIXEL + `FIELD_VERTICAL - `FIELD_VERTICAL_DISPLAY;

  color_t         color_n;
  logic           drawEnable_n;

  always_comb
    begin
      color_n = `C_EMPTY;
      drawEnable_n = 0;

      if (x >= `FIELD_BORDER_START_X && x < `FIELD_BORDER_END_X &&
          y >= `FIELD_BORDER_START_Y && y < `FIELD_BORDER_END_Y)
        drawEnable_n = 1;

      if (x >= `FIELD_START_X && x < `FIELD_END_X &&
          y >= `FIELD_START_Y && y < `FIELD_END_Y)
        begin
          if (x_mod != 0 && x_mod != `BLOCK_PIXEL - 1 &&
              y_mod != 0 && y_mod != `BLOCK_PIXEL - 1 )
            color_n = {1'b1, f.data[y_field][x_field]};
        end
      else
        begin
          color_n = `C_BORDER;
        end
    end
	 
  always_ff @(posedge clk) begin
    color <= color_n;
	 drawEnable <= drawEnable_n;
  end

endmodule
