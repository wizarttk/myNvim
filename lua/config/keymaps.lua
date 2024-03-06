-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 在任何模式下将 Ctrl+h 映射成 0
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })

-- 在任何模式下将 Ctrl+l 映射成 $
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })
