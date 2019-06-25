// generate a signal for tetromino to go down, if soft drop is press,
// the signal is generated right away
module down_signal_gen #(
  parameter MAX_COUNT = 26'd51_000_000,
  parameter STEP      = 26'd02_900_000
)
(
  input  logic clk, rst, soft_drop,
  input  logic [3:0] level,
  output logic down_signal
);

  logic [25:0] reset_count;

  // the count being reset to depend on the level
  assign reset_count = MAX_COUNT - STEP*level;

  logic [25:0] count = MAX_COUNT;

  always_ff @(posedge clk)
    if (rst)
      count <= reset_count;
    else if (soft_drop)
      count <= 0;
    else if (~down_signal)
      count <= count - 1;

  assign down_signal = (count == 0);
endmodule
