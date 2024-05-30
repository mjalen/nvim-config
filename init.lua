-- NeoVim configuration
local opt = vim.opt
opt.cursorline = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.number = true
opt.wrap = true
opt.scrolloff = 3
opt.wildmenu = true
opt.autoread = true
opt.hidden = true
opt.cc = "125"
opt.termguicolors = true

vim.g.mapleader = ','

local confpath = os.getenv("HOME") .. "/.config/nvim/"
package.path = confpath .. "?.lua;" .. package.path

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"ray-x/navigator.lua",
	require 'plugins.treesitter',
	require 'plugins.colors'.get(),
	require 'plugins.tsc',
	require 'plugins.lspconfig',
	require 'plugins.lsp-inlayhints',
	-- require('plugins.lsplens'),
	require 'plugins.lua-snip',
	require 'plugins.cmp',
	require 'plugins.telescope',
	require 'plugins.dim',
	require 'plugins.go',
	require 'plugins.lualine',
	require 'plugins.whichkey',
	require 'plugins.harpoon',
}

require("ibl").setup {}
require("gitsigns").setup {}
require('navigator').setup {}
