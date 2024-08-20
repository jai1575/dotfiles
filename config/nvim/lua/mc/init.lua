require("mc.mapping")
require("mc.plugins")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("ibl").setup()

--require("nvim-tree").setup({
--  disable_netrw = true,
--  view = {
--    side = "right",
--    centralize_selection = true,
--  }
--})

require("nvim-surround").setup({})

require("nightfox").setup({
  options = {
    transparent = true,
  }
})
vim.cmd[[colorscheme carbonfox]]
