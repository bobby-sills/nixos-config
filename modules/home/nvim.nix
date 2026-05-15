{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      ignorecase = true;
      smartcase = true;
      cursorline = true;
      shiftwidth = 2;
    };

    colorschemes.gruvbox.enable = true;

    plugins.lspconfig.enable = true;

    extraPlugins = [ pkgs.vimPlugins.kitty-scrollback-nvim ];

    extraConfigLua = ''
      vim.lsp.enable('jsonls')
      vim.lsp.enable('dartls')

      require('kitty-scrollback').setup({
        {
          status_window = {
            style_simple = true,
          },
        },
      })
    '';

    autoCmd = [
      {
        event = [ "BufWritePre" ];
        pattern = [ "*" ];
        callback.__raw = ''
          function()
            vim.lsp.buf.format({ async = false })
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<Esc><Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
    ];

    filetype.extension = {
      arb = "json";
    };
  };
}
