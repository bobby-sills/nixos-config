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
        font-size: ${toString (monoFont.size * 4 / 3)}px;
      }
    '';
  };
}
