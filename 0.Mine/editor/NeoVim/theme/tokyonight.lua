-- tokyonight.lua - Configuration for folke/tokyonight.nvim plugin.
-- This file sets up the TokyoNight color scheme for Neovim.
-- The TokyoNight theme is a clean, dark theme with blue and purple tones, designed for a modern and visually appealing coding environment.

-- Main configuration table
-- This table contains all the configuration options for the TokyoNight color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Define the TokyoNight plugin for lazy.nvim
-- @plugin: folke/tokyonight.nvim - A plugin providing the TokyoNight color scheme for Neovim.
plugin[1] = 'folke/tokyonight.nvim'

-- Configuration function for the TokyoNight plugin.
-- This function sets up TokyoNight with custom options to ensure it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: Table - Options table containing user-defined settings for TokyoNight.
plugin.config = function(_, opts)
	-- Load the tokyonight module.
	local tokyonight = require('tokyonight')

	-- Style selection for TokyoNight
	-- TokyoNight offers different styles to suit different preferences.
	-- @option style: String - The style to be used. Options include:
	--   'storm': A darker style with stormy tones.
	--   'night': A slightly lighter version of the storm style, but still dark.
	--   'day': A light version suitable for bright environments.
	opts.style = 'night'

	-- Theme customization options
	-- These options control various aspects of the TokyoNight theme's appearance.
	opts.transparent = false			-- Disable transparency for a more consistent look.
	opts.terminal_colors = true			-- Uses terminal colors for consistency across different environments.
	opts.italic_comments = true			-- Italicizes comments to provide a more dynamic look.
	opts.bold_keywords = true			-- Makes keywords bold for better visibility.
	opts.underline_functions = false	-- Disables underlining of function names to keep the interface clean.
	opts.current_line_bg = true			-- Highlights the background of the current line to maintain focus.

	-- Apply the colorscheme
	-- This command sets the TokyoNight colorscheme with the specified style and options.
	vim.cmd[[colorscheme tokyonight]]

	-- Set up TokyoNight with the configured options
	tokyonight.setup(opts)

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true	-- Enables 24-bit RGB colors in the terminal.
	vim.opt.cursorline = true		-- Highlights the current line where the cursor is located.
	vim.opt.background = "dark"		-- Sets the background to dark mode, matching the TokyoNight theme.

	-- Customize diagnostic colors
	-- These settings adjust the color of diagnostic messages (e.g., errors, warnings) to ensure they are easily distinguishable.
	vim.cmd([[
		highlight DiagnosticError guifg=#ff5370
		highlight DiagnosticWarn guifg=#ffc777
		highlight DiagnosticInfo guifg=#82aaff
		highlight DiagnosticHint guifg=#c3e88d
	]])
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
