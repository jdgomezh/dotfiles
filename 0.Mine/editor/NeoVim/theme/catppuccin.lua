-- catppuccin.lua - Configuration for Catppuccin colorscheme with LazyVim integration.
-- This file sets up the Catppuccin colorscheme for Neovim, focusing on reducing visual fatigue and providing extensive plugin integration.

-- Define the main configuration table for the plugin
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'catppuccin/nvim': A soothing colorscheme for Neovim, offering multiple flavor options.
plugin[1] = 'catppuccin/nvim'

-- Function to configure the plugin
-- This function sets up the colorscheme options, including the flavor, styling, and integration settings.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring Catppuccin.
plugin.opts = function(_, opts)
	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts.styles = opts.styles or {}
	opts.integrations = opts.integrations or {}
	opts.styles.comments = opts.styles.comments or {}
	opts.styles.keywords = opts.styles.keywords or {}
	opts.styles.functions = opts.styles.functions or {}
	opts.styles.variables = opts.styles.variables or {}
	opts.integrations.navic = opts.integrations.navic or {}
	opts.integrations.nvimtree = opts.integrations.nvimtree or {}
	opts.integrations.native_lsp = opts.integrations.native_lsp or {}
	opts.integrations.indent_blankline = opts.integrations.indent_blankline or {}
	opts.integrations.native_lsp.underlines = opts.integrations.native_lsp.underlines or {}
	opts.integrations.native_lsp.virtual_text = opts.integrations.native_lsp.virtual_text or {}
	opts.integrations.native_lsp.virtual_text.hints = opts.integrations.native_lsp.virtual_text.hints or {}
	opts.integrations.native_lsp.virtual_text.errors = opts.integrations.native_lsp.virtual_text.errors or {}
	opts.integrations.native_lsp.virtual_text.warnings = opts.integrations.native_lsp.virtual_text.warnings or {}
	opts.integrations.native_lsp.virtual_text.information = opts.integrations.native_lsp.virtual_text.information or {}

	-- Override default configurations for Catppuccin

	-- Set the flavor of Catppuccin
	-- @flavour: String - Defines the overall color palette to use.
	-- Options:
	--   'latte'     : Light theme with soft colors.
	--   'frappe'    : Darker theme with muted tones.
	--   'macchiato' : Darker theme with a balance of vibrant and muted tones.
	--   'mocha'     : Rich and dark theme, ideal for prolonged coding sessions.
	opts.flavour = 'frappe'

	-- Configure background transparency
	-- @transparent_background: Boolean - Determines whether the background is transparent.
	-- false: Opaque background.
	-- true: Transparent background, allowing terminal background to show through.
	opts.transparent_background = false

	-- Enable terminal colors to match the colorscheme
	-- @term_colors: Boolean - Ensures that terminal colors follow the colorscheme.
	opts.term_colors = true

	-- Apply styling options to various syntax elements

	-- Set the style for comments
	-- @comments: Table - Defines the style to apply to comments.
	-- Options include 'italic', 'bold', etc.
	table.insert(opts.styles.comments, 'italic')

	-- Set the style for keywords
	-- @keywords: Table - Defines the style to apply to keywords (e.g., if, else, for).
	table.insert(opts.styles.keywords, 'bold')

	-- Set the style for functions
	-- @functions: Table - Defines the style to apply to function names.
	table.insert(opts.styles.functions, 'bold')

	-- Enable integrations with various plugins

	-- Treesitter integration
	-- @treesitter: Boolean - Enables integration with Treesitter for enhanced syntax highlighting.
	opts.integrations.treesitter = true

	-- Native LSP integration
	-- @native_lsp: Table - Configures the integration with Neovim's native LSP client.
	opts.integrations.native_lsp.enabled = true

	-- Set styling for virtual text in LSP diagnostics
	-- @virtual_text: Table - Configures the appearance of inline diagnostic messages.
	table.insert(opts.integrations.native_lsp.virtual_text.errors, 'italic')
	table.insert(opts.integrations.native_lsp.virtual_text.hints, 'italic')
	table.insert(opts.integrations.native_lsp.virtual_text.warnings, 'italic')
	table.insert(opts.integrations.native_lsp.virtual_text.information, 'italic')

	-- Set underlines for LSP diagnostics
	-- @underlines: Table - Configures the appearance of underlines for diagnostics.
	-- Default style is 'undercurl' to enhance visibility.
	table.insert(opts.integrations.native_lsp.underlines.errors, 'undercurl')
	table.insert(opts.integrations.native_lsp.underlines.hints, 'undercurl')
	table.insert(opts.integrations.native_lsp.underlines.warnings, 'undercurl')
	table.insert(opts.integrations.native_lsp.underlines.information, 'undercurl')

	-- Additional plugin integrations based on user needs
	-- @integrations: Table - Enables and configures integrations for other popular plugins.
	opts.integrations.aerial = true
	opts.integrations.alpha = true
	opts.integrations.cmp = true
	opts.integrations.dashboard = true
	opts.integrations.flash = true
	opts.integrations.grug_far = true
	opts.integrations.headlines = true
	opts.integrations.illuminate = true
	opts.integrations.indent_blankline.enabled = true
	opts.integrations.leap = true
	opts.integrations.lsp_trouble = true
	opts.integrations.mason = true
	opts.integrations.markdown = true
	opts.integrations.mini = true

	-- Navic integration
	-- @navic: Table - Configures integration with nvim-navic for enhanced navigation.
	-- @custom_bg: String or nil - Sets a custom background for Navic, can be set to 'lualine' for seamless integration.
	opts.integrations.navic.enabled = true
	opts.integrations.navic.custom_bg = "lualine"

	-- Neotest integration
	-- @neotest: Boolean - Enables integration with Neotest for testing workflows.
	opts.integrations.neotest = true

	-- Neotree integration
	-- @neotree: Boolean - Enables integration with Neotree for file exploration.
	opts.integrations.neotree = true

	-- Noice integration
	-- @noice: Boolean - Enables integration with Noice for enhanced UI notifications.
	opts.integrations.noice = true

	-- Notify integration
	-- @notify: Boolean - Enables integration with Notify for in-editor notifications.
	opts.integrations.notify = true

	-- Semantic tokens integration
	-- @semantic_tokens: Boolean - Enables support for semantic tokens provided by LSPs.
	opts.integrations.semantic_tokens = true

	-- Treesitter Context integration
	-- @treesitter_context: Boolean - Enables integration with Treesitter Context for sticky function headers.
	opts.integrations.treesitter_context = true

	-- Which-key integration
	-- @which_key: Boolean - Enables integration with which-key.nvim for displaying key bindings.
	opts.integrations.which_key = true

	-- Apply the colorscheme
	-- This command activates the Catppuccin colorscheme with the specified options.
	vim.cmd.colorscheme('catppuccin-frappe')

	-- Additional Neovim visual settings
	-- These settings enhance the overall visual experience by enabling 24-bit colors and highlighting.
	vim.opt.termguicolors = true	-- Enables 24-bit RGB colors in the terminal.
	--vim.opt.background = "dark"		-- Sets the background to dark mode, matching the Monokai theme.
	vim.opt.cursorline = true		-- Highlights the current line where the cursor is located.

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
