-- telescope.lua - Configuration for nvim-telescope/telescope.nvim plugin.
-- This file sets up Telescope, a highly extendable fuzzy finder over lists.
-- Telescope is used to provide a powerful and flexible interface for searching and navigating files, buffers, and more.

-- Main configuration table
-- This table contains all the configuration options for Telescope.
local plugin = {}

-- Define the Telescope plugin for lazy.nvim
-- @plugin: nvim-telescope/telescope.nvim - A highly extendable fuzzy finder over lists.
plugin[1] = 'nvim-telescope/telescope.nvim'

-- Define plugin dependencies
-- These dependencies are required for Telescope to function properly.
plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
	'nvim-telescope/telescope-symbols.nvim',
}

-- Configuration function for the Telescope plugin.
-- This function sets up Telescope with custom options, extending preexisting configurations.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: The options table to configure the plugin.
plugin.config = function(_, opts)
	-- Load Telescope and its required modules.
	local telescope = require('telescope')
	local actions = require('telescope.actions')
	local previewers = require('telescope.previewers')

	-- Set default options for Telescope.
	opts.defaults = opts.defaults or {}
	opts.defaults.layout_strategy = 'flex'
	opts.defaults.sorting_strategy = 'ascending'
	opts.defaults.winblend = 5

	-- Setup Telescope with the custom options.
	telescope.setup(opts)

	-- Load Telescope extensions.
	pcall(function()
		telescope.load_extension('ui-select')
		telescope.load_extension('file_browser')
		telescope.load_extension('live_grep_args')
	end)

	-- Define key mappings for Telescope functions.
	local key_mappings = {
		{ 'n', '<Leader>tfb', "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>", { noremap = true, silent = true } },
	}

	-- Apply key mappings.
	for _, mapping in ipairs(key_mappings) do
		vim.api.nvim_set_keymap(unpack(mapping))
	end
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
