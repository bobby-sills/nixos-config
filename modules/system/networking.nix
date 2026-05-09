{ ... }:
{
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	networking.networkmanager.wifi.backend = "iwd";
	networking.wireless.iwd.enable = true;
	networking.wireless.iwd.settings.General.AddressRandomization = "disabled";

	time.timeZone = "Asia/Bangkok";

	console.keyMap = "colemak";

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	services.blueman.enable = true;
}
