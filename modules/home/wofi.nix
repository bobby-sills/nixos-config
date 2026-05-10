{ vars, ... }:
let
  monoFont = vars.monoFont;
in
{
  programs.wofi = {
    enable = true;
    style = ''
      * {
        font-family: "${monoFont.name}", monospace;
        font-size: ${toString monoFont.size}px;
      }

      window {
        background-color: #1d2021;
        border: 2px solid rgba(51, 204, 255, 0.4);
        border-radius: 8px;
      }

      #input {
        background-color: #282828;
        color: #ebdbb2;
        border: none;
        border-radius: 6px;
        padding: 8px 12px;
        margin: 8px;
      }

      #inner-box {
        background-color: #1d2021;
      }

      #outer-box {
        padding: 8px;
      }

      #entry {
        padding: 6px 12px;
        border-radius: 6px;
        color: #ebdbb2;
      }

      #entry:selected {
        background-color: rgba(51, 204, 255, 0.15);
        color: #33ccff;
      }

      #text {
        color: inherit;
      }
    '';
  };
}
