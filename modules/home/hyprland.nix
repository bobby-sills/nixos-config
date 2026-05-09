{ lib, ... }:
let
  animNames = [
    "animations-classic"
    "animations-dynamic"
    "animations-end4"
    "animations-fast"
    "animations-high"
    "animations-moving"
    "animations-smooth"
    "default"
    "disabled"
    "standard"
  ];
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
        "sh -c 'sleep 2 && if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then echo 1; else echo 0; fi > /sys/class/leds/platform::micmute/brightness'"
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
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
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

        "$mainMod, T, togglesplit,"
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
        "$mainMod CTRL, S, exec, hyprshot -m region -o ~/Pictures/screenshots"
        "$mainMod SHIFT CTRL, S, exec, hyprshot -m output -o ~/Pictures/screenshots"
        "$mainMod, BackSpace, exec, makoctl dismiss"
        "$mainMod, Y, exec, $fileManager"
        "$mainMod, W, exec, pkill -SIGUSR1 waybar"
        "$mainMod, F, fullscreenstate, 0, 2"
        "$mainMod SHIFT, F, fullscreen, 0"
        "$mainMod, A, exec, ~/.config/hypr/cycle-animations.sh"
        "$mainMod, equal, exec, ~/.config/hypr/wofi-calc.sh"
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
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, ~/.config/hypr/mic-mute-toggle.sh"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ",F6, exec, brightnessctl -e4 -n2 set 5%+"
        ",F5, exec, brightnessctl -e4 -n2 set 5%-"
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
      source = ~/.config/hypr/current-animation.conf

      layerrule = no_anim on, match:namespace wofi

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

  home.file = (lib.listToAttrs (map (name: {
    name = ".config/hypr/animations/${name}.conf";
    value = { source = ./animations/${name}.conf; };
  }) animNames)) // {
    ".config/hypr/wofi-calc.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        HISTORY="$HOME/.config/qalculate/qalc.result.history"
        mkdir -p "$(dirname "$HISTORY")"
        touch "$HISTORY"

        while true; do
          input=$(tac "$HISTORY" | wofi --dmenu --prompt "= " --lines 10)
          [ -z "$input" ] && break
          result=$(qalc -t "$input" 2>/dev/null | tail -1)
          [ -z "$result" ] && break
          entry="$input = $result"
          echo "$entry" >> "$HISTORY"
          printf '%s' "$result" | wl-copy
          hyprctl notify 1 4000 "rgb(88ccff)" "$entry"
        done
      '';
    };
    ".config/hypr/mic-mute-toggle.sh" = {
      executable = true;
      text = ''
        #!/bin/sh
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
          echo 1 > /sys/class/leds/platform::micmute/brightness
        else
          echo 0 > /sys/class/leds/platform::micmute/brightness
        fi
      '';
    };
    ".config/hypr/cycle-animations.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        ANIM_DIR="$HOME/.config/hypr/animations"
        STATE_FILE="$HOME/.cache/hypr-anim-current"
        CURRENT_CONF="$HOME/.config/hypr/current-animation.conf"

        mapfile -t FILES < <(ls "$ANIM_DIR"/*.conf | sort)
        COUNT=''${#FILES[@]}

        NEXT_IDX=0
        if [ -f "$STATE_FILE" ]; then
          CURRENT=$(cat "$STATE_FILE")
          for i in "''${!FILES[@]}"; do
            if [ "''${FILES[$i]}" = "$CURRENT" ]; then
              NEXT_IDX=$(( (i + 1) % COUNT ))
              break
            fi
          done
        fi

        NEXT_FILE="''${FILES[$NEXT_IDX]}"
        NAME=$(basename "$NEXT_FILE" .conf)

        cp "$NEXT_FILE" "$CURRENT_CONF"
        echo "$NEXT_FILE" > "$STATE_FILE"

        hyprctl reload
        hyprctl notify 1 3000 "rgb(88ccff)" "Animation: $NAME"
      '';
    };
  };

  home.activation.initHyprAnimation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.config/hypr/current-animation.conf" ]; then
      cp "${./animations/default.conf}" "$HOME/.config/hypr/current-animation.conf"
      chmod 644 "$HOME/.config/hypr/current-animation.conf"
    fi
  '';
}
