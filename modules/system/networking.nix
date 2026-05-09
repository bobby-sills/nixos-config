{ ... }:
{
	networking.hostName = "nixos";
	networking.wireless.iwd.enable = true;
	networking.interfaces.enp1s0f0.useDHCP = true;
	networking.interfaces.wlan0.useDHCP = true;

	time.timeZone = "Asia/Bangkok";

	console.keyMap = "colemak";

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	services.blueman.enable = true;
}
