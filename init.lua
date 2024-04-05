-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.background = "dark" -- dark or "light"
vim.cmd.colorscheme("tokyonight-night") -- 在nvim中使用<leader>uC 来预览已有的主题；在这里修改主题

-- 自动纠错
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
iab craete create
]])
