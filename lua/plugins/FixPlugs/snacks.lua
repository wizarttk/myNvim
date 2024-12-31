-- local colors = require("tokyonight.colors").setup()
--
-- -- 从 tokyonight 提取彩虹色系
-- local rainbow_colors = {
--   colors.red,
--   colors.yellow,
--   colors.green,
--   colors.blue,
--   colors.magenta,
--   colors.cyan,
--   colors.purple
-- }

return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local rainbow_colors = {
      "#ff375f", -- 霓虹红（Neon Red）
      "#ff763b", -- 霓虹橙（Neon Orange）
      "#ffea00", -- 霓虹黄（Neon Yellow）
      "#39ff14", -- 霓虹绿（Neon Green）
      "#0abdc6", -- 霓虹蓝（Neon Blue）
      "#2dffe6", -- 霓虹青（Neon Aqua）
      "#da00ff", -- 霓虹紫（Neon Purple）
    }

    -- 生成彩虹色的 highlight groups
    vim.schedule(function()
      for i, color in ipairs(rainbow_colors) do
        vim.api.nvim_set_hl(0, "RainbowIndent" .. i, { fg = color })
      end
    end)

    -- 返回合并后的配置
    --[[
    vim.tbl_deep_extend 的作用：
      1. 保留插件的默认配置（在 opts 中）
      2. 同时用你的自定义配置覆盖需要修改的部分
      3. 确保深层配置项也被正确合并，而不是完全替换
    如果不用这个函数直接返回配置，就会完全覆盖插件的默认配置，可能会丢失一些我们没有明确设置但又需要的选项。
    --]]
    return vim.tbl_deep_extend("force", opts, {
      scroll = {
        enabled = false,
      },

      terminal = {
        win = {
          border = "rounded",
          position = "float",
        },
      },

      indent = {
        chunk = {
          enabled = true,
          hl = {
            "RainbowIndent1",
            "RainbowIndent2",
            "RainbowIndent3",
            "RainbowIndent4",
            "RainbowIndent5",
            "RainbowIndent6",
            "RainbowIndent7",
          },
        },
      },
    })
  end,

  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
