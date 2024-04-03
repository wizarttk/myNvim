-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--[[                     模板
            vim.keymap.set(mode, lhs, rhs, opts)
              mode  模式
              lhs   按键
              rhs   功能
              opts  一个表,包含了一些额外的选项,如 buffer、remap、noremap、desc等
--]]

-- 在任何模式下将 Shift+h 映射成 0；将Shift+l 映射成 $
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })

-- 在normal,visual模式下，使用Ctrl + u ，Ctrl + u可以移动指定行数，将光标置于屏幕中间
vim.keymap.set(
  { "n", "v" },
  "<C-d>",
  "5jzz",
  { noremap = true, desc = "Scroll down 10 lines and center cursor after moving" }
)
vim.keymap.set(
  { "n", "v" },
  "<C-u>",
  "5kzz",
  { noremap = true, desc = "Scroll up 10 lines and center cursor after moving" }
)

-- 切换buffer
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" }) -- 将<C-h>映射为转到前一个buffer
vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" }) -- 将<C-l>映射为转到下一个buffer
vim.keymap.set("n", "<C-a>", "<cmd>bdel<cr>", { desc = "Delete Buffer" }) -- 将<C-a>映射为关闭当前buffer
