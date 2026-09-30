return {
	"goolord/alpha-nvim",
	enabled = false,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.buttons.val = {
			dashboard.button("f", " find file", ":lua require('telescope.builtin').find_files()<CR>"),
			dashboard.button("r", " recently used files", ":lua require('telescope.builtin').oldfiles()<CR>"),
			dashboard.button("n", " new file", ":ene<CR>"),
			dashboard.button("q", " quit", ":qa<CR>"),
		}

		dashboard.section.footer.val = "clueless"
		alpha.setup(dashboard.opts)
	end,
}
