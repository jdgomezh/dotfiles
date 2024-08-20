-- monokai.lua - Configuration for tanvirtin/monokai.nvim plugin.
-- This file sets up the Monokai color scheme for Neovim.
-- The Monokai theme is designed to provide a high contrast, visually appealing environment.

-- Main configuration table
-- This table contains all the configuration options for the Monokai color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Define the Monokai plugin for lazy.nvim
-- @plugin: tanvirtin/monokai.nvim - A plugin providing the Monokai color scheme for Neovim.
plugin[1] = 'tanvirtin/monokai.nvim'

-- Configuration function for the Monokai plugin.
-- This function sets up Monokai with custom options to ensure it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: Table - Options table containing user-defined settings for Monokai.
plugin.config = function(_, opts)
	-- Load the monokai module.
	local monokai = require('monokai')

	-- Palette selection for Monokai
	-- Monokai provides multiple palettes, each offering a different variation of the theme.
	-- @option palette: Table - The color palette to be used. Options include:
	--   monokai.pro: A professional version with enhanced contrast.
	--   monokai.soda: A softer version with slightly muted colors.
	--   monokai.ristretto: A darker version with a focus on readability.
	opts.palette = monokai.pro

	-- Theme customization options
	-- These options control various aspects of the Monokai theme's appearance.
	opts.transparent = true				-- Enables a transparent background, making the theme blend with terminal background.
	opts.terminal_colors = true			-- Uses terminal colors for consistency across different environments.
	opts.italic_comments = true			-- Italicizes comments for better differentiation from code.
	opts.bold_keywords = true			-- Makes keywords bold to improve visibility.
	opts.underline_functions = true		-- Underlines function names to emphasize them.
	opts.current_line_bg = true			-- Highlights the background of the current line to improve focus.

	-- Apply the colorscheme
	-- This command sets the Monokai colorscheme with the specified palette and options.
	vim.cmd[[colorscheme monokai_pro]]

	-- Set up Monokai with the configured options
	monokai.setup(opts)

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true	-- Enables 24-bit RGB colors in the terminal.
	vim.opt.cursorline = true		-- Highlights the current line where the cursor is located.
	vim.opt.background = "dark"		-- Sets the background to dark mode, matching the Monokai theme.

	-- Customize diagnostic colors
	-- These settings adjust the color of diagnostic messages (e.g., errors, warnings) to ensure they are easily distinguishable.
	vim.cmd([[
		highlight DiagnosticError guifg=#FF5370
		highlight DiagnosticWarn guifg=#FFB62C
		highlight DiagnosticInfo guifg=#82AAFF
		highlight DiagnosticHint guifg=#89DDFF
	]])
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
