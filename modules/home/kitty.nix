{ vars, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = vars.monoFont.name;
      size = vars.monoFont.size;
    };
    settings = {
      cursor_shape        = "beam";
      enable_audio_bell   = "yes";
      background_opacity  = "0.96";
      background_blur     = 0;
      allow_remote_control = "socket-only";
      listen_on           = "unix:/tmp/kitty";

      # Gruvbox Dark theme
      selection_foreground = "#ebdbb2";
      selection_background = "#d65d0e";
      background           = "#282828";
      foreground           = "#ebdbb2";
      cursor               = "#bdae93";
      cursor_text_color    = "#665c54";
      url_color            = "#458588";

      color0  = "#3c3836";
      color1  = "#cc241d";
      color2  = "#98971a";
      color3  = "#d79921";
      color4  = "#458588";
      color5  = "#b16286";
      color6  = "#689d6a";
      color7  = "#a89984";
      color8  = "#928374";
      color9  = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#fbf1c7";
    };
    keybindings = {
      "alt+shift+1"  = "goto_tab 1";
      "alt+shift+2"  = "goto_tab 2";
      "alt+shift+3"  = "goto_tab 3";
      "alt+shift+4"  = "goto_tab 4";
      "alt+shift+5"  = "goto_tab 5";
      "alt+shift+6"  = "goto_tab 6";
      "alt+shift+7"  = "goto_tab 7";
      "alt+shift+8"  = "goto_tab 8";
      "alt+shift+9"  = "goto_tab 9";
      "alt+shift+0"  = "goto_tab 10";
      "ctrl+tab"     = "goto_tab -1";
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+w" = "close_tab";
      "ctrl+y"       = "copy_last_command_output";
    };
};
}
