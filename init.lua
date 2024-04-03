-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd.colorscheme("tokyonight-night") -- 在nvim中使用<leader>uC 来预览已有的主题；在这里修改主题

vim.cmd([[
iab tset test
iab fucniton function
iab funciton function
iab pirnt print
iab pritn print
iab cofnig config
iab scirpt script
iab whcih which
iab claer clear
iab celar clear
iab hte the
iab gti git
iab reuqire require
iab requrie require
iab reqire require
]])
