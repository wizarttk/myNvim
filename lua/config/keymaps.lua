-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--[[
全局映射：(更加底层)
      vim.api.nvim_set_keymap()
      vim.api.nvim_get_keymap()
      vim.api.nvim_del_keymap()
缓冲区映射：(用于特定缓冲区)
      vim.api.nvim_buf_set_keymap()
      vim.api.nvim_buf_get_keymap()
      vim.api.nvim_buf_del_keymap()
推荐使用： (包装好的,可以实现复杂功能,可以使用函数)
      vim.keymap.set()
      vim.keymap.del()

插件的映射在"plugins目录"中设置
--]]

-- 在任何模式下将 Shift+h 映射成 0；将Shift+l 映射成 $
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })

-- 禁用原生的按键
vim.keymap.set({"n", "v"}, "S", "<Nop>", { noremap = true })
vim.keymap.set({"n", "v"}, "S", "<Nop>", { noremap = true })

-- 在normal,visual模式下，使用Ctrl + u ，Ctrl + u可以移动指定行数，将光标置于屏幕中间(zz)
vim.keymap.set(
  { "n", "v" },
  "<C-d>",
function()
    local cur_line = vim.fn.line(".") -- 当前光标行号
    local after_line = cur_line + 5 -- 移动后的光标行号
    local bottom_line = vim.fn.line('w$') -- 获取窗口最后一行的行号 （w$ 表示窗口最后一行；为0表示第一行）
    -- local bottom_line = vim.fn.line('w0') + vim.fn.winheight(0) - 1 -- 窗口最后一行光标行号 = 窗口第一行的行号 + 窗口行号高度 -1
    --
    if bottom_line - after_line <=4 then -- 如果移动后行号位于最后四行
      vim.fn.execute("norm zz")
      -- vim.fn.cursor({after_line,0}) 等价于下面的:
      vim.fn.execute("norm 5j")
  else
      vim.fn.execute("norm 5j")
    end
  end,
  { noremap = true, desc = "Scroll down 10 lines and center cursor after moving" }
)

vim.keymap.set(
  { "n", "v" },
  "<C-u>",
  "5k",
  { noremap = true, desc = "Scroll up 10 lines and center cursor after moving" }
)

-- 切换buffer
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" }) -- 将<C-h>映射为转到前一个buffer
vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" }) -- 将<C-l>映射为转到下一个buffer
vim.keymap.set("n", "<C-a>", "<cmd>bdel<cr>", { desc = "Delete Buffer" }) -- 将<C-a>映射为关闭当前buffer
