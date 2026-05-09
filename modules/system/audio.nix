{ ... }:
{
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	services.udev.extraRules = ''
		SUBSYSTEM=="leds", ACTION=="add", KERNEL=="*micmute", ATTR{trigger}="none", MODE="0666"
	'';
}
