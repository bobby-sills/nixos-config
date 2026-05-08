{ pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  users.users.bobby = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  programs.obs-studio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    foot
    waybar
    kitty
    git
    eza
    hyprpaper
    claude-code
    wofi
    bemoji
    wl-clipboard
    gdu
    brightnessctl
    ttyper
    hyprshot
    mpv
    bluetui
    impala
    spotify-player
    ripgrep
    gh
    python3
    inputs.helium-nix.packages.x86_64-linux.default
    beeper
    pipes
    cbonsai
    unimatrix
    hyprsunset
    deno
    ffmpeg
    fastfetch
    google-chrome
    hledger
  ];
}
