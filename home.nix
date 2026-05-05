{ ... }:
{
	imports = [
		./modules/home/shell.nix
		./modules/home/editor.nix
		./modules/home/theme.nix
		./modules/home/idle.nix
		./modules/home/waybar.nix
		./modules/home/hyprland.nix
		./modules/home/hyprpaper.nix
		./modules/home/kitty.nix
	];

	home.username = "bobby";
	home.homeDirectory = "/home/bobby";
	home.stateVersion = "25.11";
}
