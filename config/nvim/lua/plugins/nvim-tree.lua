return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
		{ "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal current file in tree" },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		view = { width = 35 },
		renderer = { group_empty = true },
		update_focused_file = { enable = true },
		filters = { dotfiles = false },
	},
}
