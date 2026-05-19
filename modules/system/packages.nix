{ pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  users.users.bobby = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "nordvpn" ];
    packages = with pkgs; [
      tree
    ];
  };

  security.wrappers.wshowkeys = {
    owner = "root";
    group = "root";
    setuid = true;
    source = "${pkgs.wshowkeys}/bin/wshowkeys";
  };

  services.power-profiles-daemon.enable = true;

  programs.firefox.enable = true;

  programs.obs-studio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    wl-clipboard
    brightnessctl
    alsa-utils
    wshowkeys
    htop
  ];
}
