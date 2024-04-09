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


-- 禁用原生的按键
vim.keymap.set({"n", "v"}, "S", "<Nop>", { noremap = true })
vim.keymap.set({"n", "v"}, "S", "<Nop>", { noremap = true })
vim.keymap.set({"n", "v"}, "J", "<Nop>", { noremap = true })
vim.keymap.set({"n","v"}, "0", "<Nop>", { noremap = true })
vim.keymap.set({"n","v"}, "q", "<Nop>", { noremap = true })
vim.keymap.set({"n","v"}, "<C-S-j>", "<Nop>", { noremap = true })
vim.keymap.set({"n","v"}, "<C-w>>", "<Nop>", { noremap = true }) -- 原本是增加窗口宽度
vim.keymap.set({"n","v"}, "<C-w><", "<Nop>", { noremap = true }) -- 原本是减少窗口宽度


-- 将 normal、visual 模式下的 0 映射为 q (宏)
vim.keymap.set({"n","v"},"0","q",{noremap = true})

-- 将 normal visual 模式下的 <C-f> 映射为 /
vim.keymap.set({"n","v"}, "<C-f>", "/", { noremap = true })

-- 在任何模式下将 Shift+h 映射成 0；将Shift+l 映射成 $
vim.api.nvim_set_keymap("", "<S-l>", "$", { noremap = true })
vim.api.nvim_set_keymap("", "<S-h>", "0", { noremap = true })

-- 将 normal、visual 模式下使用<leader>j来打开vim-translator
vim.keymap.set({"v","n"}, "<leader>j", function()
  if vim.fn.mode() == "v" then
    -- vim.cmd('normal! gv"xy')
    -- local text = vim.fn.getreg("x")
    -- vim.cmd([[Translate --engines=google ]] ..text)
    vim.cmd[['<,'>Translate --engines=google]]
  else
    vim.cmd("Translate --engines=haici")
  end
end, { noremap = true, desc = "display the translation in a window"})

-- 在 visual 模式下，直接输入 引号 括号 书名号  进行包围（使用surround.nvim插件）
  -- 引号
vim.keymap.set("v", "'", function() vim.cmd("norm gsa'") end, { noremap = true })
vim.keymap.set("v", "\"", function() vim.cmd("norm gsa\"") end, { noremap = true })
  -- 大括号
vim.keymap.set("v", "]", function() vim.cmd("norm gsa]") end, { noremap = true })
vim.keymap.set("v", "[", function() vim.cmd("norm gsa[") end, { noremap = true })
  -- 小括号
vim.keymap.set("v", "(", function() vim.cmd("norm gsa(") end, { noremap = true })
vim.keymap.set("v", ")", function() vim.cmd("norm gsa)") end, { noremap = true })
  -- 大括号
vim.keymap.set("v", "{", function() vim.cmd("norm gsa{") end, { noremap = true })
vim.keymap.set("v", "}", function() vim.cmd("norm gsa}") end, { noremap = true })
  -- 单书名号
vim.keymap.set("v", "<", function() vim.cmd("norm gsa<") end, { noremap = true })
vim.keymap.set("v", ">", function() vim.cmd("norm gsa>") end, { noremap = true })

-- 拓展 v 的范围
  -- 普通模式下双击v，选中当前单词
vim.keymap.set({ "n" },"vv", function() vim.cmd("norm viw") end, { noremap = true }, { desc = "Select the current word" })

-------------------------------------------------------------------------------------------
--buffer 和 窗口（win）
-- 切换buffer
vim.keymap.set("n", "<C-S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" }) -- 将<C-S-h>映射为转到前一个buffer
vim.keymap.set("n", "<C-S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" }) -- 将<C-S-l>映射为转到下一个buffer
vim.keymap.set("n", "<C-a>", "<cmd>bdel<cr>", { desc = "Delete Buffer" }) -- 将<C-a>映射为关闭当前buffer

-- 切换窗口(win)
-- 在 insert 模式时也能切换窗口 
  -- <C-j> 切换到下方窗口
vim.keymap.set('i', '<C-j>', function()
  vim.cmd('wincmd j')
  vim.cmd("stopinsert") -- 使用vim的内部命令，退出插入模式
end, { noremap = true })

  -- <C-k> 切换到上方窗口
vim.keymap.set("i", "<C-k>", function()
  vim.cmd('wincmd k')
  vim.cmd("stopinsert")
end, { noremap = true })

-- 调整窗口宽度(最右侧窗口不能使用)
  -- 使用 <C-.> 向右移动
vim.keymap.set({ "n","v","i" }, "<C-.>", function()
  vim.fn.win_move_separator(vim.fn.winnr(), 5)
  end, { noremap = true })

  -- 使用 <C-,> 向左移动
vim.keymap.set({ "n","v","i" }, "<C-,>", function()
  vim.fn.win_move_separator(vim.fn.winnr(), -5)
  end, { noremap = true })

---------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------

