`include "../GLOBAL.sv"

module  VGA_Ctrl  (  //  Host Side
    color,
    oCurrent_X,
    oCurrent_Y,
    //  VGA Side
    oVGA_R,
    oVGA_G,
    oVGA_B,
    oVGA_HS,
    oVGA_VS,
    oVGA_SYNC,
    oVGA_BLANK,
    oVGA_CLOCK,
    //  Control Signal
    iCLK,
    iRST_N  );
  //  Host Side
  input     [23:0]  color;
  output    [10:0]  oCurrent_X;
  output    [10:0]  oCurrent_Y;
  //  VGA Side
  output    [7:0]   oVGA_R;
  output    [7:0]   oVGA_G;
  output    [7:0]   oVGA_B;
  output    reg     oVGA_HS;
  output    reg     oVGA_VS;
  output            oVGA_SYNC;
  output            oVGA_BLANK;
  output            oVGA_CLOCK;
  //  Control Signal
  input        iCLK;
  input        iRST_N;
  //  Internal Registers
  reg      [10:0]  H_Cont;
  reg      [10:0]  V_Cont;
  ////////////////////////////////////////////////////////////
  //  Horizontal  Parameter
  parameter  H_FRONT  =  110;
  parameter  H_SYNC   =  40;
  parameter  H_BACK   =  220;
  parameter  H_ACT    =  1280;
  parameter  H_BLANK  =  H_FRONT+H_SYNC+H_BACK;
  parameter  H_TOTAL  =  H_FRONT+H_SYNC+H_BACK+H_ACT;
  ////////////////////////////////////////////////////////////
  //  Vertical Parameter
  parameter  V_FRONT  =  5;
  parameter  V_SYNC   =  5;
  parameter  V_BACK   =  20;
  parameter  V_ACT    =  720;
  parameter  V_BLANK  =  V_FRONT+V_SYNC+V_BACK;
  parameter  V_TOTAL  =  V_FRONT+V_SYNC+V_BACK+V_ACT;
  ////////////////////////////////////////////////////////////
  assign  oVGA_SYNC   =  1'b1;      //  This pin is unused.
  assign  oVGA_BLANK  =  ~((H_Cont<H_BLANK)||(V_Cont<V_BLANK));
  assign  oVGA_CLOCK  =  iCLK;
  assign  oVGA_R      =  color[23:16];
  assign  oVGA_G      =  color[15:8];
  assign  oVGA_B      =  color[7:0];
  assign  oAddress    =  oCurrent_Y*H_ACT+oCurrent_X;
  assign  oRequest    =  ((H_Cont>=H_BLANK && H_Cont<H_TOTAL)  &&
                          (V_Cont>=V_BLANK && V_Cont<V_TOTAL));
  assign  oCurrent_X  =  (H_Cont>=H_BLANK)  ?  H_Cont-H_BLANK  :  11'h0  ;
  assign  oCurrent_Y  =  (V_Cont>=V_BLANK)  ?  V_Cont-V_BLANK  :  11'h0  ;

  //  Horizontal Generator: Refer to the pixel clock
  always@(posedge iCLK or negedge iRST_N)
    begin
      if(!iRST_N)
        begin
          H_Cont    <=  0;
          oVGA_HS   <=  1;
        end
      else
        begin
          if(H_Cont < H_TOTAL)
            H_Cont  <=  H_Cont+1'b1;
          else
            H_Cont  <=  0;
          //  Horizontal Sync
          if(H_Cont==H_FRONT-1)      //  Front porch end
            oVGA_HS <=  1'b0;
          if(H_Cont==H_FRONT+H_SYNC-1)  //  Sync pulse end
            oVGA_HS <=  1'b1;
        end
    end

  //  Vertical Generator: Refer to the horizontal sync
  always@(posedge oVGA_HS or negedge iRST_N)
    begin
      if(!iRST_N)
        begin
          V_Cont    <=  0;
          oVGA_VS   <=  1;
        end
      else
        begin
          if(V_Cont < V_TOTAL)
            V_Cont  <=  V_Cont+1'b1;
          else
            V_Cont  <=  0;
          //  Vertical Sync
          if(V_Cont == V_FRONT-1)      //  Front porch end
            oVGA_VS <=  1'b0;
          if(V_Cont ==  V_FRONT+V_SYNC-1)  //  Sync pulse end
            oVGA_VS <=  1'b1;
        end
    end
endmodule
