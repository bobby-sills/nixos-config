{ ... }:
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
				"$mainMod, M, exit,"
					"$mainMod, V, togglefloating,"
				"$mainMod, Space, exec, $menu"
				"$mainMod, Escape, exec, hyprlock"
				"$mainMod SHIFT, Escape, exec, systemctl suspend"
				"$mainMod, P, pseudo,"
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
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
				"$mainMod CTRL, S, exec, hyprshot -m region -o ~/pictures/screenshots"
				"$mainMod SHIFT CTRL, S, exec, hyprshot -m output -o ~/pictures/screenshots"
				"$mainMod, BackSpace, exec, makoctl dismiss"
				"$mainMod, Y, exec, $fileManager"
				"$mainMod, W, exec, pkill -SIGUSR1 waybar"
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

			workspace = [
				"w[tv1], gapsout:0, gapsin:0"
				"f[1], gapsout:0, gapsin:0"
			];

			windowrulev2 = [
				"bordersize 0, floating:0, onworkspace:w[tv1]"
				"rounding 0, floating:0, onworkspace:w[tv1]"
				"bordersize 0, floating:0, onworkspace:f[1]"
				"rounding 0, floating:0, onworkspace:f[1]"
			];

			windowrule = [
				"suppressevent maximize, class:.*"
				"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
			];
		};

		extraConfig = ''
			gesture = 3, horizontal, workspace

			bind = $mainMod, O, submap, browser

			submap = browser
			bind = , B, exec, helium --profile-directory=Default
			bind = , B, submap, reset
			bind = , S, exec, helium --profile-directory=Profile 1
			bind = , S, submap, reset
			bind = , escape, submap, reset
			submap = reset
		'';
	};
}
