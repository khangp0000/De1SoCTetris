`include "GLOBAL.sv"

// from a input of tetromino, output the corresponding tetromino
// that contains all posible rotation
module get_tetromino_info (
    input  tetromino_idx_t    tetromino_idx,
    output tetromino_t        tetromino_type
  );
  localparam tetromino_t blk_I =
             { 4'b0000,
               4'b1111,
               4'b0000,
               4'b0000,

               4'b0010,
               4'b0010,
               4'b0010,
               4'b0010,

               4'b0000,
               4'b0000,
               4'b1111,
               4'b0000,

               4'b0100,
               4'b0100,
               4'b0100,
               4'b0100 };

  localparam tetromino_t blk_J =
             { 4'b0000,
               4'b1000,
               4'b1110,
               4'b0000,

               4'b0000,
               4'b0110,
               4'b0100,
               4'b0100,

               4'b0000,
               4'b0000,
               4'b1110,
               4'b0010,

               4'b0000,
               4'b0100,
               4'b0100,
               4'b1100 };

  localparam tetromino_t blk_L =
             { 4'b0000,
               4'b0010,
               4'b1110,
               4'b0000,
               
               4'b0000,
               4'b0100,
               4'b0100,
               4'b0110,

               4'b0000,
               4'b0000,
               4'b1110,
               4'b1000,

               4'b0000,
               4'b1100,
               4'b0100,
               4'b0100 };

  localparam tetromino_t blk_O =
             { 4'b0000,
               4'b0110,
               4'b0110,
               4'b0000,

               4'b0000,
               4'b0110,
               4'b0110,
               4'b0000,

               4'b0000,
               4'b0110,
               4'b0110,
               4'b0000,

               4'b0000,               
               4'b0110,
               4'b0110,
               4'b0000 };

  localparam tetromino_t blk_S =
             { 4'b0000,
               4'b0110,
               4'b1100,
               4'b0000,
               
               4'b0000,
               4'b0100,
               4'b0110,
               4'b0010,
               
               4'b0000,
               4'b0000,
               4'b0110,
               4'b1100,
               
               4'b0000,
               4'b1000,
               4'b1100,
               4'b0100 };

  localparam tetromino_t blk_T =
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

  localparam tetromino_t blk_Z =
             { 4'b0000,
               4'b1100,
               4'b0110,
               4'b0000,
               
               4'b0000,
               4'b0010,
               4'b0110,
               4'b0100,
               
               4'b0000,
               4'b0000,
               4'b1100,
               4'b0110,
               
               4'b0000,
               4'b0100,
               4'b1100,
               4'b1000 };

  always_comb
    case (tetromino_idx.data)
      `TETROMINO_I_IDX:
        tetromino_type = blk_I;
      `TETROMINO_J_IDX:
        tetromino_type = blk_J;
      `TETROMINO_L_IDX:
        tetromino_type = blk_L;
      `TETROMINO_O_IDX:
        tetromino_type = blk_O;
      `TETROMINO_S_IDX:
        tetromino_type = blk_S;
      `TETROMINO_T_IDX:
        tetromino_type = blk_T;
      `TETROMINO_Z_IDX:
        tetromino_type = blk_Z;
      default:
        tetromino_type = 'x;
    endcase

endmodule
