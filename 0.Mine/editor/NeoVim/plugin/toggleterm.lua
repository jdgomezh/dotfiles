-- toggleterm.lua - Configuration for akinsho/toggleterm.nvim plugin.
-- This file sets up ToggleTerm, a plugin that provides a toggleable terminal for Neovim.
-- ToggleTerm allows users to open terminals within Neovim, providing a flexible interface for running shell commands and managing terminal sessions.

-- Main configuration table
-- This table contains all the configuration options for ToggleTerm.
local plugin = {}

-- Define the ToggleTerm plugin for lazy.nvim
-- @plugin: akinsho/toggleterm.nvim - A plugin to provide a toggleable terminal within Neovim.
plugin[1] = 'akinsho/toggleterm.nvim'

-- Configuration function for the ToggleTerm plugin.
-- This function sets up ToggleTerm with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
plugin.config = function(_, opts)
	-- Load the toggleterm module.
	local toggleterm = require('toggleterm')

	-- Set default options if not already provided by the user.
	opts.size = opts.size or function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		else
			return 20
		end
	end

	opts.open_mapping = [[<c-\>]]
	opts.hide_numbers = true
	opts.start_in_insert = true
	opts.insert_mappings = true
	opts.direction = 'float'
	opts.close_on_exit = true
	opts.shell = vim.o.shell
	opts.float_opts = opts.float_opts or {}
	opts.float_opts.border = 'curved'
	opts.float_opts.winblend = 3
	opts.float_opts.highlights = opts.float_opts.highlights or {}
	opts.float_opts.highlights.border = "Normal"
	opts.float_opts.highlights.background = "Normal"

	-- Apply the configuration options to the toggleterm setup.
	toggleterm.setup(opts)

	-- Define key mappings for ToggleTerm functions.
	local key_mappings = {
		{ 'n', '<Leader>ttt', "<cmd>ToggleTerm<CR>", { noremap = true, silent = true } },
	}

	-- Apply key mappings.
	for _, mapping in ipairs(key_mappings) do
		vim.api.nvim_set_keymap(unpack(mapping))
	end
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
