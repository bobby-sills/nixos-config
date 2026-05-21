{ vars, ... }:
let
  monoFont = vars.monoFont;
  gb = import ../gruvbox.nix;
in
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      spacing = 0;

      modules-left = [ "hyprland/workspaces" ];
      modules-right = [ "network" "cpu" "power-profiles-daemon" "battery" "clock" "custom/idle_inhibitor" "tray" ];

      "hyprland/workspaces" = {
        format = "{name}";
        on-click = "activate";
	show-special = true;
      };

      "hyprland/window" = {
        max-length = 60;
      };

      clock = {
        format = "{:%Y-%m-%d %I:%M %p}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "󰍛 {usage}%";
        tooltip = true;
        interval = 2;
      };

      memory = {
        format = "󰘚 {percentage}%";
        interval = 5;
      };

      network = {
        format-wifi = "{essid} {icon}" ;
        format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
        format-ethernet = "{ipaddr} ";
        format-disconnected = "Disconnected 󰤭 ";
        tooltip-format = "{ifname} via {gwaddr} ({signalStrength}%)";
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-muted = "Muted 󰝟";
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
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = [ " " " " " " " " " " ];
      };

      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = "{profile}";
        format-icons = {
          default = "󰈐";
          performance = "󰓅";
          balanced = "󰾅";
          power-saver = "󰾆";
        };
      };

      "custom/idle_inhibitor" = {
        exec = "idle-inhibitor status";
        return-type = "json";
        interval = 2;
        signal = 9;
        on-click = "idle-inhibitor toggle";
      };

      tray = {
        spacing = 5;
      };
    }];

    style = ''
      * {
        font-family: "${monoFont.name}", monospace;
        font-size: ${toString (monoFont.size * 4 / 3)}px;
        background-color: transparent;
        min-height: 0;
      }

      window#waybar {
        background-color: alpha(${gb.dark0}, 0.96);
        color: ${gb.light1};
        padding-bottom: 2px;
      }

      tooltip,
      menu {
        background-color: alpha(${gb.dark0}, 0.96);
        color: ${gb.light1};
      }

      button {
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px ${gb.light1};
      }

      #workspaces {
        margin: 0 4px;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: ${gb.light1};
        transition: none;
      }

      #workspaces button:hover {
        background: transparent;
      }

      #workspaces button.special {
        margin-left: 10px;
      }

      #workspaces button.active {
        background-color: ${gb.light1};
        color: alpha(${gb.dark0}, 0.96);
      }

      #workspaces button.urgent {
        color: ${gb.bright_red};
      }

      #window {
        margin: 0 4px;
        color: ${gb.light1};
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #power-profiles-daemon,
      #tray {
        padding: 0 16px;
        color: ${gb.light1};
      }

      #custom-idle_inhibitor { padding: 0; }
      #custom-idle_inhibitor.activated { padding: 0 16px; color: ${gb.bright_orange}; }

      #power-profiles-daemon.performance { color: ${gb.bright_red}; }
      #power-profiles-daemon.balanced { color: ${gb.bright_green}; }
      #power-profiles-daemon.power-saver { color: ${gb.bright_blue}; }

      #clock { color: ${gb.light1}; }

      #battery.charging, #battery.full { color: ${gb.bright_green}; }
      #battery.warning:not(.charging) { color: ${gb.bright_yellow}; }
      #battery.critical:not(.charging) { color: ${gb.bright_red}; }

      #cpu { color: ${gb.bright_red}; }

      #memory { color: ${gb.bright_aqua}; }

      #network { color: ${gb.light1}; }
      #network.disconnected { color: ${gb.bright_red}; }

      #pulseaudio { color: ${gb.light1}; }
      #pulseaudio.muted { color: ${gb.gray_245}; }

      #tray { color: ${gb.bright_blue}; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        color: ${gb.bright_red};
      }
    '';
  };
}
