`include "GLOBAL.sv"
// Check if a combination of tetromino and the play field is valid or not
module check_valid (
    input   tetromino_ctrl  t_ctrl,
    input   field_t         f,
    output  logic           isValid
  );

  logic [1:0] currRotation;
  assign currRotation = t_ctrl.rotation;

  integer signed i, j;

  always_comb
    begin
      isValid = 1'b1;
      for (i = 0; i < 4; ++i)
        begin
          for (j = 0; j < 4; ++j)
            begin
              if (t_ctrl.tetromino.data[currRotation][i][j] == 1) 
                begin
                  if (t_ctrl.coordinate.x + j < 0 || t_ctrl.coordinate.x + j >`FIELD_HORIZONTAL ||
                      t_ctrl.coordinate.y + i < 0 || t_ctrl.coordinate.y + i >= `FIELD_VERTICAL)
                    // invlaid, tetromino out of bound
                    isValid = 1'b0;
                  else
                    if (f.data[t_ctrl.coordinate.y[`FIELD_VERTICAL_WIDTH - 1 : 0] + i]
                        [t_ctrl.coordinate.x[`FIELD_HORIZONTAL_WIDTH - 1 : 0] + j].data != `TETROMINO_EMPTY)
                      // invlaid, tetromino overwrite non empty block on field
                      isValid = 1'b0;
                end
            end
        end
    end
endmodule

//testbench for check_valid
module check_valid_testbench();
  tetromino_ctrl  t_ctrl;
  field_t         f;
  logic           isValid;

  check_valid dut (.*);

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