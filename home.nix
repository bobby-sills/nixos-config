{ ... }:
{
  imports = [
    ./modules/home/shell.nix
    ./modules/home/nvim.nix
    ./modules/home/theme.nix
    ./modules/home/idle.nix
    ./modules/home/waybar.nix
    ./modules/home/hyprland.nix
    ./modules/home/hyprpaper.nix
    ./modules/home/kitty.nix
    ./modules/home/wofi.nix
    ./modules/home/yazi.nix
    ./modules/home/spotify-player.nix
    ./modules/home/swayosd.nix
    ./modules/home/rclone.nix
  ];

  home.username = "bobby";
  home.homeDirectory = "/home/bobby";
  home.stateVersion = "25.11";
}
