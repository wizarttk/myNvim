local sdd --修改未使用变量的颜色
return {
  "folke/tokyonight.nvim",
  opts = {

    -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
    -- 覆盖颜色
    -- 前景色fg  是指文字/线条的颜色
    -- 背景色bg  是指背景颜色
    on_colors = function(c)
      c.bg = "#0d1117"         -- 背景颜色
      c.bg_float = "#0d1117"   -- 浮动窗口颜色
      c.bg_dark = "#0d1117"    -- 黑色背景色
      c.bg_sidebar = "#11171f" -- 侧边栏颜色
      c.comment = "#a3a2a2"    -- 注释颜色
    end,

    -- 覆盖高亮组
    on_highlights = function(hl, c) -- highlight, colors
      -- 行号颜色
      hl.LineNr = {
        fg = c.purple,
      }
      -- 光标行行号颜色
      hl.CursorLineNr = {
        fg = c.white,
      }

      -- 无边Telescope -------------------------
      local prompt = "#2d3149"
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = prompt,
      }
      hl.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      ---------------------------------------
    end,
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)
  end,


}
