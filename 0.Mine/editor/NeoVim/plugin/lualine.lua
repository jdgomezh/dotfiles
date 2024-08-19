-- lualine.lua - Configuration for lualine plugin.
-- This file sets up lualine, a status line plugin for Neovim.
-- Lualine is used to provide an enhanced and customizable status line in Neovim.

-- Main configuration table
-- This table contains all the configuration options for lualine.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: nvim-lualine/lualine.nvim - A blazing fast and easy to configure Neovim statusline.
plugin[1] = 'nvim-lualine/lualine.nvim'

-- @dependencies:
--  - folke/tokyonight.nvim: A clean, dark Neovim theme that supports true colors and customization.
plugin.dependencies = {
	_G.plugin_theme,
}

-- Configuration function for lualine
plugin.config = function (PluginSpec, opts)
	local lualine = require('lualine')

	opts.options = opts.options or {}

	-- Theme for lualine
	-- @option: theme
	-- @values: String (e.g., 'tokyonight', 'gruvbox')
	-- @impact: Sets the color scheme for lualine.
	opts.options.theme = _G.color_scheme

	-- Enable or disable icons in the statusline
	-- @option: icons_enabled
	-- @values: Boolean (true to enable, false to disable)
	-- @impact: Enables or disables icons in the statusline.
	opts.options.icons_enabled = true

	-- Global status
	-- @option: globalstatus
	-- @values: Boolean (true to show, false to hide)
	-- @impact: Shows the statusline in all windows.
	opts.options.globalstatus = true

	-- Component separators
	-- @option: component_separators
	-- @values: Table (e.g., {left = '', right = ''})
	-- @impact: Sets the separators between components.
	opts.options.component_separators = {left = '', right = ''}

	-- Section separators
	-- @option: section_separators
	-- @values: Table (e.g., {left = '', right = ''})
	-- @impact: Sets the separators between sections.
	opts.options.section_separators = {left = '', right = ''}

	opts.sections = opts.sections or {}

	opts.sections.lualine_a = {'mode'}
	opts.sections.lualine_b = {'branch', 'diff', 'diagnostics'}
	opts.sections.lualine_c = {'filename'}
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
	opts.sections.lualine_z = {'filetype'}

	lualine.setup(opts)
end

-- Return the complete configuration table
-- @return: Table containing all configuration options
return plugin
