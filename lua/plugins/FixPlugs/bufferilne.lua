-- 帮助文件在命令模式输入 :h bufferline
return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      hover = { -- 悬停
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      indicator = { -- buffer指示器
        -- icon = "| ", -- 如果indicator 的 style不是icon，这样应该被省略
        style = "underline",
      },
    },
  },
}
