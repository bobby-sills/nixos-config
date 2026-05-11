{ lib, ... }:
let
  gb = import ../gruvbox.nix;
  hex = c: lib.removePrefix "#" c;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = ",preferred,auto,1.25";

      "$terminal" = "kitty";
      "$fileManager" = "kitty -e yazi";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      exec-once = [
        "hyprctl setcursor Adwaita 24"
        "waybar"
        "hyprsunset"
        "swayosd-server"
      ];

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(${hex gb.bright_orange}ff)";
        "col.inactive_border" = "rgba(${hex gb.dark1}aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
        animate_manual_resizes = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, T, togglefloating,"
        "$mainMod SHIFT, T, setfloating,"
        "$mainMod SHIFT, T, resizeactive, exact 50% 50%"
        "$mainMod SHIFT, T, centerwindow,"
        "$mainMod CTRL, T, setfloating,"
        "$mainMod CTRL, T, resizeactive, exact 75% 75%"
        "$mainMod CTRL, T, centerwindow,"
        "$mainMod, Space, exec, $menu"
        "$mainMod, Escape, exec, hyprlock"
        "$mainMod SHIFT, Escape, exec, systemctl suspend"

        "$mainMod, R, layoutmsg, togglesplit"
        "$mainMod, H, movefocus, l"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"
        "$mainMod, L, movefocus, r"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, P, togglespecialworkspace, spotify"
        "$mainMod, M, togglespecialworkspace, beeper"
        "$mainMod, Tab, workspace, previous"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod CTRL, S, exec, hyprshot -z -m region -o ~/Pictures/screenshots"
        "$mainMod SHIFT CTRL, S, exec, hyprshot -z -m output -m active -o ~/Pictures/screenshots"
        "$mainMod, BackSpace, exec, makoctl dismiss"
        "$mainMod, Y, exec, $fileManager"
        "$mainMod, W, exec, pkill -SIGUSR1 waybar"
        "$mainMod, U, exec, case $(powerprofilesctl get) in power-saver) powerprofilesctl set balanced;; balanced) powerprofilesctl set performance;; performance) powerprofilesctl set power-saver;; esac"
        "$mainMod, F, fullscreenstate, 0, 2"
        "$mainMod SHIFT, F, fullscreen, 0"
        "$mainMod, E, exec, bemoji"
        "$mainMod, comma, exec, playerctl previous"
        "$mainMod, period, exec, playerctl next"
        "$mainMod, slash, exec, playerctl play-pause"
      ];

      binde = [
        "$mainMod SHIFT, H, resizeactive, -40 0"
        "$mainMod SHIFT, J, resizeactive, 0 40"
        "$mainMod SHIFT, K, resizeactive, 0 -40"
        "$mainMod SHIFT, L, resizeactive, 40 0"
        "$mainMod CTRL, H, moveactive, -40 0"
        "$mainMod CTRL, J, moveactive, 0 40"
        "$mainMod CTRL, K, moveactive, 0 -40"
        "$mainMod CTRL, L, moveactive, 40 0"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ",F6, exec, swayosd-client --brightness raise"
        ",F5, exec, swayosd-client --brightness lower"
        "$mainMod, XF86MonBrightnessUp, exec, hyprctl hyprsunset temperature +500"
        "$mainMod, XF86MonBrightnessDown, exec, hyprctl hyprsunset temperature -500"
        "$mainMod, F6, exec, hyprctl hyprsunset temperature +500"
        "$mainMod, F5, exec, hyprctl hyprsunset temperature -500"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrule = [
        {
          name = "float-75";
          "match:class" = "float-75";
          float = true;
          size = "(monitor_w*0.75) (monitor_h*0.75)";
          center = true;
        }
        {
          name = "float-50";
          "match:class" = "float-50";
          float = true;
          size = "(monitor_w*0.5) (monitor_h*0.5)";
          center = true;
        }
        {
          name = "beeper-special";
          "match:class" = "beepertexts";
          workspace = "special:beeper";
          float = true;
          size = "(monitor_w*0.5) (monitor_h*0.5)";
          center = true;
        }
        {
          name = "suppress-maximize-events";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;
          no_focus = true;
        }
        {
          name = "no-gaps-wtv1";
          "match:float" = false;
          "match:workspace" = "w[tv1]";
          border_size = 0;
          rounding = 0;
        }
        {
          name = "no-gaps-f1";
          "match:float" = false;
          "match:workspace" = "f[1]";
          border_size = 0;
          rounding = 0;
        }
      ];

    };

    extraConfig = ''

      gesture = 3, horizontal, workspace

      bind = $mainMod, O, submap, browser

      submap = browser
      bind = , H, exec, helium --profile-directory=Default
      bind = , H, submap, reset
      bind = , M, exec, beeper
      bind = , M, submap, reset
      bind = , S, exec, helium --profile-directory="Profile 1"
      bind = , S, submap, reset
      bind = , B, exec, kitty --class float-50 -e bluetui
      bind = , B, submap, reset
      bind = , W, exec, kitty --class float-50 -e impala
      bind = , W, submap, reset
      bind = , P, exec, [workspace special:spotify silent; float; size (monitor_w*0.5) (monitor_h*0.5); center] kitty -e spotify_player
      bind = , P, submap, reset
      bind = , escape, submap, reset
      submap = reset
    '';
  };

}
