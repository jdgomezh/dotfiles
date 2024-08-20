-- lualine.lua - Configuration for lualine plugin.
-- This file configures lualine, a status line plugin for Neovim.
-- lualine is highly customizable and provides enhanced information in the status line.

-- Main configuration table
-- This table contains all the configuration options for lualine.
local plugin = {}

-- Define the lualine plugin for lazy.nvim
-- @plugin: nvim-lualine/lualine.nvim - A fast and easy-to-configure statusline plugin for Neovim.
plugin[1] = 'nvim-lualine/lualine.nvim'

-- Define plugin dependencies
-- Dependencies are other plugins required by lualine to function correctly.
-- In this case, it includes the theme plugin as returned by the theme manager.
plugin.dependencies = {
	_G.theme_manager.get_plugin_theme(),
}

-- Configuration function for lualine
-- This function is executed when the plugin is loaded to set up lualine with custom options.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: Table - Options table containing user-defined settings for lualine.
plugin.config = function (_, opts)
	-- Load lualine module.
	local lualine = require('lualine')

	-- Default options for lualine
    -- These options configure the visual aspects and functionality of the status line.
	opts.options = opts.options or {}

	-- Theme for lualine
	-- @option theme: String - The colorscheme to be applied to lualine.
	--   This can be any valid lualine theme name, or one provided by the selected theme.
	opts.options.theme = _G.theme_manager.get_lualine_theme()

	-- Enable or disable icons in the statusline
	-- @option icons_enabled: Boolean - true to enable icons, false to disable.
	opts.options.icons_enabled = true

	-- Global status
	-- @option globalstatus: Boolean - true to display the statusline in all windows, false to limit it to active windows.
	opts.options.globalstatus = true

	-- Component separators
	-- @option component_separators: Table - Defines the separators between individual components in lualine.
	--   The separators can be any valid string, including special characters or emojis.
	opts.options.component_separators = {left = '', right = ''}

	-- Section separators
	-- @option section_separators: Table - Defines the separators between different sections in lualine.
	--   This helps visually distinguish different parts of the statusline
	opts.options.section_separators = {left = '', right = ''}

	-- Sections configuration
	-- This section defines what information is displayed in each part of the status line.
	-- Each section (lualine_a, lualine_b, etc.) corresponds to a different area of the status line.
	opts.sections = opts.sections or {}

	-- lualine_a section
	-- @section lualine_a: Displays the current mode (e.g., NORMAL, INSERT)
	opts.sections.lualine_a = {'mode'}

	-- lualine_b section
	-- @section lualine_b: Displays Git branch, diff status, and diagnostics information
	opts.sections.lualine_b = {'branch', 'diff', 'diagnostics'}

	-- lualine_c section
	-- @section lualine_c: Displays the name of the current file
	opts.sections.lualine_c = {'filename'}

	-- lualine_x section
	-- @section lualine_x: Displays various file information and lazy.nvim status updates
	opts.sections.lualine_x = {
		{
			require("lazy.status").has_updates,
			cond = require("lazy.status").has_updates,
		},
		{
			function()
				return (vim.bo.fileencoding or 'none'):upper()
			end,
		},
		{
			function()
				local format = vim.bo.fileformat
				return format == 'unix' and 'LF' or 'CRLF'
			end,
		},
	}

	-- lualine_y section
	-- @section lualine_y: Displays indentation type (Spaces or Tabs) and shift width
	opts.sections.lualine_y = {
		{
			function()
				return vim.bo.expandtab and 'SPC' or 'TAB'
			end,
		},
		{
			function()
				return 'SW:' .. vim.bo.shiftwidth
			end,
		},
	}

	-- lualine_z section
	-- @section lualine_z: Displays the file type (e.g., Lua, Python)
	opts.sections.lualine_z = {'filetype'}

	-- Set up lualine with the configured options
	lualine.setup(opts)
end

-- Return the complete configuration table
-- @return: Table containing all configuration options
return plugin
