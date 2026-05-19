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

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.0.3";
  };

  programs.firefox.enable = true;

  programs.obs-studio.enable = true;

  environment.systemPackages = with pkgs; [
    gimp
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
    rclone
    unimatrix
    htop
    hyprsunset
    deno
    ffmpeg
    fastfetch
    google-chrome
    hledger
    playerctl
    xournalpp
    anki
    swayosd
    alsa-utils
    wev
    musescore
    libnotify
    sioyek
    nodejs
    lazygit
    jq
    rustup
    gcc
    imv
    wshowkeys
    kdePackages.kdenlive
    guvcview
  ];
}
