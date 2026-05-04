{ ... }:
{
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

	time.timeZone = "Asia/Bangkok";

	console.keyMap = "colemak";

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	services.blueman.enable = true;
}
