return {
  "catppuccin/nvim", -- catppuccin.nvim 插件的 GitHub 仓库地址
  lazy = false, -- 立即加载插件

  name = "catppuccin", -- 插件名称

  config = require("catppuccin").setup({ -- 插件配置
    flavour = "macchiato", -- 使用 macchiato 主题风格

    background = { -- 设置背景颜色
      light = "latte",
      dark = "macchiato",
    },

    transparent_background = true, -- 启用透明背景

    show_end_of_buffer = true, -- 显示缓冲区末尾的 '~' 字符

    term_colors = true, -- 设置终端颜色

    dim_inactive = { -- 设置非活动窗口的背景变暗
      enabled = true,
      shade = "light",
      percentage = 0.25,
    },

    no_italic = false, -- 启用斜体
    no_bold = false, -- 启用粗体
    no_underline = true, -- 禁用下划线

    styles = { -- 语法高亮样式配置
      comments = { "italic" }, -- 注释使用斜体
      conditionals = { "bold" }, -- 条件语句使用粗体
      loops = { "bold" }, -- 循环语句使用粗体
      functions = { "italic", "bold" }, -- 函数使用斜体和粗体
      keywords = { "italic" }, -- 关键词使用斜体
      strings = {}, -- 保留字符串的默认样式
      variables = { "italic" }, -- 变量使用斜体
      numbers = {}, -- 保留数字的默认样式
      booleans = { "bold" }, -- 布尔值使用粗体
      properties = {}, -- 保留属性的默认样式
      types = { "italic", "bold" }, -- 类型使用斜体和粗体
      operators = {}, -- 保留运算符的默认样式
    },

    color_overrides = {
      mocha = {
        rosewater = "#F5E0DC",
        flamingo = "#F2CDCD",
        mauve = "#DDB6F2",
      },
    }, -- 覆盖部分颜色

    custom_highlights = {
      -- 自定义高亮规则
      NvimTreeIndentMarker = { fg = "#ABE9B3" }, -- 设置文件树缩进标记的颜色
    },

    integrations = { -- 插件整合配置
      cmp = true, -- 启用与代码补全插件的整合
      gitsigns = true, -- 启用与 Git 签名插件的整合
      nvimtree = true, -- 启用与文件树插件的整合
      treesitter = true, -- 启用与语法树插件的整合
      notify = true, -- 启用与通知插件的整合
      mini = { -- mini 插件配置
        enabled = true,
        indentscope_color = "#ABE9B3", -- 设置缩进范围高亮的颜色
      },
    },
  }),
}
