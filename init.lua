-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd.colorscheme("ron") -- 在nvim中使用<leader>uC 来预览已有的主题；在这里修改主题

-- AutoCorrect
vim.cmd([[
iab tset test
iab fucniton function
iab funciton function
iab pirnt print
iab pritn print
iab cofnig config
iab scirpt script
iab whcih which
]])
