-- editorconfig.lua - Configuration for gpanders/editorconfig.nvim plugin.
-- This file sets up EditorConfig, a plugin that enforces coding style defined in .editorconfig files.
-- EditorConfig helps developers define and maintain consistent coding styles between different editors and IDEs.

-- Main configuration table
-- This table contains all the configuration options for EditorConfig.
local plugin = {}

-- Define the EditorConfig plugin for lazy.nvim
-- @plugin: gpanders/editorconfig.nvim - A plugin to enforce coding styles defined in .editorconfig files.
plugin[1] = 'gpanders/editorconfig.nvim'

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
