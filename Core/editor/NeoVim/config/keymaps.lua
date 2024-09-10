
-- keymaps.lua - Key mappings configuration for Neovim.
-- This file defines custom key bindings to improve workflow efficiency.
-- The mappings are organized into sections for clarity and maintainability.

-- ---------------------------------------------------------------------------------------------------------------------------------- --
-- Leader Key Configuration
-- ---------------------------------------------------------------------------------------------------------------------------------- --

-- Map Space as leader key
-- The leader key is used as a prefix for custom keybindings.
-- @mapleader: Space - Leader key for custom keybindings
vim.g.mapleader = ' ' -- Set leader key to Space

-- Map Space as local leader key
-- The local leader key is used as a prefix for custom keybindings within plugins.
-- @maplocalleader: Space - Local leader key for custom keybindings
vim.g.maplocalleader = ' ' -- Set local leader key to Space

-- Ensure space is not mapped to anything else
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
