-- gruvbox.lua - Configuration for ellisonleao/gruvbox.nvim plugin.
-- This file sets up the Gruvbox color scheme for Neovim.
-- The Gruvbox theme is known for its retro groove and is designed to provide a comfortable, low-contrast coding environment.

-- Main configuration table
-- This table contains all the configuration options for the Gruvbox color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Define the Gruvbox plugin for lazy.nvim
-- @plugin: ellisonleao/gruvbox.nvim - A plugin providing the Gruvbox color scheme for Neovim.
plugin[1] = 'ellisonleao/gruvbox.nvim'

-- Configuration function for the Gruvbox plugin.
-- This function sets up Gruvbox with custom options to ensure it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin.
-- @param opts: Table - Options table containing user-defined settings for Gruvbox.
plugin.config = function(_, opts)
	-- Load the gruvbox module.
	local gruvbox = require('gruvbox')

	-- Palette selection for Gruvbox
	-- Gruvbox provides different palettes based on light or dark background preferences.
	-- @option background: String - The background mode to be used. Options include:
	--   'dark': A darker version of the Gruvbox theme for a traditional coding environment.
	--   'light': A lighter version of the Gruvbox theme for bright settings.
	opts.background = 'dark'

	-- Theme customization options
	-- These options control various aspects of the Gruvbox theme's appearance.
	opts.contrast = 'soft'				-- Use a softer contrast level to reduce eye strain.
	opts.transparent = false			-- Disable transparency for a more traditional look.
	opts.italic_comments = true			-- Italicizes comments to differentiate them from code.
	opts.bold_keywords = false			-- Keeps keywords in regular font weight for a more subdued appearance.
	opts.underline_functions = false	-- Disables underlining of function names for simplicity.
	opts.current_line_bg = true			-- Highlights the background of the current line to improve focus.

	-- Apply the colorscheme
	-- This command sets the Gruvbox colorscheme with the specified palette and options.
	vim.cmd[[colorscheme gruvbox]]

	-- Set up Gruvbox with the configured options
	gruvbox.setup(opts)

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true	-- Enables 24-bit RGB colors in the terminal.
	vim.opt.cursorline = true		-- Highlights the current line where the cursor is located.
	vim.opt.background = opts.background -- Sets the background mode (dark/light) to match the Gruvbox theme.

	-- Customize diagnostic colors
	-- These settings adjust the color of diagnostic messages (e.g., errors, warnings) to ensure they are easily distinguishable.
	vim.cmd([[
		highlight DiagnosticError guifg=#fb4934
		highlight DiagnosticWarn guifg=#fabd2f
		highlight DiagnosticInfo guifg=#83a598
		highlight DiagnosticHint guifg=#8ec07c
	]])
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
