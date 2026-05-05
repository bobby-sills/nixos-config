{ ... }:
{
	home.file.".config/wallpapers/calvin-and-hobbes.jpg".source =
		../../wallpapers/calvin and hobbes wallpaper.jpg;

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = [ "~/.config/wallpapers/calvin-and-hobbes.jpg" ];
			wallpaper = [ ",~/.config/wallpapers/calvin-and-hobbes.jpg" ];
			splash = false;
		};
	};
}
