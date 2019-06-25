`include "GLOBAL.sv"
// LFSR random module 5 bit but output only 7 distinct
// value for tetromino type. Used to generate new
// tetromino block. The randomly generated tetromino
// is at spawn coordinate, (3, 0) for non I and
// (3, -1) otherwise.
module generate_tetromino (
    input   logic             clk, enable,
    output  tetromino_ctrl    curr, next
  );

  logic [15:0] internal = 4425; // randomly picked seed
  tetromino_idx_t   ran;

  // LFSR shift
  always_ff @(posedge clk)
    if (enable)
      begin
        internal <= {internal[14:0], internal[15] ^~ internal[14] ^~ internal[12] ^~ internal[3]};
        curr <= next;
      end

  // use mod to get the randomed  output
  assign ran.data = internal % `NUMBER_OF_TETROMINO;

  always_comb
    begin
      next.idx = ran;
      next.rotation = 0;
      next.coordinate.x = 3;
      next.coordinate.y = next.idx == `TETROMINO_I_IDX ? 0 : -1;
    end

  get_tetromino_info getInfo (ran, next.tetromino);
endmodule
