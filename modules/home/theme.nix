{ pkgs, vars, ... }:
let
  gb = import ../gruvbox.nix;
in
{
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
    gtk.enable = true;
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "${vars.monoFont.name} ${toString vars.monoFont.size}";
      background-color = "${gb.dark0}ff";
      text-color = "${gb.light1}ff";
      border-color = "${gb.bright_orange}ff";
      border-size = 2;
      border-radius = 10;
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "helium.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      "x-scheme-handler/about" = "helium.desktop";
      "x-scheme-handler/unknown" = "helium.desktop";
    };
  };

  home.file.".config/BeeperTexts/custom.css".text = ''
    :root {
      --font-family: system-ui, "Segoe UI", Roboto, "Apple Color Emoji", TwemojiFlags, "Segoe UI Emoji", "Segoe UI Symbol", Twemoji, sans-serif, "Noto Color Emoji";
    }
  '';
}
