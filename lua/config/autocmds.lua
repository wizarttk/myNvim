-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- VIM命令的文档：https://yianwillis.github.io/vimcdoc/doc/autocmd.html#BufNew

--------------------------------------------------------------------------------------------------------------------------
-- 自动输入法切换
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    local input_status = tonumber(vim.fn.system("fcitx5-remote"))
    if input_status == 2 then
      vim.fn.system("fcitx5-remote -c")
    end
  end,
})

-- 注释时自动切换输入法
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = { "*" },
  callback = function()
    -- 获取当前行
    local line = vim.api.nvim_get_current_line()

    -- 获取当前光标所在的列
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- 获取注释符号（去掉 %s ）
    local commentstring = vim.bo.commentstring:gsub("%%s", "")

    -- 查找注释符号在行中的位置
    local comment_pos = line:find(commentstring, 1, true)

    -- 如果找到了注释符号，并且光标位于注释符号之后
    if comment_pos and col > comment_pos then
      vim.fn.system("fcitx5-remote -o")
      -- else
      --   return
    end
  end
})

-- 自动插入shebang
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.sh" }, -- 匹配
  callback = function()
    local firstLine = vim.fn.getline(1)
    if string.match(firstLine, "#!") then
      return
    else
      vim.fn.setbufline(vim.fn.bufnr(), 1, "#!/usr/bin/bash")
    end
  end,
})

-- linter自动命令
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.sh" },
  callback = function()
    require('lint').try_lint("shellcheck")
  end
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.js" },
  callback = function()
    require("lint").try_lint("oxlint")
  end
})

-- -- 自动切换zen模式的按键
-- -- 1.切换窗口的时候进行检测
-- vim.api.nvim_create_autocmd({ "WinEnter" }, {
--   -- 2. 判断是否是在zen-mode
--   -- require("snacks").setup({
--   -- })
-- })
