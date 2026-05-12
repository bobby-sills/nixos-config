{ pkgs, ... }:
{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	security.pam.services.hyprlock = {};

	services.udisks2.enable = true;

	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
	xdg.portal.config.hyprland = {
		default = [ "hyprland" "gtk" ];
		"org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
	};
}
