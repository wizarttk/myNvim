-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- VIM有命令的文档：https://yianwillis.github.io/vimcdoc/doc/autocmd.html#BufNew

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

-- 自动插入shebang
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.sh" }, -- 匹配
  callback = function()
    local firstLine = vim.fn.getline(1)
    if string.match(firstLine, "#!") then
      return
    else
      vim.fn.setbufline(vim.fn.bufnr(), 1, "#!/usr/bin/zsh")
    end
  end,
})
