return {
	"dmmulroy/tsc.nvim",
	auto_open_qflist = true,
	opts = {
		auto_close_qflist = false,
		enable_progress_notifications = false,
		flags = {
			build = true,
		},
	},
	keys = {
		{ "<leader>ck", "<cmd>TSC<R>", desc = "Check TypesScript error" },
	},
}
