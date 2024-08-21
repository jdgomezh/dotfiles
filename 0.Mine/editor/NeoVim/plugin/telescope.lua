-- telescope.lua - Configuration for nvim-telescope/telescope.nvim plugin.
-- This file sets up Telescope, a highly extendable fuzzy finder over lists.
-- Telescope is used to provide a powerful and flexible interface for searching and navigating files, buffers, and more.

-- Define the main configuration table for the plugin
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'nvim-telescope/telescope.nvim': A highly extendable fuzzy finder over lists.
plugin[1] = 'nvim-telescope/telescope.nvim'

-- Define plugin dependencies
-- Dependencies are other plugins required for this plugin to work correctly.
-- @dependencies: Table - List of dependencies required by telescope.nvim.
-- 'nvim-telescope/telescope-symbols.nvim': Extension for finding and inserting symbols.
-- 'nvim-telescope/telescope-ui-select.nvim': Extension that provides a UI select interface.
-- 'nvim-telescope/telescope-file-browser.nvim': Extension that provides a file browser interface.
plugin.dependencies = {
	'nvim-telescope/telescope-symbols.nvim',
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
}

-- Function to configure the plugin
-- This function sets up default options for Telescope.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring telescope.nvim.
plugin.opts = function(_, opts)
	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts = opts or {}
	opts.defaults = opts.defaults or {}
	
	-- Override default configurations
	-- @winblend: Integer (0-100) - Controls the transparency of Telescope windows.
	-- 0: Fully opaque window.
	-- 100: Fully transparent window.
	opts.defaults.winblend = 5

	-- @layout_strategy: String - Defines the layout strategy for Telescope windows.
	-- 'flex': Automatically switches between vertical and horizontal layouts based on window size.
	-- 'horizontal': Always uses a horizontal layout.
	-- 'vertical': Always uses a vertical layout.
	opts.defaults.layout_strategy = 'flex'

	-- @sorting_strategy: String - Defines the sorting strategy for Telescope results.
	-- 'ascending': Sorts results in ascending order (from top to bottom).
	-- 'descending': Sorts results in descending order (from bottom to top).
	opts.defaults.sorting_strategy = 'ascending'

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
