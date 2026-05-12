{ vars, ... }:
let
  monoFont = vars.monoFont;
  gb = import ../gruvbox.nix;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      matching = "contains";
    };
    style = ''
      * {
        font-family: "${monoFont.name}", monospace;
        font-size: ${toString (monoFont.size * 4 / 3)}px;
      }

      window {
        margin: 0px;
        border: 2.5px solid ${gb.bright_orange};
        border-radius: 10px;
        background-color: rgba(40, 40, 40, 0.96);
      }

      #input {
        margin: 5px;
        border: none;
        outline: none;
        box-shadow: none;
        color: ${gb.light1};
        background-color: ${gb.dark0_hard};
      }

      #input:focus {
        border: none;
        outline: none;
        box-shadow: none;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
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
