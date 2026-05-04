{ pkgs, ... }:
{
	home.pointerCursor = {
		package = pkgs.adwaita-icon-theme;
		name = "Adwaita";
		size = 24;
		gtk.enable = true;
	};

	services.mako.enable = true;

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
}
