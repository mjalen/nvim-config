return {
	"VidocqH/lsp-lens.nvim",
	opts = {
		enable = true,
		include_declaration = false,
		sections = {
			definition = false,
			references = true,
			implements = true,
			git_authors = false,
		},
	},
	config = function()
		require('lsp-lens').setup()
	end,
}
