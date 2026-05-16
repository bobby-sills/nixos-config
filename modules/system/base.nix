{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  services.getty.autologinUser = "bobby";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.symbols-only
    pkgs.nerd-fonts.iosevka
    pkgs.corefonts
    pkgs.noto-fonts-cjk-sans
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="leds", KERNEL=="platform::micmute", ACTION=="add", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys%p/brightness"
  '';

  security.sudo.extraRules = [
    {
      users = [ "bobby" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main.capslock = "overload(control, esc)";
    };
  };
}
