local fn = vim.fn

-- Automatically install packer
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
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})




-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities

	-- Colorschemes
	use ({ "rebelot/kanagawa.nvim" }) -- Color scheme

	use({ "nvim-lualine/lualine.nvim", requires = { 'nvim-tree/nvim-web-devicons', opt = true } }) -- Statusline
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "kyazdani42/nvim-web-devicons" }) -- File icons
	use({ "akinsho/bufferline.nvim" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "onsails/lspkind-nvim" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine

	-- LSP
	-- use({ "neovim/nvim-lspconfig" }) -- enable LSP
	-- use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	-- use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	-- use({ "glepnir/lspsaga.nvim" }) -- LSP UIs

    -- Coc
    use {'neoclide/coc.nvim', branch = 'release'}

	-- Formatter
	use({ "MunifTanjim/prettier.nvim" })

    -- File System
    use {
        "nvim-neo-tree/neo-tree.nvim",
          branch = "v3.x",
          requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
          }
        }


    -- noiceの設定
	use({
		"folke/noice.nvim", 
		requires = {
			"MunifTanjim/nui.nvim", 
			"rcarriga/nvim-notify"
		}
	})
	

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", requires = { {'nvim-lua/plenary.nvim'} } })

	-- Treesitter
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({ "windwp/nvim-ts-autotag" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
