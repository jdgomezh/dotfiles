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
plugin[1] = 'folke/tokyonight.nvim'

-- Configuration function for the ToggleTerm plugin.
-- This function sets up ToggleTerm with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for ToggleTerm.
plugin.config = function(PluginSpec, opts)
	-- Load the toggleterm module.
	-- @require: Require the toggleterm module for configuration.
	local toggleterm = require('tokyonight')

	-- Theme style
	-- @option: tokyonight_style
	-- @values: 'night', 'storm', 'day'
	-- @impact: Sets the theme style for tokyonight.
	vim.g.tokyonight_style = 'night'

	-- Enable terminal colors
	-- @option: tokyonight_terminal_colors
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Enables terminal colors for tokyonight.
	vim.g.tokyonight_terminal_colors = true

	-- Italicize comments
	-- @option: tokyonight_italic_comments
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Italicizes comments in the tokyonight theme.
	vim.g.tokyonight_italic_comments = true

	-- Italicize keywords
	-- @option: tokyonight_italic_keywords
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Italicizes keywords in the tokyonight theme.
	vim.g.tokyonight_italic_keywords = true

	-- Italicize functions
	-- @option: tokyonight_italic_functions
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Italicizes functions in the tokyonight theme.
	vim.g.tokyonight_italic_functions = false

	-- Italicize variables
	-- @option: tokyonight_italic_variables
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Italicizes variables in the tokyonight theme.
	vim.g.tokyonight_italic_variables = false

	-- Transparent background
	-- @option: tokyonight_transparent
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Enables a transparent background in the tokyonight theme.
	vim.g.tokyonight_transparent = false

	-- Transparent sidebar
	-- @option: tokyonight_transparent_sidebar
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Enables a transparent sidebar in the tokyonight theme.
	vim.g.tokyonight_transparent_sidebar = false

	-- Hide inactive statusline
	-- @option: tokyonight_hide_inactive_statusline
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Hides the statusline when inactive in the tokyonight theme.
	vim.g.tokyonight_hide_inactive_statusline = false

	-- Apply the colorscheme
	-- @cmd: colorscheme tokyonight
	-- @impact: Applies the tokyonight colorscheme.
	vim.cmd[[colorscheme tokyonight-night]]
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
