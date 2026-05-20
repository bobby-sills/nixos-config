vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 2

vim.cmd.colorscheme("gruvbox")

vim.lsp.enable('jsonls')
vim.lsp.enable('dartls')

require('kitty-scrollback').setup({
  {
    status_window = {
      style_simple = true,
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

vim.filetype.add({ extension = { arb = "json" } })
