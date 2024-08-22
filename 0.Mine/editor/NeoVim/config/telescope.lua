local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = "flex",    
		sorting_strategy = "ascending",
	},
	extensions = {
		file_browser = {},
	},
})
