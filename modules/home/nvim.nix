{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      nvim-lspconfig
      kitty-scrollback-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
