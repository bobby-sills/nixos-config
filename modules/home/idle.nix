{ ... }:
let
  gb = import ../gruvbox.nix;
  vars = import ../../vars.nix;
in
{
  services.batsignal.enable = true;

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "";
          color = "rgb(${builtins.substring 1 6 gb.dark0})";
          blur_passes = 0;
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +%H:%M";
          font_size = 72;
          font_family = vars.monoFont.name;
          color = "rgb(${builtins.substring 1 6 gb.light1})";
          position = "0, -25%";
          halign = "center";
          valign = "top";
        }
      ];

      animations = {
        enabled = true;
      };

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 2;
          outer_color = "rgb(${builtins.substring 1 6 gb.bright_orange})";
          inner_color = "rgb(${builtins.substring 1 6 gb.dark0})";
          font_color = "rgb(${builtins.substring 1 6 gb.light1})";
          check_color = "rgb(${builtins.substring 1 6 gb.bright_orange})";
          fail_color = "rgb(${builtins.substring 1 6 gb.bright_red})";
          rounding = 10;
          font_size = vars.monoFont.size * 2;
          font_family = vars.monoFont.name;
          fade_on_empty = true;
          placeholder_text = "";
          fail_text = "<i>$FAIL ($ATTEMPTS)</i>";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on; loginctl lock-session";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "brightnessctl -s set 20%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
