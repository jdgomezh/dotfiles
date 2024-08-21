-- telescope-ui-select.lua - Configuration for the telescope-ui-select extension.
-- This file sets up the UI select extension for Telescope, providing a dropdown-like interface.

-- Define the main configuration table for the plugin
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'nvim-telescope/telescope-ui-select.nvim': An extension of Telescope that provides a UI select interface.
plugin[1] = "nvim-telescope/telescope-ui-select.nvim"

-- Define plugin dependencies
-- Dependencies are other plugins required for this plugin to work correctly.
-- @dependencies: Table - List of dependencies required by telescope-ui-select.nvim.
-- 'nvim-telescope/telescope.nvim': Required dependency, as ui-select is an extension of Telescope.
plugin.dependencies = {
	"nvim-telescope/telescope.nvim",
}

-- Function to configure the plugin
-- This function sets up the plugin options and loads the necessary Telescope extensions.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring telescope-ui-select.
plugin.config = function(_, opts)
	-- Load Telescope module
	local telescope = require("telescope")

	-- Load the UI select extension
	-- This allows Telescope to access the ui_select functionality.
	telescope.load_extension("ui-select")
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
