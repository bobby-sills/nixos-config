{ pkgs, inputs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.bobby = {
		isNormalUser = true;
		extraGroups = [ "wheel" "video" ];
		packages = with pkgs; [
			tree
		];
	};

	programs.firefox.enable = true;

	environment.systemPackages = with pkgs; [
		vim
		wget
		foot
		waybar
		kitty
		git
		hyprpaper
		claude-code
		wofi
		yazi
		gdu
		brightnessctl
		ttyper
		inputs.helium-nix.packages.x86_64-linux.default
	];
}
