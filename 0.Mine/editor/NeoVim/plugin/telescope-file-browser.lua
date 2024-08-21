-- telescope-file-browser.lua - Configuration for the telescope-file-browser extension.
-- This file sets up the file browser extension for Telescope, enabling file navigation.

-- Define the main configuration table for the plugin
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'nvim-telescope/telescope-file-browser.nvim': An extension of Telescope that provides a file browser interface.
plugin[1] = "nvim-telescope/telescope-file-browser.nvim"

-- Define plugin dependencies
-- Dependencies are other plugins required for this plugin to work correctly.
-- @dependencies: Table - List of dependencies required by telescope-file-browser.nvim.
-- 'nvim-telescope/telescope.nvim': Required dependency, as file-browser is an extension of Telescope.
plugin.dependencies = {
	"nvim-telescope/telescope.nvim",
}

-- Function to configure the plugin
-- This function sets up the plugin options and loads the necessary Telescope extensions.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring telescope-file-browser.
plugin.config = function(_, opts)
	-- Load Telescope module
	local telescope = require("telescope")

	-- Load the file browser extension
	-- This allows Telescope to access the file_browser functionality.
	telescope.load_extension("file_browser")
end

-- Function to define key mappings
-- This function sets up key bindings for the plugin using the lazy.nvim keys field.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param keys: Table - A table containing the existing key mappings.
plugin.keys = function(_, keys)
	-- Insert a new key mapping into the keys table
	-- This mapping triggers the Telescope file_browser extension when <leader>fn is pressed in normal mode.
	table.insert(keys, {
		'<leader>fn',
		function()
			local telescope = require("telescope")
			telescope.extensions.file_browser.file_browser()
		end,
		desc = 'File Browser',
		mode = 'n'
	})

	-- Return the modified keys table
	-- @return: The updated keys table with the new key mapping.
	return keys
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
