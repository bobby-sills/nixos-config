{ vars, ... }:
let
  monoFont = vars.monoFont;
  gb = import ../gruvbox.nix;
in
{
  programs.wofi = {
    enable = true;
    style = ''
      * {
        font-family: "${monoFont.name}", monospace;
        font-size: ${toString (monoFont.size * 4 / 3)}px;
      }

      window {
        margin: 0px;
        border: 1px solid ${gb.gray_245};
        background-color: ${gb.dark0};
      }

      #input {
        margin: 5px;
        border: none;
        color: ${gb.light1};
        background-color: ${gb.dark0_hard};
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${gb.dark0};
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${gb.dark0};
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: ${gb.light1};
      }

      #entry:selected {
        background-color: ${gb.dark0_hard};
      }
    '';
  };
}
