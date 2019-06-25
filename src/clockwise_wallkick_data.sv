`include "GLOBAL.sv"

// This module output add value to x and y coordinate based
// on wall kick data on https://tetris.fandom.com/wiki/SRS
// rotating clockwise, i.e. 0>>1, 1>>2, 2>3, 3>>0
module clockwise_wallkick_data (
    input   logic           [1:0] rotation,
    input   logic           [2:0] step,
    input   tetromino_idx_t       idx,
    output  logic   signed  [2:0] add_x, add_y
  );

  always_comb
    begin
      case(step)
        0:
          begin
            add_x = 0;
            add_y = 0;
          end
        1:
          begin
            case(rotation)
              0:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -2;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = 0;
                  end
              1:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -1;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = 0;
                  end
              2:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 2;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = 0;
                  end
              3:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 1;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = 0;
                  end
            endcase
          end
        2:
          begin
            case(rotation)
              0:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 1;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = 1;
                  end
              1:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 2;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = -1;
                  end
              2:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -1;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = 1;
                  end
              3:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -2;
                    add_y = 0;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = -1;
                  end
            endcase
          end
        3:
          begin
            case(rotation)
              0:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -2;
                    add_y = -1;
                  end
                else
                  begin
                    add_x = 0;
                    add_y = -2;
                  end
              1:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -1;
                    add_y = 2;
                  end
                else
                  begin
                    add_x = 0;
                    add_y = 2;
                  end
              2:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 2;
                    add_y = 1;
                  end
                else
                  begin
                    add_x = 0;
                    add_y = -2;
                  end
              3:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 1;
                    add_y = -2;
                  end
                else
                  begin
                    add_x = 0;
                    add_y = 2;
                  end
            endcase
          end
        4:
          begin
            case(rotation)
              0:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 1;
                    add_y = 2;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = -2;
                  end
              1:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = 2;
                    add_y = -1;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = 2;
                  end
              2:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -1;
                    add_y = -2;
                  end
                else
                  begin
                    add_x = 1;
                    add_y = -2;
                  end
              3:
                if (idx == `TETROMINO_I_IDX)
                  begin
                    add_x = -2;
                    add_y = -1;
                  end
                else
                  begin
                    add_x = -1;
                    add_y = 2;
                  end
            endcase
          end
        default:
          begin
            add_x = 'x;
            add_y = 'x;
          end
      endcase
    end

endmodule

// testbench for clockwise_wallkick_data
module clockwise_wallkick_data_testbench();
  logic           [1:0] rotation;
  logic           [2:0] step;
  tetromino_idx_t       idx;
  logic   signed  [2:0] add_x, add_y;

  clockwise_wallkick_data dut (.*);

  integer i, j;
  initial
    begin
      idx.data = `TETROMINO_I_IDX;
      for(i = 0; i < 4; ++i)
        begin
          rotation = i;
          for(j = 0; j < 5; ++j)
            begin
              step = j;
              #10;
            end
        end

      idx.data = `TETROMINO_J_IDX;
      for(i = 0; i < 4; ++i)
        begin
          rotation = i;
          for(j = 0; j < 5; ++j)
            begin
              step = j;
              #10;
            end
        end
    end
endmodule
