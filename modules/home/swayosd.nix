{ ... }:
let
  gb = import ../gruvbox.nix;
in
{
  xdg.configFile."swayosd/style.css".text = ''
    window#osd {
      background: ${gb.dark0}eb;
      border: 2px solid ${gb.bright_orange};
      border-radius: 10px;
    }

    box#container {
      padding: 12px 18px;
    }

    image {
      color: ${gb.light1};
    }

    progressbar trough {
      background: ${gb.dark2};
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
