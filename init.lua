-- load lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- vim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- lazy packages
vim.g.lazyvim_check_order = false
require("lazy").setup({
	{
		"wakatime/vim-wakatime",
	},
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
			vim.api.nvim_set_hl(0, "Comment", { fg = "#fe8019" })
		end,
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = {
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
				},
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
			})
			vim.lsp.enable("pyright")

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
			})
			vim.lsp.enable("rust_analyzer")

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
			})
			vim.lsp.enable("clangd")

			vim.lsp.config("tinymist", {
				cmd = { "tinymist" },
				filetypes = { "typst" },
				capabilities = capabilities,
			})
			vim.lsp.enable("tinymist")
		end,
	},
})
