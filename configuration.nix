{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/base.nix
    ./modules/system/networking.nix
    ./modules/system/packages.nix
    ./modules/system/desktop.nix
    ./modules/system/nordvpn.nix
  ];

  custom.services.nordvpn.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d --keep-last 3";
  };

  system.stateVersion = "25.11";
}
