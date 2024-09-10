-- init.lua - Main configuration entry point for Neovim.
-- This file sets up the base configuration paths, initializes the plugin manager,
-- and loads core configurations like options and keymaps.

-- Configuration Paths
_G.lazy_plugin_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
_G.lazy_plugin_config_path = "plugin"

-- Obtain the real path of the init.lua file
local script_source_info = debug.getinfo(1, "S").source:sub(2)
local real_path_init_lua = vim.loop.fs_realpath(script_source_info)

-- Normalize path separators for Windows
if package.config:sub(1, 1) == "\\" then
    real_path_init_lua = real_path_init_lua:gsub("\\", "/")
end

-- Set the environment base path
_G.env_root = real_path_init_lua:match("(.*/)"):gsub("(/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+/)$", "/")

-- Set the base directory for the configuration
_G.neovim_config_base_path = real_path_init_lua:match("(.*/)"):gsub("/[^/]+/$", "/")

-- Update the package path for Lua modules
package.path = _G.neovim_config_base_path .. "?.lua;" .. _G.neovim_config_base_path .. "?/init.lua;" .. package.path

-- Add the base configuration directory to the runtime path
vim.opt.rtp:prepend(_G.neovim_config_base_path)

-- Core Configurations
require("config.options") -- Load general Neovim options
require("config.keymaps") -- Load general NeoVim key mappings

-- Plugin Management with lazy.nvim
if not vim.loop.fs_stat(_G.lazy_plugin_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		_G.lazy_plugin_path,
	})
end

-- Add the lazy plugin path to the runtime path and load lazy.nvim
vim.opt.rtp:prepend(_G.lazy_plugin_path)
local ok, lazy = pcall(require, "lazy")
if not ok then
	print("Error loading lazy.nvim: ", lazy)
	return
end

-- initialize lazy.nvim
lazy.setup({
	spec = {
		-- LazyVim and core imports
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- Plugins UI
		{ import = "lazyvim.plugins.extras.ui.treesitter-context", lazy = true },
		{ import = "lazyvim.plugins.extras.ui.mini-indentscope", lazy = true },
		{ import = "lazyvim.plugins.extras.ui.mini-animate", lazy = true },
		{ import = "lazyvim.plugins.extras.ui.edgy", lazy = true },
		-- Plugins Editor
		{ import = "lazyvim.plugins.extras.editor.refactoring", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.illuminate", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.inc-rename", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.telescope", lazy = true, cmd = "Telescope" },
		{ import = "lazyvim.plugins.extras.editor.mini-move", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.mini-diff", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.overseer", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.harpoon2", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.outline", lazy = true, cmd = "SymbolsOutline" },
		{ import = "lazyvim.plugins.extras.editor.aerial", lazy = true, cmd = "AerialToggle" },
		{ import = "lazyvim.plugins.extras.editor.navic", lazy = true },
		{ import = "lazyvim.plugins.extras.editor.leap", lazy = true },
		-- Plugins Coding
		{ import = "lazyvim.plugins.extras.coding.mini-surround", lazy = true },
		{ import = "lazyvim.plugins.extras.coding.mini-comment", lazy = true },
		{ import = "lazyvim.plugins.extras.coding.copilot-chat", lazy = true, cmd = "Copilot" },
		{ import = "lazyvim.plugins.extras.coding.copilot", lazy = true },
		{ import = "lazyvim.plugins.extras.coding.codeium", lazy = true },
		{ import = "lazyvim.plugins.extras.coding.luasnip", lazy = true },
		{ import = "lazyvim.plugins.extras.coding.neogen", lazy = true, cmd = "Neogen" },
		{ import = "lazyvim.plugins.extras.coding.yanky", lazy = true },
		-- Plugins Tests
		{ import = "lazyvim.plugins.extras.test.core", lazy = true },
		{ import = "lazyvim.plugins.extras.test", lazy = true },
		-- Plugins LSP
		{ import = "lazyvim.plugins.extras.lsp.none-ls", lazy = true },
		{ import = "lazyvim.plugins.extras.lsp.neoconf", lazy = true },
		{ import = "lazyvim.plugins.extras.lsp", lazy = true },
		-- Plugins DAP
		{ import = "lazyvim.plugins.extras.dap.core", lazy = true },
		{ import = "lazyvim.plugins.extras.dap.nlua", lazy = true },
		{ import = "lazyvim.plugins.extras.dap", lazy = true },
		-- Plugins Lintings
		{ import = "lazyvim.plugins.extras.linting.eslint", lazy = true },
		-- Plugins Formatting
		{ import = "lazyvim.plugins.extras.formatting.prettier", lazy = true },
		{ import = "lazyvim.plugins.extras.formatting.black", lazy = true },
		-- Plugins Utils
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns", lazy = true },
		{ import = "lazyvim.plugins.extras.util.project", lazy = true },
		{ import = "lazyvim.plugins.extras.util.gitui", lazy = true, cmd = "GitUI" },
		{ import = "lazyvim.plugins.extras.util.octo", lazy = true, cmd = "Octo" },
		{ import = "lazyvim.plugins.extras.util.rest", lazy = true },
		{ import = "lazyvim.plugins.extras.util.dot", lazy = true },
		-- Plugins Langs
		{ import = "lazyvim.plugins.extras.lang.typescript", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.omnisharp", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.terraform", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.markdown", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.angular", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.python", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.docker", lazy = true },
		-- { import = 'lazyvim.plugins.extras.lang.clangd', lazy=true },
		-- { import = 'lazyvim.plugins.extras.lang.cmake', lazy=true },
		{ import = "lazyvim.plugins.extras.lang.yaml", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.json", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.java", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.helm", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.tex", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.git", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.php", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.vue", lazy = true },
		{ import = "lazyvim.plugins.extras.lang.sql", lazy = true },
		-- { import = 'lazyvim.plugins.extras.lang.go', lazy=true },
		{ import = "lazyvim.plugins.extras.lang.r", lazy = true },
		-- Disableds
		{ "iamcco/markdown-preview.nvim", disabled = true, enabled = false },
		{ "telescope-fzf-native.nvim", disabled = true, enabled = false },
		-- Settings
		{ import = _G.lazy_plugin_config_path },
	},
})

-- Symlinks for Neovim Configuration
-- @note: These commands should be run in the terminal to create the necessary symlinks.
-- Adjust the paths as needed based on your configuration directory structure.
