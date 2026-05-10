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
      modules-center = [ "hyprland/window" ];
      modules-right = [ "network" "cpu" "battery" "pulseaudio" "clock" "tray" ];

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
        format = "󰍛 {usage}%";
        tooltip = true;
        interval = 2;
      };

      memory = {
        format = "󰘚 {percentage}%";
        interval = 5;
      };

      network = {
        format-wifi = "{icon} {essid}";
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

	battery: {
		states: {
			// "good": 95,
			warning: 30,
		critical: 15
		},
	format: "{capacity}% {icon}",
		format-full: "{capacity}% {icon}",
		format-charging: "{capacity}% ",
		format-plugged: "{capacity}% ",
		format-alt: "{time} {icon}",
		format-icons: [
			" ",
			" ",
			" ",
			" ",
			" "
		]
	},

      tray = {
        spacing = 10;
      };
    }];

    style = ''
      @define-color dark0 ${gb.dark0};
      @define-color bg alpha(@dark0, 0.96);
      @define-color dark1 ${gb.dark1};
      @define-color light1 ${gb.light1};
      @define-color light4 ${gb.light4};
      @define-color gray ${gb.gray_245};
      @define-color bright_red ${gb.bright_red};
      @define-color bright_green ${gb.bright_green};
      @define-color bright_yellow ${gb.bright_yellow};
      @define-color bright_blue ${gb.bright_blue};
      @define-color bright_aqua ${gb.bright_aqua};
      @define-color bright_orange ${gb.bright_orange};

      * {
        font-family: "${monoFont.name}", monospace;
        font-size: ${toString (monoFont.size * 4 / 3)}px;
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
        padding: 0 16px;
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
