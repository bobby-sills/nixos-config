{ config, ... }:
{
	home.file.".config/wallpapers/calvin-and-hobbes.jpg".source =
		../../wallpapers/calvin-and-hobbes.jpg;

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = [ "${config.home.homeDirectory}/.config/wallpapers/calvin-and-hobbes.jpg" ];
			wallpaper = [ ",${config.home.homeDirectory}/.config/wallpapers/calvin-and-hobbes.jpg" ];
			splash = false;
		};
	};
}
