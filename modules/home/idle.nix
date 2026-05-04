{ ... }:
{
	services.batsignal.enable = true;

	programs.hyprlock.enable = true;

	services.hypridle = {
		enable = true;
		settings = {
			general = {
				before_sleep_cmd = "hyprlock --immediate";
				after_sleep_cmd = "hyprctl dispatch dpms on";
			};
			listener = [
				{
					timeout = 120;
					on-timeout = "brightnessctl -s set 20%";
					on-resume = "brightnessctl -r";
				}
				{
					timeout = 300;
					on-timeout = "systemctl suspend";
				}
			];
		};
	};
}
