-- telescope.lua - Configuration for Telescope plugin.
-- This file sets up Telescope, a highly extendable fuzzy finder over lists.
-- Telescope is used to provide a powerful and flexible interface for searching and navigating files, buffers, and more.
-- It integrates with various extensions to enhance its functionality.

-- Main configuration table
-- This table contains all the configuration options for Telescope.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: nvim-telescope/telescope.nvim - A highly extendable fuzzy finder over lists.
plugin[1] = 'nvim-telescope/telescope.nvim'

-- @dependencies:
--   - nvim-lua/plenary.nvim: Lua utility functions required by Telescope.
--   - nvim-telescope/telescope-ui-select.nvim: UI Select extension for Telescope.
--   - nvim-telescope/telescope-file-browser.nvim: File Browser extension for Telescope.
--   - nvim-telescope/telescope-symbols.nvim: Symbols picker for Telescope.
plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
	'nvim-telescope/telescope-symbols.nvim',
}

-- Configuration function for Telescope
-- This function sets up Telescope with custom options, extending preexisting configurations.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: The options table to configure the plugin.
plugin.config = function(PluginSpec, opts)
	local telescope = require('telescope') -- Load the Telescope module
	local actions = require('telescope.actions') -- Load the actions module from Telescope
	local previewers = require('telescope.previewers') -- Load the previewers module from Telescope

	-- Ensure opts.defaults is initialized if not already provided
	opts.defaults = opts.defaults or {}

	-- Strategy for layout, using a flexible approach that adapts to the window size
	-- @option: layout_strategy
	-- @values: 'horizontal', 'vertical', 'flex'
	-- @impact: Determines how the Telescope window is laid out. 'flex' adjusts the layout based on the window size.
	opts.defaults.layout_strategy = 'flex'

	-- Sorting strategy for items, set to ascending order
	-- @option: sorting_strategy
	-- @values: 'ascending', 'descending'
	-- @impact: Determines the order in which search results are displayed. 'ascending' shows the smallest items first.
	opts.defaults.sorting_strategy = 'ascending'

	-- Transparency setting for Telescope windows
	-- @option: winblend
	-- @values: Integer from 0 to 100 (0 is fully opaque, 100 is fully transparent)
	-- @impact: Sets the transparency of the Telescope window, allowing you to see through it to some degree.
	opts.defaults.winblend = 5

	-- Setup Telescope with the custom options
	telescope.setup(opts)

	-- Load Telescope extensions
	pcall(function()
		telescope.load_extension('ui-select')
		telescope.load_extension('file_browser')
		telescope.load_extension('live_grep_args')
	end)

	-- Define key mappings for Telescope functions
	local key_mappings = {
		-- File browser
		-- @key: <Leader>tfb (Leader key, t, f, b)
		-- @mode: normal
		-- @action: require('telescope').extensions.file_browser.file_browser
		-- @description: Opens Telescope file browser.
		{ 'n', '<Leader>tfb', "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>", { noremap = true, silent = true } },
	}

	-- Apply key mappings
	for _, mapping in ipairs(key_mappings) do
		vim.api.nvim_set_keymap(unpack(mapping))
	end
end

-- Return the complete configuration table
-- @return: Table containing all configuration options
return plugin
