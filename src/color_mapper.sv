`include "GLOBAL.sv"
module color_mapper (
    input   color_t color_idx,
    output  logic   [23:0] color
  );

  always
    begin
      case (color_idx.data)
        `C_BLACK :
          color = 24'h00_00_00;   // pitch black
        `C_FREE1 :
          color = 24'hb9_7a_56;   // Dirt brown
        `C_FREE2 :
          color = 24'he4_9a_9d;   // Between brow and pink
        `C_FREE3 :
          color = 24'hff_ae_c8;   // To be decided
        `C_FREE4 :
          color = 24'hxx_xx_xx;   // To be decided
        `C_FREE5 :
          color = 24'hxx_xx_xx;   // To be decided
        `C_FREE6 :
          color = 24'hxx_xx_xx;   // To be decided
        `C_FREE7 :
          color = 24'hxx_xx_xx;   // To be decided
        `COLOR_I :
          color = 24'h00_f0_f0;   // sky blue
        `COLOR_J :
          color = 24'h00_00_f0;   // dark ocean blue
        `COLOR_L :
          color = 24'hf0_a0_00;   // orange
        `COLOR_O :
          color = 24'hf0_f0_00;   // yellow
        `COLOR_S :
          color = 24'h00_f0_00;   // green
        `COLOR_T :
          color = 24'ha0_00_f0;   // purple
        `COLOR_Z :
          color = 24'hf0_00_00;   // red
        `C_WHITE :
          color = 24'hff_ff_ff;   // pure white
      endcase
    end


endmodule
