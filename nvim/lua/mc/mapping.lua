vim.g.mapleader = " "
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>0", function()
  vim.cmd[[NvimTreeToggle]]
end)
vim.keymap.set("n", "<leader>i", function()
  vim.cmd[[Dired]]
end)
vim.keymap.set("n", "<leader>o", function()
  vim.cmd[[DiredQuit]]
end)

vim.keymap.set("n", "<leader>t", "o<ESC>")
vim.keymap.set("n", "<leader>f", "<C-w><C-w>")
vim.keymap.set("n", "<leader>k", "<C-u>")
vim.keymap.set("n", "<leader>j", "<C-d>")
--vim.keymap.set("n", "<leader>g", "<Esc><Esc>")
vim.keymap.set("n", "<leader>g", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader>p", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>aw", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>awww", "<cmd>CellularAutomaton game_of_life<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>bd<CR>")
vim.keymap.set("n", "K", builtin.buffers)
vim.keymap.set("n", "<leader>pd", builtin.live_grep)
