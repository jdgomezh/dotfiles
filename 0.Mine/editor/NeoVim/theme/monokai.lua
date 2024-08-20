-- monokai.lua - Configuration for tanvirtin/monokai.nvim plugin.
-- This file sets up the Monokai color scheme for Neovim, providing an attractive and eye-friendly interface.
-- The configuration is optimized for prolonged use, minimizing eye strain through careful color adjustments.

-- Main configuration table
-- This table contains all the configuration options for the Monokai color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: tanvirtin/monokai.nvim - A plugin that provides the Monokai color scheme for Neovim.
-- This plugin helps in creating a visually appealing and comfortable environment for coding.
plugin[1] = 'tanvirtin/monokai.nvim'

-- Configuration function for the Monokai plugin.
-- This function sets up Monokai with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for Monokai.
plugin.config = function(PluginSpec, opts)
	-- Load the monokai module.
	-- @require: Require the monokai module for configuration.
	local monokai = require('monokai')

	-- Set the palette for the monokai theme
	-- Available options: monokai.pro, monokai.soda, monokai.ristretto
	-- You can choose the one that suits your preference.
	opts.palette = monokai.pro

	-- Additional customization for visual comfort
	opts.transparent = true				-- Enable transparency for the background
	opts.terminal_colors = true			-- Use terminal colors for better consistency
	opts.italic_comments = true			-- Italicize comments to differentiate them from code
	opts.bold_keywords = true			-- Make keywords bold for better visibility
	opts.underline_functions = true		-- Underline function names for emphasis
	opts.current_line_bg = true			-- Highlight the background of the current line

	-- Apply the colorscheme
	-- @cmd: colorscheme monokai
	-- @impact: Applies the Monokai colorscheme with the specified palette and options.
	vim.cmd[[colorscheme monokai_pro]]

	-- Setup the monokai theme with the given options
	monokai.setup(opts)

	-- Configure Neovim to enhance the visual experience
	vim.opt.termguicolors = true	-- Ensure 24-bit RGB colors in the terminal
	vim.opt.cursorline = true		-- Highlight the current line
	vim.opt.background = "dark"		-- Set the background color to dark

	-- Optional: Customize diagnostic colors for better visibility
	-- This ensures that errors, warnings, and other diagnostics are easily distinguishable.
	vim.cmd([[
		highlight DiagnosticError guifg=#FF5370
		highlight DiagnosticWarn guifg=#FFB62C
		highlight DiagnosticInfo guifg=#82AAFF
		highlight DiagnosticHint guifg=#89DDFF
	]])
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
