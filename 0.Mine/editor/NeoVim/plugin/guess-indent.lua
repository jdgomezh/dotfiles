-- guess-indent.lua - Configuration for nmac427/guess-indent.nvim plugin.
-- This file sets up Guess Indent, a plugin that automatically detects and sets the indentation style for files.
-- Guess Indent provides a seamless experience by determining whether a file uses spaces or tabs, and adjusts Neovim's settings accordingly.

-- Main configuration table
-- This table contains all the configuration options for Guess Indent.
local plugin = {}

-- Define the Guess Indent plugin for lazy.nvim
-- @plugin: nmac427/guess-indent.nvim - A plugin to automatically detect and set indentation style for files.
plugin[1] = 'nmac427/guess-indent.nvim'

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
