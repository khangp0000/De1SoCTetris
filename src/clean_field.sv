`include "GLOBAL.sv"

// This module sequentially clean up row that already filled up and
// return number of row being cleanned.
module clean_field (
    input   logic       clk, enable,
    input   field_t     f,
    output  field_t     f_out,
    output  logic [2:0] lines, // real game never more than 4
    output  logic       done
  );

  // The line we are currently checking
  logic [`FIELD_VERTICAL_WIDTH : 0] currentLine = `FIELD_VERTICAL - 1;

  enum {idle, loop, done_s} state = idle;

  // done output when in done state
  assign done = state == done_s;

  // logic to check if current row is full and need to be clean or is empty
  logic needClean, emptyLine;

  integer i, j;
  always_comb
    begin
      needClean = 1;
      emptyLine = 1;
      for (i = 0; i < `FIELD_HORIZONTAL; ++i)
        if (f_out.data[currentLine][i] == `TETROMINO_EMPTY)
          begin
            needClean = 0;
          end
        else
          begin
            emptyLine = 0;
          end
    end


  always_ff @(posedge clk)
    begin
      if (~enable)
        begin
          currentLine <= `FIELD_VERTICAL - 1;
          f_out <= f;
          lines <= 0;
          state = idle;
        end
      else
        begin
          case (state)
            idle:
              begin
                currentLine <= `FIELD_VERTICAL - 1;
                f_out <= f;
                lines <= 0;
                state <= loop;
              end
            loop:
              begin
                if (needClean)
                  begin
                    for (j = 1; j < `FIELD_VERTICAL; ++j)
							if (j <= currentLine)
                      f_out.data[j] <= f_out.data[j - 1];

                    f_out.data[0] <= '1;
                    lines <= lines + 1;
                  end
                else if (emptyLine || currentLine == 0)
                  state <= done_s;
                else
                  currentLine <= currentLine - 1;
              end
            done_s:
              ;
          endcase
        end
    end
endmodule

// testbench for clean_field
module clean_field_testbench();
  logic       clk, enable;
  field_t     f;
  field_t     f_out;
  logic [2:0] lines;
  logic       done;

  clean_field dut (.*);

  // Set up the clock.
  parameter CLOCK_PERIOD=100;
  initial
    clk=1;
  always
    begin
      #(CLOCK_PERIOD/2);
      clk = ~clk;
    end

  initial
    begin
      enable <= 0;
      f.data <= {
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_010_111_111_111_111_111_111_110_111,
               30'b111_011_101_111_111_111_111_111_111_111,
               30'b010_100_001_111_111_111_111_111_110_111,
               30'b000_000_101_111_111_111_111_111_000_111,
               30'b000_111_111_111_111_101_110_011_111_111,
               30'b001_000_110_010_111_111_111_001_100_111,
               30'b000_010_111_111_011_100_011_011_010_111,
               30'b011_001_010_001_011_100_011_101_000_111,
               30'b000_000_100_011_101_111_111_111_111_111,
               30'b110_001_100_011_011_001_001_000_110_111,
               30'b010_101_010_010_010_000_011_011_100_111,
               30'b000_010_100_001_000_101_001_000_101_100, // this should be clean out
               30'b110_000_001_010_111_100_100_010_110_111,
               30'b010_110_000_100_010_010_100_110_100_101  // this shoud be clean out
             };

      @(posedge clk);
      enable <= 1;
      @(posedge done);
      f.data <= {
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_000_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_111_111_111_111_111_111_111_111_111,
               30'b111_010_111_111_111_111_111_111_110_111,
               30'b111_011_101_111_111_111_111_111_111_111,
               30'b010_100_001_111_111_111_111_111_110_111,
               30'b000_000_101_111_111_111_111_111_000_111,
               30'b000_111_111_111_111_101_110_011_111_111,
               30'b001_000_110_010_111_111_111_001_100_111,
               30'b000_010_111_111_011_100_011_011_010_111,
               30'b011_001_010_001_011_100_011_101_000_111,
               30'b000_000_100_011_101_111_111_111_111_111,
               30'b110_001_100_011_011_001_001_000_110_111,
               30'b010_101_010_010_010_000_011_011_100_111,
               30'b000_010_100_001_111_101_001_000_101_100,
               30'b110_000_001_010_111_100_100_010_110_111,
               30'b010_110_000_100_111_010_100_110_100_101
             }; // nothing should be clean out
      @(posedge clk);
      enable <= 0;
      @(posedge clk);
      enable <= 1;
      @(posedge done);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      $stop;
    end
endmodule
