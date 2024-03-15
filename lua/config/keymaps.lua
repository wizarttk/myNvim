-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 在任何模式下将 Shift+h 映射成 0
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })
-- 在任何模式下将 Shift+l 映射成 $
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })

-- 在普通模式下，使用Ctrl + u ，Ctrl + u移动后，将光标置于屏幕中间
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving down up-page" })
