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

--installl finally!!!!
return packer.startup(function(use)
	use ("wbthomason/packer.nvim")
	use ("folke/tokyonight.nvim")
	use ("rebelot/heirline.nvim")
	use ("nvim-tree/nvim-tree.lua")
	use ("nvim-tree/nvim-web-devicons")
	use ("rebelot/kanagawa.nvim")
	use ("oahlen/iceberg.nvim")
	use ("slugbyte/lackluster.nvim")
	use ("nvim-telescope/telescope.nvim")
	use ("nvim-lua/plenary.nvim")
	use ("wintermute-cell/gitignore.nvim")
	use ("lewis6991/gitsigns.nvim")
	use ("kylechui/nvim-surround")
	use ("EdenEast/nightfox.nvim")
	use ("Eandrju/cellular-automaton.nvim")
	use ("nvim-treesitter/nvim-treesitter")
	use ("lukas-reineke/indent-blankline.nvim")
	use {"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end}
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
