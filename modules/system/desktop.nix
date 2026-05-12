{ ... }:
{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	security.pam.services.hyprlock = {};

	services.udisks2.enable = true;
}
