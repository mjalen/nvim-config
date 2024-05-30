return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local colors = require('plugins.colors')
		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = colors.current,
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
			},
		}
	end,
}
