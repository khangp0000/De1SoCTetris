`include "GLOBAL.sv"
// main logic of controlling game
module game_control (
    // input
    input   logic         clk,
    input   logic         newgame, pause, left, right, rotate_clock,
    input   logic         rotate_counter_clock, down, hard_drop,
	 // output
    output  logic         isLost, reset_down,
    output  field_t       display,
    output  logic [26:0]  score = 0,
    output  logic [3:0]   level
  );

  // main game state
  enum {gen_s, idle_s, pause_s, left_s, right_s, rotate_c_s, rotate_cc_s, down_s, clean_s, lost_s} ps = gen_s, ns;
  
  // input / output of modules
  logic valid, rotate_c_done, rotate_cc_done, rotate_c_failed, rotate_cc_failed, clean_done;
  logic [2:0] linesDeleted;

  // different type of tetromino
  tetromino_ctrl t_left, t_right, t_down, t_rotate_c, t_rotate_cc, t_check_valid, t_curr, t_gen, t_gen_next;
  
  // current, display and line cleaned field
  field_t f_curr = '1, f_disp, f_cleaned;


  assign display = f_disp;
  assign isLost = ps == lost_s;
  assign reset_down = (ps == gen_s) || (ps == down_s);

  // isHardDrop become true when harddrop signal received during idle_s and only went back low when state is
  // state is back to gen_s
  logic isHardDrop = 0;
  always_ff @(posedge clk) begin
    if (ps == gen_s)
		isHardDrop <= 0;
	 else if (ps == idle_s && hard_drop)
		isHardDrop <= 1;
  end
  
  always_comb
    begin
      // left tetromino always has x coordinate decreased by 1
      t_left = t_curr;
      t_left.coordinate.x = t_left.coordinate.x - 1;

      // right tetromino always has x coordinate increased by 1
      t_right = t_curr;
      t_right.coordinate.x = t_right.coordinate.x + 1;

      // down tetromino always has y coordinate increased by 1
      t_down = t_curr;
      t_down.coordinate.y = t_down.coordinate.y + 1;

      // depend on the state, the tetromino being connected to check_valid module is different
      case (ps)
        gen_s:
          t_check_valid = t_gen;
        left_s:
          t_check_valid = t_left;
        right_s:
          t_check_valid = t_right;
        down_s:
          t_check_valid = t_down;
        rotate_c_s:
          t_check_valid = t_rotate_c;
        rotate_cc_s:
          t_check_valid = t_rotate_cc;
        default:
          t_check_valid = 'x;
      endcase
    end

  // rotating module
  rotate_clockwise rotate_c (clk, ps == rotate_c_s, valid, t_curr, t_rotate_c, rotate_c_failed, rotate_c_done);
  rotate_counter_clockwise rotate_cc (clk, ps == rotate_cc_s, valid, t_curr, t_rotate_cc, rotate_cc_failed, rotate_cc_done);

  // field cleaning module
  clean_field cleaner (clk, ps == clean_s, f_curr, f_cleaned, linesDeleted, clean_done);

  // check if combination of tetomino and field is valid module
  check_valid validify (t_check_valid, f_curr, valid);

  // generating new tetromino module
  generate_tetromino gen (clk, ps == gen_s, t_gen, t_gen_next);

  // create field to display by combining current field with current tetromino
  create_field field_parse (t_curr, f_curr, f_disp);

  // State machine logic
  always_comb
    begin
      ns = ps;
      case (ps)
        gen_s:
          if (valid)
            ns = idle_s;
          else
            ns = lost_s;
        idle_s:
          if (pause)
            ns = pause_s;
          else if (down || isHardDrop)
            ns = down_s;
          else if (left)
            ns = left_s;
          else if (right)
            ns = right_s;
          else if (rotate_clock)
            ns = rotate_c_s;
          else if (rotate_counter_clock)
            ns = rotate_cc_s;
        pause_s:
          if (pause)
            ns = idle_s;
        left_s:
          ns = idle_s;
        right_s:
          ns = idle_s;
        rotate_c_s:
          if (rotate_c_done)
            ns = idle_s;
        rotate_cc_s:
          if (rotate_cc_done)
            ns = idle_s;
        down_s:
          if (valid)
            ns = idle_s;
          else
            ns = clean_s;
        clean_s:
          if (clean_done)
            ns = gen_s;
        default:
          ;
      endcase
    end

  // level and score calculation logic logic
  integer i;
  logic [23:0] score_n;
  always_comb
    begin
      if (score < 512)
        level = 0;
      else if (score < 1024)
        level = 1;
      else if (score < 1536)
        level = 2;
      else if (score < 2048)
        level = 3;
      else if (score < 3072)
        level = 4;
      else if (score < 4096)
        level = 5;
      else if (score < 6144)
        level = 6;
      else if (score < 8192)
        level = 7;
      else if (score < 12288)
        level = 8;
      else if (score < 16384)
        level = 9;
      else if (score < 24576)
        level = 10;
      else if (score < 32768)
        level = 11;
      else if (score < 49152)
        level = 12;
      else if (score < 65536)
        level = 13;
      else if (score < 98304)
        level = 14;
      else
        level = 15;

      score_n = score + 4 + 4*level;
      case (linesDeleted)
        0:
          ;
        1:
          score_n = score + level*44 + 44 + (isHardDrop ? 40 : 0);
        2:
          score_n = score + level*104 + 104 + (isHardDrop ? 100 : 0);
        3:
          score_n = score + level*304 + 304 + (isHardDrop ? 300 : 0);
        default:
          score_n = score + level*1204 + 1204 + (isHardDrop ? 1200 : 0);
      endcase

      // I only display 8 digit max
      if (score_n > 99_999_999)
        score_n = 99_999_999;
    end

  // flip flop logic
  always_ff @(posedge clk)
    begin
      if (newgame)
        begin
          ps <= gen_s;
          f_curr.data <= '1;
          score <= 0;
        end
      else
        begin
          ps <= ns;
          case (ps)
            gen_s:
              t_curr <= t_gen;
            left_s:
              if (valid)
                t_curr <= t_left;
            right_s:
              if (valid)
                t_curr <= t_right;
            down_s:
              if (valid)
                t_curr <= t_down;
              else
                f_curr <= f_disp;
            rotate_c_s:
              if (rotate_c_done & ~rotate_c_failed)
                t_curr <= t_rotate_c;
            rotate_cc_s:
              if (rotate_cc_done & ~rotate_cc_failed)
                t_curr <= t_rotate_cc;
            clean_s:
              if (clean_done)
                begin
                  f_curr <= f_cleaned;
                  score <= score_n;
                end
          endcase
        end
    end
endmodule
