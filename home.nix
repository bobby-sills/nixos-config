{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

	home.username = "bobby";
	home.homeDirectory = "/home/bobby";
	home.stateVersion = "25.11";

	home.packages = [
		(pkgs.writeShellScriptBin "rebuild" ''
			set -e
			cd ~/nixos-dotfiles
			git add -A
			git diff --cached --stat
			git commit -m "''${1:-update config}"
			sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw
		'')
	];
	programs.nixvim = {
		enable = true;
		defaultEditor = true;
	};

	programs.git = {
		enable = true;
		settings.user = {
			name = "Bobby Sills";
			email = "bobbysills@bobbysills.dev";
		};
	};
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos, btw";
		};
	};
	home.pointerCursor = {
		package = pkgs.adwaita-icon-theme;
		name = "Adwaita";
		size = 24;
		gtk.enable = true;
	};

	services.mako.enable = true;

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

	gtk = {
		enable = true;
		gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
		gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
	};

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		settings = {
			monitor = ",preferred,auto,auto";

			"$terminal" = "kitty";
			"$fileManager" = "kitty -e yazi";
			"$menu" = "wofi --show drun";
			"$mainMod" = "SUPER";

			exec-once = [
				"hyprctl setcursor Adwaita 24"
				"waybar"
			];

			env = [
				"XCURSOR_THEME,Adwaita"
				"XCURSOR_SIZE,24"
				"HYPRCURSOR_SIZE,24"
			];

			general = {
				gaps_in = 5;
				gaps_out = 20;
				no_gaps_when_only = 1;
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

			animations = {
				enabled = true;
				bezier = [
					"easeOutQuint,0.23,1,0.32,1"
					"easeInOutCubic,0.65,0.05,0.36,1"
					"linear,0,0,1,1"
					"almostLinear,0.5,0.5,0.75,1"
					"quick,0.15,0,0.1,1"
				];
				animation = [
					"global,1,10,default"
					"border,1,5.39,easeOutQuint"
					"windows,1,4.79,easeOutQuint"
					"windowsIn,1,4.1,easeOutQuint,popin 87%"
					"windowsOut,1,1.49,linear,popin 87%"
					"fadeIn,1,1.73,almostLinear"
					"fadeOut,1,1.46,almostLinear"
					"fade,1,3.03,quick"
					"layers,1,3.81,easeOutQuint"
					"layersIn,1,4,easeOutQuint,fade"
					"layersOut,1,1.5,linear,fade"
					"fadeLayersIn,1,1.79,almostLinear"
					"fadeLayersOut,1,1.39,almostLinear"
					"workspaces,1,1.94,almostLinear,fade"
					"workspacesIn,1,1.21,almostLinear,fade"
					"workspacesOut,1,1.94,almostLinear,fade"
					"zoomFactor,1,7,quick"
				];
			};

			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};

			master = {
				new_status = "master";
			};

			misc = {
				force_default_wallpaper = -1;
				disable_hyprland_logo = false;
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
				"$mainMod, Q, exec, $terminal"
				"$mainMod, C, killactive,"
				"$mainMod, M, exit,"
				"$mainMod, E, exec, $fileManager"
				"$mainMod, V, togglefloating,"
				"$mainMod, R, exec, $menu"
				"$mainMod, P, pseudo,"
				"$mainMod, J, togglesplit,"
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"
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
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
			];

			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];

			bindel = [
				",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
				",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
				",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
				",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
				",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
				",F6, exec, brightnessctl -e4 -n2 set 5%+"
				",F5, exec, brightnessctl -e4 -n2 set 5%-"
			];

			bindl = [
				", XF86AudioNext, exec, playerctl next"
				", XF86AudioPause, exec, playerctl play-pause"
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPrev, exec, playerctl previous"
			];

			windowrule = [
				"suppressevent maximize, class:.*"
				"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
			];
		};

		extraConfig = ''
			gesture = 3, horizontal, workspace
		'';
	};
}
