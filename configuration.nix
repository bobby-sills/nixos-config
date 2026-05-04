{ ... }:
{
	imports = [
		./hardware-configuration.nix
		./modules/system/boot.nix
		./modules/system/networking.nix
		./modules/system/audio.nix
		./modules/system/input.nix
		./modules/system/packages.nix
		./modules/system/fonts.nix
		./modules/system/desktop.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d --keep-last 3";
	};

	system.stateVersion = "25.11";
}
