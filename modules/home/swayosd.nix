{ ... }:
let
  gb = import ../gruvbox.nix;
in
{
  xdg.configFile."swayosd/style.css".text = ''
    window#osd {
      background: ${gb.dark0}eb;
      border: 1px solid ${gb.dark1};
      border-radius: 8px;
    }

    box#container {
      padding: 12px 18px;
    }

    image {
      color: ${gb.light4};
    }

    progressbar trough {
      background: ${gb.dark1};
      border-radius: 4px;
      min-height: 6px;
    }

    progressbar progress {
      background: ${gb.bright_orange};
      border-radius: 4px;
      min-height: 6px;
    }
  '';
}
