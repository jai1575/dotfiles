require("cmp.mapping")
require("cmp.plugins")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.updatetime = 50
vim.opt.swapfile = false
vim.g.loaded_netrwPlugin = 0

require("ibl").setup()

require("nvim-surround").setup{}

require("nightfox").setup({
  options = {
    transparent = true,
  }
})
vim.cmd[[colorscheme carbonfox]]

require("lspconfig").clangd.setup{}
