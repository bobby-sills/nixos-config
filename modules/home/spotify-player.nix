{ ... }:
let
	g = import ../gruvbox.nix;
in
{
	programs.spotify-player = {
		enable = true;
		settings = {
			notify_transient = true;
			theme = "gruvbox_dark";
			layout = {
				playback_window_height = 12;
			};
			cover_img_length = 11;
			cover_img_width = 7;
			cover_img_scale = 1.0;
		};

		actions = [
			{
				action = "ToggleLiked";
				key_sequence = "C-l";
			}
		];

		themes = [
			{
				name = "gruvbox_dark";
				palette = {
					background    = g.dark0;
					foreground    = g.light1;
					black         = g.dark0;
					red           = g.neutral_red;
					green         = g.neutral_green;
					yellow        = g.neutral_yellow;
					blue          = g.neutral_blue;
					magenta       = g.neutral_purple;
					cyan          = g.neutral_aqua;
					white         = g.light4;
					bright_black  = g.gray_245;
					bright_red    = g.bright_red;
					bright_green  = g.bright_green;
					bright_yellow = g.bright_yellow;
					bright_blue   = g.bright_blue;
					bright_magenta = g.bright_purple;
					bright_cyan   = g.bright_aqua;
					bright_white  = g.light1;
				};
			}
		];
	};
}
