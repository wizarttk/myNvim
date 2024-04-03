return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({

      -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
      -- 覆盖颜色
      on_colors = function(colors)
        colors.bg = "#0d1117" -- 背景颜色
        colors.bg_float = "#0d1117" -- 浮动窗口颜色
        colors.bg_dark = "#0d1117" -- 黑色背景色
        colors.bg_sidebar = "#11171f" -- 侧边栏颜色
        colors.comment = "#a3a2a2" -- 注释颜色
        -- colors.fg_gutter = "#92b8cf"  # 行号区域的前景色
      end,
      -- 覆盖高亮组
      on_highlights = function(hl, colors)
        -- 行号颜色
        hl.LineNr = {
          fg = colors.purple,
        }
        -- 光标行行号颜色
        hl.CursorLineNr = {
          fg = colors.white,
        }
      end,
    })
  end,
}
