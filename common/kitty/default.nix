{ config, pkgs, lib, ... }: {
   programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines           = 10000;
      enable_audio_bell          = false;
      tab_bar_style              = "separator";

      font_family                = "Operator Mono Lig Book";
      bold_font                  = "Operator Mono Lig Book";
      italic_font                = "Operator Mono Lig Book Italic";
      bold_italic_font           = "Operator Mono Lig Book Italic";
      font_size                  = "13";

      single_window_margin_width = 0;
      window_margin_width        = 0;
      window_padding_width       = 0;
      window_border_width        = 0;
      hide_window_decorations    = false;
      placement_strategy         = "top-left";

      #background                 = "#0d1117";
      background                 = "#080808";
      foreground                 = "#c5d4d6";
      cursor                     = "#9d9eca";
      selection_background       = "#454d95";
      # black
      color0                     = "#333333";
      color8                     = "#8e8e8e";
      # red
      color1                     = "#d46b5d";
      color9                     = "#ffc4bd";
      # green
      color2                     = "#316b50";
      color10                    = "#d6fcb9";
      #yellow
      color3                     = "#b3b163";
      color11                    = "#fefdd5";
      # blue
      color4                     = "#347785";
      color12                    = "#477ab3";
      # magenta
      color5                     = "#5e468c";
      color13                    = "#ffb1fe";
      # cyan
      color6                     = "#d0d1fe";
      color14                    = "#e5e6fe";
      # white
      color7                     = "#f1f1f1";
      color15                    = "#feffff";
      selection_foreground       = "#101010";

      background_opacity         = "0.97";
      dynamic_background_opacity = true;
      dim_opacity                = "0.9";
      allow_remote_control       = true;
    };
    extraConfig = (lib.strings.fileContents ./extra.conf);
  };
}
