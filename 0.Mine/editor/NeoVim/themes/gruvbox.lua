-- gruvbox.lua - Configuration for Gruvbox colorscheme with LazyVim integration.
-- This file sets up the Gruvbox colorscheme for Neovim, focusing on reducing visual fatigue and providing a warm, earthy palette.

-- Main configuration table
-- This table contains all the configuration options for the Gruvbox color scheme.
-- It is designed to integrate seamlessly with the lazy.nvim plugin manager.
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'ellisonleao/gruvbox.nvim': A modern port of the classic Gruvbox colorscheme for Neovim.
plugin[1] = 'ellisonleao/gruvbox.nvim'

-- Function to configure the plugin
-- This function sets up the colorscheme options, including contrast levels, styles, and integrations.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring Gruvbox.
plugin.opts = function(_, opts)
	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts = opts or {}
	opts.integrations = opts.integrations or {}

	-- Override default configurations for Gruvbox

	-- Set contrast level for Gruvbox
	-- @contrast: String - Adjusts the overall contrast of the colorscheme.
	-- Options:
	--   'hard'   : High contrast.
	--   'medium' : Default contrast.
	--   'soft'   : Low contrast, reducing visual strain.
	opts.contrast = 'soft'

	-- Apply background transparency
	-- @transparent_background: Boolean - Determines whether the background is transparent.
	opts.transparent_background = false

	-- Enable terminal colors to match the colorscheme
	-- @term_colors: Boolean - Ensures that terminal colors follow the colorscheme.
	opts.term_colors = true

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
	-- This command activates the Gruvbox colorscheme with the specified options.
	vim.cmd.colorscheme('gruvbox')

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true  -- Enables 24-bit RGB colors in the terminal.
	vim.opt.background = "dark"   -- Sets the background to dark mode, matching Gruvbox's default.
	vim.opt.cursorline = true     -- Highlights the current line where the cursor is located.

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
