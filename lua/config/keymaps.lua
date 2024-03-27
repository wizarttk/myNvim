-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 在任何模式下将 Shift+h 映射成 0
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })
-- 在任何模式下将 Shift+l 映射成 $
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })

-- 在normal,visual模式下，使用Ctrl + u ，Ctrl + u可以移动指定行数，将光标置于屏幕中间
vim.keymap.set(
  { "n", "v" },
  "<C-d>",
  "4jzz",
  { noremap = true, desc = "Scroll down 10 lines and center cursor after moving" }
)
vim.keymap.set(
  { "n", "v" },
  "<C-u>",
  "4kzz",
  { noremap = true, desc = "Scroll up 10 lines and center cursor after moving" }
)
