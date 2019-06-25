`include "GLOBAL.sv"

// This produce a field_t f_out result by applying the tetromino
// being controling to it. The result of this can be combined
// with draw_field() to draw current field state.
module create_field (
    input   tetromino_ctrl  t_ctrl,
    input   field_t         f,
    output  field_t         f_out
  );

  logic   [1:0] currRotation;
  coor_t        block_coordinate;

  // calculate the total rotation
  assign currRotation = t_ctrl.rotation;

  integer i, j, x, y;
  always_comb
    begin
      f_out = f;
      begin
        for (i = 0; i < 4; ++i)
          begin
            for (j = 0; j < 4; ++j)
              begin
                if (t_ctrl.tetromino.data[currRotation][i][j] == 1)
                  begin
                    block_coordinate.x = t_ctrl.coordinate.x + j;
                    block_coordinate.y = t_ctrl.coordinate.y + i;

                    // make sure the coordinate is not negative
                    if (block_coordinate.x >= 0 && block_coordinate.x <`FIELD_HORIZONTAL &&
                        block_coordinate.y >= 0 && block_coordinate.y <`FIELD_VERTICAL)
                      // field at that coordinate is set to the correct index
                      f_out.data[block_coordinate.y[`FIELD_VERTICAL_WIDTH - 1 : 0]]
                                [block_coordinate.x[`FIELD_HORIZONTAL_WIDTH - 1 : 0]] = t_ctrl.idx;
                  end
              end
          end
      end
    end
endmodule

// testbench for create_field
module create_field_testbench();
  tetromino_ctrl  t_ctrl;
  field_t         f;
  field_t         f_out;

  create_field dut (.*);

  assign f.data = {
           30'b111_111_111_111_000_111_111_111_111_111,
           30'b111_111_111_111_000_111_111_111_111_111,
           30'b111_111_111_111_000_111_111_111_111_111,
           30'b111_111_111_111_000_111_111_111_111_111,
           30'b111_111_111_111_111_111_111_111_111_111,
           30'b111_111_111_111_111_111_111_111_111_111,
           30'b111_111_111_111_111_111_111_111_111_111,
           30'b111_111_111_111_111_111_111_111_111_111,
           30'b111_010_111_111_111_111_111_111_110_010,
           30'b111_011_101_111_111_111_111_111_111_111,
           30'b010_100_001_111_111_111_111_111_110_001,
           30'b000_000_101_111_111_111_111_111_000_000,
           30'b000_111_111_111_111_101_110_011_111_101,
           30'b001_000_110_010_111_111_111_001_100_100,
           30'b000_010_111_111_011_100_011_011_010_110,
           30'b011_001_010_001_011_100_011_101_000_010,
           30'b000_000_100_011_101_111_111_111_111_111,
           30'b110_001_100_011_011_001_001_000_110_111,
           30'b010_101_010_010_010_000_011_011_100_111,
           30'b000_010_100_001_000_101_111_000_101_111,
           30'b110_000_001_010_111_100_100_010_110_111,
           30'b010_111_000_100_010_010_100_110_100_111
         };

  initial
    begin
      t_ctrl.tetromino.data =
        { 4'b0000,
          4'b0100,
          4'b1110,
          4'b0000,

          4'b0000,
          4'b0100,
          4'b0110,
          4'b0100,

          4'b0000,
          4'b0000,
          4'b1110,
          4'b0100,

          4'b0000,
          4'b0100,
          4'b1100,
          4'b0100 };
      t_ctrl.idx.data = `TETROMINO_T_IDX;
      t_ctrl.rotation = 0;
      t_ctrl.coordinate.x = 2;
      t_ctrl.coordinate.y = 0;
      #10;
      t_ctrl.rotation = 1;
      #10;
      t_ctrl.rotation = 2;
      #10;
      t_ctrl.rotation = 3;
      #10;
      t_ctrl.coordinate.y = 3;
      #10;
      t_ctrl.coordinate.x = -1;
      #10;
      t_ctrl.rotation = 0;
      #10;
      t_ctrl.rotation = 1;
      #10;
      $stop;
    end
endmodule
