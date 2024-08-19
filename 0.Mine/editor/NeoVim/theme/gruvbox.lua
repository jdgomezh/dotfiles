-- toggleterm.lua - Configuration for akinsho/toggleterm.nvim plugin.
-- This file sets up ToggleTerm, a plugin that provides a toggleable terminal for Neovim.
-- ToggleTerm allows users to open terminals within Neovim, providing a flexible interface for running shell commands and managing terminal sessions.

-- Main configuration table
-- This table contains all the configuration options for ToggleTerm.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: akinsho/toggleterm.nvim - A plugin to provide a toggleable terminal within Neovim.
-- This plugin helps in managing terminal sessions within Neovim, allowing users to toggle terminals on and off as needed.
plugin[1] = 'ellisonleao/gruvbox.nvim'

-- Configuration function for the ToggleTerm plugin.
-- This function sets up ToggleTerm with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for ToggleTerm.
plugin.config = function(PluginSpec, opts)
	-- Load the toggleterm module.
	-- @require: Require the toggleterm module for configuration.
	local gruvbox = require('gruvbox')

	-- Apply the colorscheme
	-- @cmd: colorscheme tokyonight
	-- @impact: Applies the tokyonight colorscheme.
	vim.cmd[[colorscheme gruvbox]]
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
