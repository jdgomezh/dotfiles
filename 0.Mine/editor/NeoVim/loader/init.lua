-- init.lua - Main configuration entry point for Neovim.
-- This file sets up base paths, initializes the plugin manager,
-- and loads core configurations such as options and keymaps.
-- It is the central configuration file for Neovim and coordinates the loading
-- of plugins, themes, and core settings.

-- Set the theme to be used
-- @param selected_theme: String - The name of the theme to be applied. 
--   Valid options:
--     'catppuccin': A light theme with blue and purple tones.
--     'tokyonight': A dark theme with blue and purple tones.
--     'monokai': A vibrant theme with high contrast.
--     'gruvbox': A retro groove color scheme.
local selected_theme = 'monokai'

-- Base Configuration Paths
-- @global CONFIG_PATHS: Table - Stores paths used for plugin and lazy loader configuration.
--   Fields:
--     plugin: String - Path to the plugin configurations.
--     lazy_loader: String - Path where the lazy.nvim plugin manager is installed.
_G.CONFIG_PATHS = {
	plugin = 'plugin',
	lazy_loader = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
}

-- Resolve the absolute path to the init.lua file
-- @param init_script_path: String - The path of the current init.lua script.
-- @param absolute_init_path: String - The absolute path resolved from the init_script_path.
local init_script_path = debug.getinfo(1, 'S').source:sub(2)
local absolute_init_path = vim.loop.fs_realpath(init_script_path)

-- Normalize path separators for Windows
-- Converts backslashes to forward slashes if running on Windows.
-- @condition: Runs only if the system uses backslashes as path separators.
if package.config:sub(1, 1) == '\\' then
	absolute_init_path = absolute_init_path:gsub('\\', '/')
end

-- Define base paths
-- @global PATHS: Table - Stores paths used throughout the configuration.
--   Fields:
--     env_root: String - The root directory for the Neovim environment.
--     config_base: String - The base directory for Neovim configuration files.
_G.PATHS = {
	env_root = absolute_init_path:match('(.*/)'):gsub('(/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+/)$', '/'),
	config_base = absolute_init_path:match('(.*/)'):gsub('/[^/]+/$', '/')
}

-- Update Lua package path
-- This ensures that Lua can load modules from the config_base directory.
-- @operation: Appends the config_base path to the Lua package path for module resolution.
package.path = table.concat({
	_G.PATHS.config_base .. '?.lua',
	_G.PATHS.config_base .. '?/init.lua',
	package.path
}, ';')

-- Add the configuration directory to the runtime path
-- This allows Neovim to locate configuration files located in the config_base directory.
vim.opt.rtp:prepend(_G.PATHS.config_base)

-- Load core configurations
-- These are essential settings and key mappings required for Neovim's operation.
require('config.options')  -- General Neovim options such as line numbers, encoding, etc.
require('config.keymaps')  -- Custom key mappings for improved workflow.

-- Initialize Plugin Management with lazy.nvim
-- This section checks if lazy.nvim is installed, and if not, installs it.
-- lazy.nvim is a plugin manager designed to efficiently load Neovim plugins.
if not vim.loop.fs_stat(_G.CONFIG_PATHS.lazy_loader) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'git@github.com:folke/lazy.nvim.git',
		'--branch=stable',
		_G.CONFIG_PATHS.lazy_loader,
	})
end

-- Load lazy.nvim
-- This ensures lazy.nvim is loaded and available for managing plugins.
vim.opt.rtp:prepend(_G.CONFIG_PATHS.lazy_loader)
local ok, lazy = pcall(require, 'lazy')
if not ok then
	error('Error loading lazy.nvim: ' .. lazy)
end

-- Load theme manager and apply the selected theme
-- The theme manager handles selecting and applying the appropriate color scheme and other theme-related settings.
-- @operation: Initializes the theme manager with the selected theme.
_G.theme_manager = require('helper.theme_manager').init(selected_theme)

-- Setup plugins with lazy.nvim
-- This section lists all plugins and configurations to be managed by lazy.nvim.
-- @spec: Table - The specification table containing all plugin configurations.
-- Each import statement references a specific plugin or set of plugins to be loaded.
lazy.setup({
	spec = {
		-- LazyVim and core imports
		{ 'LazyVim/LazyVim', import = 'lazyvim.plugins', opts = {  colorscheme = selected_theme } },
		-- Plugins UI
		{ import = 'lazyvim.plugins.extras.ui.treesitter-context', lazy = true },
		{ import = 'lazyvim.plugins.extras.ui.mini-indentscope', lazy = true },
		{ import = 'lazyvim.plugins.extras.ui.mini-animate', lazy = true },
		{ import = 'lazyvim.plugins.extras.ui.mini-starter', lazy = true },
		{ import = 'lazyvim.plugins.extras.ui.alpha', lazy = true },
		{ import = 'lazyvim.plugins.extras.ui.edgy', lazy = true },
		-- Plugins Editor
		{ import = 'lazyvim.plugins.extras.editor.refactoring', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.illuminate', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.inc-rename', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.telescope', lazy = true, cmd = 'Telescope' },
		{ import = 'lazyvim.plugins.extras.editor.mini-move', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.mini-diff', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.overseer', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.harpoon2', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.outline', lazy = true, cmd = 'SymbolsOutline' },
		{ import = 'lazyvim.plugins.extras.editor.aerial', lazy = true, cmd = 'AerialToggle' },
		{ import = 'lazyvim.plugins.extras.editor.navic', lazy = true },
		{ import = 'lazyvim.plugins.extras.editor.leap', lazy = true },
		-- Plugins Coding
		{ import = 'lazyvim.plugins.extras.coding.mini-surround', lazy = true },
		{ import = 'lazyvim.plugins.extras.coding.mini-comment', lazy = true },
		-- { import = 'lazyvim.plugins.extras.coding.copilot-chat', lazy = true, cmd = 'Copilot' },
		-- { import = 'lazyvim.plugins.extras.coding.copilot', lazy = true },
		-- { import = 'lazyvim.plugins.extras.coding.codeium', lazy = true },
		{ import = 'lazyvim.plugins.extras.coding.luasnip', lazy = true },
		{ import = 'lazyvim.plugins.extras.coding.neogen', lazy = true, cmd = 'Neogen' },
		{ import = 'lazyvim.plugins.extras.coding.yanky', lazy = true },
		-- Plugins Tests
		{ import = 'lazyvim.plugins.extras.test.core', lazy = true },
		{ import = 'lazyvim.plugins.extras.test', lazy = true },
		-- Plugins LSP
		{ import = 'lazyvim.plugins.extras.lsp.none-ls', lazy = true },
		{ import = 'lazyvim.plugins.extras.lsp.neoconf', lazy = true },
		{ import = 'lazyvim.plugins.extras.lsp', lazy = true },
		-- Plugins DAP
		{ import = 'lazyvim.plugins.extras.dap.core', lazy = true },
		{ import = 'lazyvim.plugins.extras.dap.nlua', lazy = true },
		{ import = 'lazyvim.plugins.extras.dap', lazy = true },
		-- Plugins Lintings
		{ import = 'lazyvim.plugins.extras.linting.eslint', lazy = true },
		-- Plugins Formatting
		{ import = 'lazyvim.plugins.extras.formatting.prettier', lazy = true },
		{ import = 'lazyvim.plugins.extras.formatting.black', lazy = true },
		-- Plugins Utils
		{ import = 'lazyvim.plugins.extras.util.mini-hipatterns', lazy = true },
		{ import = 'lazyvim.plugins.extras.util.project', lazy = true },
		{ import = 'lazyvim.plugins.extras.util.gitui', lazy = true, cmd = 'GitUI' },
		{ import = 'lazyvim.plugins.extras.util.octo', lazy = true, cmd = 'Octo' },
		{ import = 'lazyvim.plugins.extras.util.rest', lazy = true },
		{ import = 'lazyvim.plugins.extras.util.dot', lazy = true },
		-- Plugins Langs
		{ import = 'lazyvim.plugins.extras.lang.typescript', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.omnisharp', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.terraform', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.markdown', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.angular', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.python', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.docker', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.clangd', lazy=true },
		-- { import = 'lazyvim.plugins.extras.lang.cmake', lazy=true },
		{ import = 'lazyvim.plugins.extras.lang.yaml', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.json', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.java', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.helm', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.tex', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.git', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.php', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.vue', lazy = true },
		{ import = 'lazyvim.plugins.extras.lang.sql', lazy = true },
		-- { import = 'lazyvim.plugins.extras.lang.go', lazy = true },
		-- { import = 'lazyvim.plugins.extras.lang.r', lazy = true },
		-- Disableds
		{ 'iamcco/markdown-preview.nvim', disabled = true, enabled = false },
		{ 'telescope-fzf-native.nvim', disabled = true, enabled = false },
		-- Plugins and Settings
		{ import = _G.CONFIG_PATHS.plugin },
		-- Theme
		{ import = _G.theme_manager.get_theme_config_file() },
	},
})
