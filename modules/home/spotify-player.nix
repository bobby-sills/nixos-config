{ ... }:
{
	programs.spotify-player = {
		enable = true;
		settings = {
			notify_transient = true;
		};
		keymaps = [
			{
				command = "ToggleLiked";
				key_sequence = "C-l";
			}
		];
	};
}
