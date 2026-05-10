{ vars, ... }:
let
  monoFont = vars.monoFont;
in
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      spacing = 4;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "network" "cpu" "memory" "battery" "pulseaudio" "clock" "tray" ];

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
      };

      "hyprland/window" = {
        max-length = 60;
      };

      clock = {
        format = "{:%Y-%m-%d %I:%M %p}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "{usage}% ";
        tooltip = true;
        interval = 2;
      };

      memory = {
        format = "{percentage}% ";
        interval = 5;
      };

      network = {
        format-wifi = "{essid} {icon}";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-ethernet = "{ipaddr} ";
        format-disconnected = "Disconnected 󰤭";
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
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-icons = [ " " " " " " " " " " ];
        interval = 30;
      };

      tray = {
        spacing = 10;
      };
    }];

    style = ''
      @define-color bg rgba(40, 40, 40, 0.96);
      @define-color dark1 #3c3836;
      @define-color light1 #ebdbb2;
      @define-color light4 #a89984;
      @define-color gray #928374;
      @define-color bright_red #fb4934;
      @define-color bright_green #b8bb26;
      @define-color bright_yellow #fabd2f;
      @define-color bright_blue #83a598;
      @define-color bright_aqua #8ec07c;
      @define-color bright_orange #fe8019;

      * {
        font-family: "${monoFont.name}", monospace;
        font-size: 17px;
        background-color: transparent;
        min-height: 0;
      }

      window#waybar {
        background-color: @bg;
        color: @light1;
        padding-bottom: 2px;
      }

      tooltip {
        background-color: @bg;
        color: @light1;
      }

      button {
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px @light1;
      }

      #workspaces {
        margin: 0 4px;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: @light1;
        transition: none;
      }

      #workspaces button:hover {
        background: transparent;
      }

      #workspaces button.active {
        background-color: @light1;
        color: @bg;
      }

      #workspaces button.urgent {
        color: @bright_red;
      }

      #window {
        margin: 0 4px;
        color: @light1;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        color: @light1;
      }

      #clock { color: @light1; }

      #battery.charging, #battery.full { color: @bright_green; }
      #battery.warning:not(.charging) { color: @bright_yellow; }
      #battery.critical:not(.charging) { color: @bright_red; }

      #cpu { color: @bright_red; }

      #memory { color: @bright_aqua; }

      #network { color: @light1; }
      #network.disconnected { color: @bright_red; }

      #pulseaudio { color: @light1; }
      #pulseaudio.muted { color: @gray; }

      #tray { color: @bright_blue; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        color: @bright_red;
      }
    '';
  };
}
