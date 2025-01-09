-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.background = "dark"               -- dark or "light"
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
iab retunr return
iab apckage package
iab packcge package
iab fucn func
iab mian() main()
iab maiN() main()
iab maiin main
iab mian main
iab strrut struct
iab funcc func
iab tyep type
iab ypte type
iab iimport import
iab imoprt imoprt
iab imprt import
iab impot import
iab iimoprt import
iab imoprt import
iab importt import
iab pacakge package
iab packageg package
iab packakge pakcage
iab packaeg package
iab pakcage package
iab pakage package
iab pakcaeg package
iab pakcege package
iab pakcaeg package
iab pakckaeg package
iab acpakge package
iab apckaeg package
iab errr err
iab reutrn return
iab reutnr return
iab reurn return
iab sting string
iab stirng string
iab ruetnr return
iab vlaue value
iab fi if
iab idnex index
iab engien engine
]])
