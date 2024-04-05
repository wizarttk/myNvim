-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 使用 set option_name? 命令来查看选项的状态

vim.opt.clipboard = { "unnamed", "unnamedplus" } -- Sync with systemctl clipboard
vim.opt.termguicolors = true -- 真彩色
vim.opt.spelllang = { "en_us", "cjk", "en" } -- 设置拼写检查的语言
vim.opt.spell = true -- 拼写检查
vim.opt.spelloptions = "camel" -- 设置驼峰检查
-- vim.opt.formatoptions = vim.opt.formatoptions - "{j}"
