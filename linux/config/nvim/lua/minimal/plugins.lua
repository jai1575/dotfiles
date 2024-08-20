local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print ("Installing packer reopen nvim")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
--  Aesthetics
	use ("rebelot/heirline.nvim")
	use {"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end}
	use ("lukas-reineke/indent-blankline.nvim")
--  Essentials:
	use ("wbthomason/packer.nvim")
	use ("nvim-tree/nvim-web-devicons")
	use ("nvim-telescope/telescope.nvim")
	use ("nvim-lua/plenary.nvim")
    --TODO: Add gitsigns to heirline config
	use ("lewis6991/gitsigns.nvim")
	use ("kylechui/nvim-surround")
    --TODO: Switch to emacs
    use {
        "X3eRo0/dired.nvim",
        requires = "MunifTanjim/nui.nvim",
        config = function()
            require("dired").setup {
                path_separator = "/",
                show_banner = false,
                show_icons = false,
                show_hidden = true,
                show_dot_dirs = true,
                show_colors = true,
            }
        end
    }

	if PACKER_BOOTSRAP then
		require("packer").sync()
	end
end)
