local current_theme = 'everforest'
return {
	current = current_theme,
	get = function(optional_select)
		local themes = {
			everforest = {
				"sainnhe/everforest",
				lazy = false,
				priority = 1000,
				config = function()
					vim.g.everforest_enable_italic = true
					vim.g.everforest_background = 'hard'
					vim.opt.background = 'dark'
					vim.cmd.colorscheme('everforest')
				end,
			}
		}

		if optional_select then
			return themes[optional_select]
		end
		return themes[current_theme]
	end,

}
