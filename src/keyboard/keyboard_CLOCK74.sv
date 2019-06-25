// Make keyboard on CLOCK_74 from clock_50
module keyboard_CLOCK74 (
    input   logic   CLOCK_50,
    input   logic   CLOCK_74,
    output  logic   valid_74, makeBreak_74,
    output  logic   [7:0] outCode_74,
    input   logic   PS2_DAT, // PS2 data line
    input   logic   PS2_CLK, // PS2 clock line
    input reset
  );

  logic valid, makeBreak, rdempty, wrfull;
  logic   [7:0] outCode;

  keyboard_press_driver keyboard_inner (
                          .CLOCK_50,
                          .valid, .makeBreak,
                          .outCode,
                          .PS2_DAT, // PS2 data line
                          .PS2_CLK, // PS2 clock line
                          .reset
                        );

  keyboard_fifo key_fifo (
      .data({valid, makeBreak, outCode}),
      .rdclk(CLOCK_74),
      .rdreq(~rdempty),
      .wrclk(CLOCK_50),
      .wrreq(~wrfull),
      .q({valid_74, makeBreak_74, outCode_74}),
      .rdempty,
      .wrfull);

endmodule
