{ pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	services.getty.autologinUser = "bobby";

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};

	fonts.packages = [
		pkgs.nerd-fonts.symbols-only
		pkgs.nerd-fonts.iosevka
		pkgs.corefonts
		pkgs.noto-fonts-cjk-sans
	];

	services.keyd = {
		enable = true;
		keyboards.default = {
			ids = [ "*" ];
			settings.main.capslock = "overload(control, esc)";
		};
	};
}
