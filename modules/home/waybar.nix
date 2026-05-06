{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 36;
      spacing = 4;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "battery" "pulseaudio" "network" "cpu" "memory" "tray" ];

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
      };

      "hyprland/window" = {
        max-length = 50;
      };

      clock = {
        format = "{:%a %d %b  %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      cpu = {
        format = " {usage}%";
        interval = 2;
      };

      memory = {
        format = " {percentage}%";
        interval = 5;
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = " {ipaddr}";
        format-disconnected = "󰖪 Offline";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Muted";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        scroll-step = 5;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        interval = 30;
      };

      tray = {
        spacing = 8;
      };
    }];

    style = ''
      * {
        font-family: monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(15, 15, 15, 0.85);
        color: #cdd6f4;
        border-bottom: 2px solid rgba(51, 204, 255, 0.4);
      }

      #workspaces button {
        padding: 0 8px;
        color: #888;
        background: transparent;
        border: none;
        border-radius: 6px;
        margin: 4px 2px;
      }

      #workspaces button.active {
        color: #33ccff;
        background: rgba(51, 204, 255, 0.15);
      }

      #workspaces button:hover {
        color: #00ff99;
        background: rgba(0, 255, 153, 0.1);
      }

      #window {
        color: #aaa;
        padding: 0 8px;
      }

      #clock {
        color: #33ccff;
        font-weight: bold;
        padding: 0 12px;
      }

      #cpu, #memory, #network, #pulseaudio, #battery, #tray {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #battery { color: #a6e3a1; }
      #battery.warning { color: #f9e2af; }
      #battery.critical { color: #f38ba8; }
      #battery.charging { color: #a6e3a1; }
      #cpu { color: #00ff99; }
      #memory { color: #a6e3a1; }
      #network { color: #89b4fa; }
      #pulseaudio { color: #f38ba8; }
      #pulseaudio.muted { color: #555; }
    '';
  };
}
