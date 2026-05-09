{ pkgs, ... }:
{
	home.pointerCursor = {
		package = pkgs.apple-cursor;
		name = "macOS";
		size = 24;
		gtk.enable = true;
	};

	services.mako = {
		enable = true;
		settings.default-timeout = 5000;
	};

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

	qt = {
		enable = true;
		platformTheme.name = "gtk";
	};
}
