-- Main configuration table
-- This table contains all the configuration options for the Monokai color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'tanvirtin/monokai.nvim': A modern interpretation of the classic Monokai theme.
plugin[1] = 'tanvirtin/monokai.nvim'

-- Function to configure the plugin
-- This function sets up the colorscheme options, including style choices and plugin integrations.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring Monokai.
plugin.opts = function(_, opts)
	-- Load the monokai module.
	local monokai = require('monokai')

	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts = opts or {}
	opts.palette = opts.palette or {}
	opts.integrations = opts.integrations or {}

	-- Override default configurations for Monokai
	
	-- Choose the style of Monokai
	-- @style: String - Defines the Monokai variant to use.
	-- Options:
	--   'classic' : The original Monokai theme.
	--   'pro'     : A modern take with refined colors, emulating Monokai Pro.
	--   'soda'    : A brighter, soda-themed variant.
	opts.style = 'pro'

	-- Theme customization options
	-- These options control various aspects of the Monokai theme's appearance.
	opts.transparent = true				-- Enables a transparent background, making the theme blend with terminal background.
	opts.terminal_colors = true			-- Uses terminal colors for consistency across different environments.
	opts.italic_comments = true			-- Italicizes comments for better differentiation from code.
	opts.bold_keywords = true			-- Makes keywords bold to improve visibility.
	opts.underline_functions = true		-- Underlines function names to emphasize them.
	opts.current_line_bg = true			-- Highlights the background of the current line to improve focus.

	-- Apply background transparency
	-- @transparent_background: Boolean - Determines whether the background is transparent.
	opts.transparent_background = false

	-- Enable terminal colors to match the colorscheme
	-- @term_colors: Boolean - Ensures that terminal colors follow the colorscheme.
	opts.term_colors = true

	-- Monokai provides multiple palettes, each offering a different variation of the theme.
	-- @option palette: Table - The color palette to be used. Options include:
	--   monokai.pro: A professional version with enhanced contrast.
	--   monokai.soda: A softer version with slightly muted colors.
	--   monokai.ristretto: A darker version with a focus on readability.
	-- @palette: Table - Allows for custom tweaks to the Monokai color palette.
	opts.palette = monokai.pro

	-- Enable integrations with various plugins

	-- Treesitter integration
	-- @treesitter: Boolean - Enables integration with Treesitter for enhanced syntax highlighting.
	opts.integrations.treesitter = true

	-- Native LSP integration
	-- @native_lsp: Table - Configures the integration with Neovim's native LSP client.
	opts.integrations.native_lsp = true

	-- Additional plugin integrations
	-- @integrations: Table - Enables and configures integrations for other popular plugins.
	opts.integrations.cmp = true
	opts.integrations.gitsigns = true
	opts.integrations.telescope = true
	opts.integrations.nvimtree = true

	-- Apply the colorscheme
	-- This command activates the Monokai colorscheme with the specified options.
	vim.cmd.colorscheme('monokai_' .. opts.style)

	-- Customize diagnostic colors
	-- These settings adjust the color of diagnostic messages (e.g., errors, warnings) to ensure they are easily distinguishable.
	vim.cmd([[
		highlight DiagnosticError guifg=#FF5370
		highlight DiagnosticWarn guifg=#FFB62C
		highlight DiagnosticInfo guifg=#82AAFF
		highlight DiagnosticHint guifg=#89DDFF
	]])

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true  -- Enables 24-bit RGB colors in the terminal.
	vim.opt.background = "dark"   -- Sets the background to dark mode, matching Monokai's default.
	vim.opt.cursorline = true     -- Highlights the current line where the cursor is located.

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
