-- nvim-lspconfig.lua - Custom Configuration for Omnisharp LSP in Neovim
-- This file customizes the Omnisharp setup, extending the default LazyVim configuration.

-- Main configuration table
-- This table contains all the configuration options for the Omnisharp LSP setup.
local plugin = {}

-- Define the LSPconfig plugin for lazy.nvim
-- @plugin: neovim/nvim-lspconfig - A plugin for configuring language servers in Neovim.
plugin[1] = "neovim/nvim-lspconfig"

-- Configuration function for the Omnisharp LSP
-- This function customizes the Omnisharp setup, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
plugin.config = function(_, opts)
	-- Load lspconfig module.
	-- @require: This ensures the lspconfig module is available for configuring language servers.
	local lspconfig = require("lspconfig")

	-- Ensure the servers table is initialized
	-- This ensures that any existing server configurations are preserved.
	opts.servers = opts.servers or {}

	-- Customize Omnisharp setup
	-- This block configures the Omnisharp language server specifically for .NET development.
	opts.servers.omnisharp = opts.servers.omnisharp or {}

	-- Set the default command and root directory for Omnisharp
	-- This ensures that the Omnisharp server is launched with the correct command and root directory.
	opts.servers.omnisharp.cmd = {"OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid())}

	-- Set the filetypes for Omnisharp
	-- @filetypes: String array - File types that Omnisharp will handle.
	-- opts.servers.omnisharp.filetypes = { "cs" }

	-- Set the root directory for Omnisharp
	-- @root_dir: Function - A function that identifies the root directory for a project.
	-- opts.servers.omnisharp.root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj")

	-- Enable Roslyn analyzers
	-- @enable_roslyn_analyzers: Boolean - Whether to enable Roslyn analyzers.
	opts.servers.omnisharp.enable_roslyn_analyzers = true
	
	-- Enable import completion
	-- @enable_import_completion: Boolean - Whether to enable auto-import suggestions.
	opts.servers.omnisharp.enable_import_completion = true

	-- Enable format on save
	-- @organize_imports_on_format: Boolean - Whether to organize imports when formatting.
	opts.servers.omnisharp.organize_imports_on_format = true

	-- Enable diagnostics
	-- @diagnostics: Boolean - Whether to enable diagnostics for the language server.
	opts.servers.omnisharp.diagnostics = true
	
	-- Merge custom Omnisharp settings with the defaults from LazyVim
	-- This ensures that the default LazyVim settings are preserved and extended.
	lspconfig.omnisharp.setup(opts.servers.omnisharp)
end

-- Return the complete configuration table
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
