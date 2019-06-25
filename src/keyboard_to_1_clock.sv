`include "GLOBAL.sv"

// input from keyboard to output 1 clock signal
module keyboard_to_1_clock #(
    parameter SCAN_CODE = `SPACE_C
  )(
    input   logic       clk,
    input   logic [7:0] scanCode,
    input   logic       makeBreak,
    output  logic       signal
  );

  enum {idle, press, hold} state = idle;

  always_ff @(posedge clk)
    if (scanCode == SCAN_CODE)
      if (~makeBreak)
        // released
        state <= idle;
      else
        // pressed
        case (state)
          idle :
            if (scanCode == SCAN_CODE)
              state <= press;
          press :
            // state not change until release
            state <= hold;
          default:
            ;
        endcase

  assign signal = state == press;
endmodule
