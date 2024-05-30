return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		--		vim.cmd('set foldmethod = expr')
		--		vim.cmd('set foldexpr = nvim_treesitter#foldexpr()')
		--		vim.cmd('set nofoldenable')
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"c", "cpp", "vue",
				"javascript", "typescript",
				"html", "css", "vim", "lua",
				"fennel", "glsl", "diff",
				"commonlisp", "latex",
				"markdown", "go", "templ",
				"rust", "python", "java",
				"vimdoc",
			},
			auto_install = false,
			highlight = { enable = 1 },
			indent = { enable = true },
		}
	end,
}
