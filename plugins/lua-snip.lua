return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local luasnip = require 'luasnip'
		luasnip.config.set_config({
			history = true,
			enable_autosnippets = true,
		})
		-- luasnip.loaders.from_lua({ paths = "" })
	end,
}
