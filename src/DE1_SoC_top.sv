`include "../src/GLOBAL.sv"
// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// ============================================================================
//
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Thu Jul 11 11:26:45 2013
// ============================================================================

//`define ENABLE_ADC
//`define ENABLE_AUD
//`define ENABLE_CLOCK2
//`define ENABLE_CLOCK3
//`define ENABLE_CLOCK4
`define ENABLE_CLOCK
//`define ENABLE_DRAM
//`define ENABLE_FAN
//`define ENABLE_FPGA
//`define ENABLE_GPIO
//`define ENABLE_HEX
//`define ENABLE_HPS
//`define ENABLE_IRDA
//`define ENABLE_KEY
//`define ENABLE_LEDR
`define ENABLE_PS2
`define ENABLE_SW
//`define ENABLE_TD
`define ENABLE_VGA

module DE1_SoC_top(

    /* Enables ADC - 3.3V */
`ifdef ENABLE_ADC

    output             ADC_CONVST,
    output             ADC_DIN,
    input              ADC_DOUT,
    output             ADC_SCLK,

`endif

    /* Enables AUD - 3.3V */
`ifdef ENABLE_AUD

    input              AUD_ADCDAT,
    inout              AUD_ADCLRCK,
    inout              AUD_BCLK,
    output             AUD_DACDAT,
    inout              AUD_DACLRCK,
    output             AUD_XCK,

`endif

    /* Enables CLOCK2  */
`ifdef ENABLE_CLOCK2
    input              CLOCK2_50,
`endif

    /* Enables CLOCK3 */
`ifdef ENABLE_CLOCK3
    input              CLOCK3_50,
`endif

    /* Enables CLOCK4 */
`ifdef ENABLE_CLOCK4
    input              CLOCK4_50,
`endif

    /* Enables CLOCK */
`ifdef ENABLE_CLOCK
    input              CLOCK_50,
`endif

    /* Enables DRAM - 3.3V */
`ifdef ENABLE_DRAM
    output      [12:0] DRAM_ADDR,
    output      [1:0]  DRAM_BA,
    output             DRAM_CAS_N,
    output             DRAM_CKE,
    output             DRAM_CLK,
    output             DRAM_CS_N,
    inout       [15:0] DRAM_DQ,
    output             DRAM_LDQM,
    output             DRAM_RAS_N,
    output             DRAM_UDQM,
    output             DRAM_WE_N,
`endif

    /* Enables FAN - 3.3V */
`ifdef ENABLE_FAN
    output             FAN_CTRL,
`endif

    /* Enables FPGA - 3.3V */
`ifdef ENABLE_FPGA
    output             FPGA_I2C_SCLK,
    inout              FPGA_I2C_SDAT,
`endif

    /* Enables GPIO - 3.3V */
`ifdef ENABLE_GPIO
    inout     [35:0]         GPIO_0,
    inout     [35:0]         GPIO_1,
`endif


    /* Enables HEX - 3.3V */
`ifdef ENABLE_HEX
    output      [6:0]  HEX0,
    output      [6:0]  HEX1,
    output      [6:0]  HEX2,
    output      [6:0]  HEX3,
    output      [6:0]  HEX4,
    output      [6:0]  HEX5,
`endif

    /* Enables HPS */
`ifdef ENABLE_HPS
    inout              HPS_CONV_USB_N,
    output      [14:0] HPS_DDR3_ADDR,
    output      [2:0]  HPS_DDR3_BA,
    output             HPS_DDR3_CAS_N,
    output             HPS_DDR3_CKE,
    output             HPS_DDR3_CK_N, //1.5V
    output             HPS_DDR3_CK_P, //1.5V
    output             HPS_DDR3_CS_N,
    output      [3:0]  HPS_DDR3_DM,
    inout       [31:0] HPS_DDR3_DQ,
    inout       [3:0]  HPS_DDR3_DQS_N,
    inout       [3:0]  HPS_DDR3_DQS_P,
    output             HPS_DDR3_ODT,
    output             HPS_DDR3_RAS_N,
    output             HPS_DDR3_RESET_N,
    input              HPS_DDR3_RZQ,
    output             HPS_DDR3_WE_N,
    output             HPS_ENET_GTX_CLK,
    inout              HPS_ENET_INT_N,
    output             HPS_ENET_MDC,
    inout              HPS_ENET_MDIO,
    input              HPS_ENET_RX_CLK,
    input       [3:0]  HPS_ENET_RX_DATA,
    input              HPS_ENET_RX_DV,
    output      [3:0]  HPS_ENET_TX_DATA,
    output             HPS_ENET_TX_EN,
    inout       [3:0]  HPS_FLASH_DATA,
    output             HPS_FLASH_DCLK,
    output             HPS_FLASH_NCSO,
    inout              HPS_GSENSOR_INT,
    inout              HPS_I2C1_SCLK,
    inout              HPS_I2C1_SDAT,
    inout              HPS_I2C2_SCLK,
    inout              HPS_I2C2_SDAT,
    inout              HPS_I2C_CONTROL,
    inout              HPS_KEY,
    inout              HPS_LED,
    inout              HPS_LTC_GPIO,
    output             HPS_SD_CLK,
    inout              HPS_SD_CMD,
    inout       [3:0]  HPS_SD_DATA,
    output             HPS_SPIM_CLK,
    input              HPS_SPIM_MISO,
    output             HPS_SPIM_MOSI,
    inout              HPS_SPIM_SS,
    input              HPS_UART_RX,
    output             HPS_UART_TX,
    input              HPS_USB_CLKOUT,
    inout       [7:0]  HPS_USB_DATA,
    input              HPS_USB_DIR,
    input              HPS_USB_NXT,
    output             HPS_USB_STP,
`endif

    /* Enables IRDA - 3.3V */
`ifdef ENABLE_IRDA
    input              IRDA_RXD,
    output             IRDA_TXD,
`endif

    /* Enables KEY - 3.3V */
`ifdef ENABLE_KEY
    input       [3:0]  KEY,
`endif

    /* Enables LEDR - 3.3V */
`ifdef ENABLE_LEDR
    output      [9:0]  LEDR,
`endif

    /* Enables PS2 - 3.3V */
`ifdef ENABLE_PS2
    inout              PS2_CLK,
    inout              PS2_CLK2,
    inout              PS2_DAT,
    inout              PS2_DAT2,
`endif

    /* Enables SW - 3.3V */
`ifdef ENABLE_SW
    input       [9:0]  SW,
`endif

    /* Enables TD - 3.3V */
`ifdef ENABLE_TD
    input             TD_CLK27,
    input      [7:0]  TD_DATA,
    input             TD_HS,
    output            TD_RESET_N,
    input             TD_VS,
`endif

    /* Enables VGA - 3.3V */
`ifdef ENABLE_VGA
    output      [7:0]  VGA_B,
    output             VGA_BLANK_N,
    output             VGA_CLK,
    output      [7:0]  VGA_G,
    output             VGA_HS,
    output      [7:0]  VGA_R,
    output             VGA_SYNC_N,
    output             VGA_VS
`endif
  );


  //=======================================================
  //  REG/WIRE declarations
  //=======================================================
  logic [23:0] color, fieldColor, scoreColor, scoreStringColor, levelColor, levelStringColor, vga_color;
  logic CLOCK_74;

  field_t  disp; // field to display

  logic     [10:0]    x, y; // x, y generated by VGA driver

  logic               fieldEnable;

  logic [26:0]  score;
  logic         newgame, pause, left, right, rotate_clock;
  logic         rotate_counter_clock, down, hard_drop, soft_drop, reset_down;
  logic [3:0]   level;
  logic         isLost, drawScoreEnable, drawScoreStringEnable, drawLevelEnable, drawLevelStringEnable;
  logic         valid_74, makeBreak_74;
  logic   [7:0] outCode_74;

  logic [12:0]    rom_addr;
  logic [23:0]    rom_color;
  //=======================================================
  //  Structural coding
  //=======================================================

  // generate signal based on key press
  keyboard_to_1_clock  #(
                         .SCAN_CODE(`RIGHT_ARROW_C)
                       ) k_right (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(right)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`LEFT_ARROW_C)
                       ) k_left (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(left)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`DOWN_ARROW_C)
                       ) k_down (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(soft_drop)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`ESC_C)
                       ) k_esc (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(pause)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`SPACE_C)
                       ) k_space (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(hard_drop)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`X_KEY_C)
                       ) k_X (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(rotate_clock)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`Z_KEY_C)
                       ) k_Z (
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(rotate_counter_clock)
                       );

  keyboard_to_1_clock  #(
                         .SCAN_CODE(`N_KEY_C)
                       ) k_N(
                         .clk(CLOCK_74),
                         .scanCode(outCode_74),
                         .makeBreak(makeBreak_74),
                         .signal(newgame)
                       );

  // driver for keyboard
  keyboard_CLOCK74 keyboard_driver (
                     .CLOCK_50,
                     .CLOCK_74,
                     .valid_74, .makeBreak_74,
                     .outCode_74,
                     .PS2_DAT, // PS2 data line
                     .PS2_CLK, // PS2 clock line
                     .reset (SW[9])
                   );

  // generate the down signal
  down_signal_gen system_event (
                    .clk(CLOCK_74), .rst(reset_down), .soft_drop,
                    .level,
                    .down_signal(down)
                  );

  // main game logic
  game_control main_game (
                 .*,
                 .clk(CLOCK_74),
                 .display(disp)
               );

  // drawing score
  draw_number #(
                .NUM_DISPLAY(8),
                .INPUT_WIDTH(27),
                .START_X(1000),
                .START_Y(100),
                .NUM_COLOR(24'h00_00_00)
              ) score_draw (
                .clk(CLOCK_74),
                .x, .y,
                .in(score),
                .enable(drawScoreEnable),
                .color(scoreColor)
              );

  // drawing the string "SCORE:" next to score
  draw_string #(
                .STR("SCORE:"),
                .START_X(904),
                .START_Y(100),
                .STRING_COLOR(24'h00_00_00)
              )draw_score_string (
                .clk(CLOCK_74),
                .x, .y,
                .enable(drawScoreStringEnable),
                .color(scoreStringColor)
              );

  // drawing the string "LEVEL:" next to level
  draw_string #(
                .STR("LEVEL:"),
                .START_X(904),
                .START_Y(132),
                .STRING_COLOR(24'h00_00_00)
              ) draw_level_string (
                .clk(CLOCK_74),
                .x, .y,
                .enable(drawLevelStringEnable),
                .color(levelStringColor)
              );

  // drawing level number 
  draw_number #(
                .NUM_DISPLAY(2),
                .INPUT_WIDTH(4),
                .START_X(1000),
                .START_Y(132),
                .NUM_COLOR(24'h00_00_00)
              ) draw_level (
                .clk(CLOCK_74),
                .x, .y,
                .in(level),
                .enable(drawLevelEnable),
                .color(levelColor)
              );

  // drawing strng "GAME OVER"
  draw_string #(
                .STR("GAME OVER!!!"),
                .START_X(904),
                .START_Y(260),
                .STRING_COLOR(24'h90_00_00)
              ) draw_game_over (
                .clk(CLOCK_74),
                .x, .y,
                .enable(gameOverEnable),
                .color(gameOverColor)
              );
			
  // what to draw depend on what enable signal is high
  always_comb
    begin
      vga_color = color;
      if (fieldEnable)
        vga_color = fieldColor;
      if (drawScoreStringEnable)
        vga_color = scoreStringColor;
      if (drawScoreEnable)
        vga_color = scoreColor;
      if (drawLevelStringEnable)
        vga_color = levelStringColor;
      if (drawLevelEnable)
        vga_color = levelColor;
		if (isLost && gameOverEnable)
		  vga_color = gameOverColor;
    end

  // CLOCK_74 for 1280x720 display
  pll_74 pll (CLOCK_50, SW[9], CLOCK_74);

  waifu background (
    .clk(CLOCK_74),
    .x(x), .y(y),
    .waifuColor(color)
  );

  draw_field_rom field_drawer (
                   .clk(CLOCK_74),
                   .f(disp),
                   .x(x), .y(y),
                   // read color from rom
                   .rom_addr(rom_addr),
                   .rom_color(rom_color),

                   .color(fieldColor),
                   .drawEnable(fieldEnable)
                 );

  tetris_rom tetris_color_rom (
               .address(rom_addr),
               .clock(CLOCK_74),
               .q(rom_color)
             );

  // VGA controller
  VGA_Ctrl vga  (
             //  Host Side
             vga_color,
             x,
             y,
             //  VGA Side
             VGA_R,
             VGA_G,
             VGA_B,
             VGA_HS,
             VGA_VS,
             VGA_SYNC_N,
             VGA_BLANK_N,
             VGA_CLK,
             //  Control Signal
             CLOCK_74,
             ~SW[9]);
endmodule
