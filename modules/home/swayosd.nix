{ ... }:
let
  gb = import ../gruvbox.nix;
in
{
  xdg.configFile."swayosd/style.css".text = ''
    window#osd {
      background: ${gb.dark0}eb;
      border: 2px solid ${gb.dark1}aa;
      border-radius: 8px;
    }

    box#container {
      padding: 12px 18px;
    }

    image {
      color: ${gb.light1};
    }

    progressbar trough {
      background: ${gb.dark4};
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
