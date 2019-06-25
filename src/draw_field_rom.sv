`include "GLOBAL.sv"
// Used to draw tetris playing field
module draw_field_rom (
    input   logic           clk,
    input   field_t         f,
    input   logic [10:0]    x, y,
    // read color from rom
    output  logic [12:0]    rom_addr,
    input   logic [23:0]    rom_color,

    output  logic [23:0]    color,
    output  logic           drawEnable
  );

  logic [$clog2(`BLOCK_PIXEL) - 1 : 0] x_mod, y_mod;
  logic [`FIELD_HORIZONTAL_WIDTH - 1 : 0] x_field;
  logic [`FIELD_VERTICAL_WIDTH - 1 : 0] y_field;

  assign x_mod = (x - `FIELD_START_X) % `BLOCK_PIXEL;
  assign y_mod = (y - `FIELD_START_Y) % `BLOCK_PIXEL;
  assign x_field = (x - `FIELD_START_X) / `BLOCK_PIXEL;
  assign y_field = (y - `FIELD_START_Y) / `BLOCK_PIXEL + `FIELD_VERTICAL - `FIELD_VERTICAL_DISPLAY;

  logic           read_rom, read_rom_n;
  logic           drawEnable_n;
  logic [23:0]    non_rom_color, non_rom_color_n;

  always_comb
    begin
      // non_rom_color_n = `C_EMPTY_FULL;
      drawEnable_n = 0;
      read_rom_n = 0;
      rom_addr = 'x;

      // start drawing within the border
      if (x >= `FIELD_BORDER_START_X && x < `FIELD_BORDER_END_X &&
          y >= `FIELD_BORDER_START_Y && y < `FIELD_BORDER_END_Y)
        drawEnable_n = 1;

      // draw field
      if (x >= `FIELD_START_X && x < `FIELD_END_X &&
          y >= `FIELD_START_Y && y < `FIELD_END_Y)
        begin
          read_rom_n = 1;
          rom_addr = f.data[y_field][x_field] * 32 * 32 + y_mod * 32 + x_mod;
        end
    end

  always_ff @(posedge clk)
    begin
      read_rom <= read_rom_n;
      // non_rom_color <= non_rom_color_n;
      drawEnable <= drawEnable_n;
    end

  assign color = read_rom ? rom_color : `C_BORDER_FULL;

endmodule
