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
      "#0066ff", -- 霓虹蓝（Neon Blue）
      "#2dffe6", -- 霓虹青（Neon Aqua）
      "#da00ff", -- 霓虹紫（Neon Purple）
    }

    -- 生成彩虹色的 highlight groups
    vim.schedule(function()
      for i, color in ipairs(rainbow_colors) do
        vim.api.nvim_set_hl(0, "RainbowIndent" .. i, { fg = color })
      end
    end)

    -- 存储原始键位映射
    local original_mappings = {}
    local keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" }

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

      zen = {

        show = {
          statusline = false, -- can only be shown when using the global statusline
          tabline = true,
        },

        --在zen模式下禁用指定keys的映射，防止误触退出zen模式

        on_open = function(win) -- on_open：窗口打开时的回调函数
          -- 保存所有方向键的原始映射
          for _, key in ipairs(keys) do
            original_mappings[key] = vim.fn.maparg(key, "n")
            -- 在zen模式下禁用映射
            vim.keymap.set("n", key, "<NOP>", { buffer = true })
          end
        end,

        on_close = function(win) -- on_open：窗口关闭时的回调函数
          -- 恢复所有方向键的原始映射
          for _, key in ipairs(keys) do
            if original_mappings[key] ~= "" then
              -- 如果有原始映射，恢复它
              vim.keymap.set("n", key, original_mappings[key], { buffer = true })
            else
              -- 如果没有原始映射，删除当前的映射
              vim.keymap.del("n", key, { buffer = true })
            end
          end
          -- 清空存储的映射
          original_mappings = {}
        end,

      },

      styles = {
        zen = {
          enter = true,
          fixbuf = false,
          minimal = false,
          width = 120,
          height = 0,
          backdrop = { transparent = true, blend = 40 },
          keys = {
            q = false,
          },
          zindex = 40,
          wo = {
            winhighlight = "NormalFloat:Normal",
          },
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
