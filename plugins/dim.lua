return {
	"narutoxy/dim.lua",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	event = "BufRead",
	config = true,
}
