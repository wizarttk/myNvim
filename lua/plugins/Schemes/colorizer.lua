-- 该插件可以对Neovim中的颜色代码进行高亮
return {
  VeryLazy = true,
  "norcalli/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      RGB      = true,         -- #RGB hex codes
      RRGGBB   = true,         -- #RRGGBB hex codes
      names    = true,         -- "Name" codes like Blue
      RRGGBBAA = false,        -- #RRGGBBAA hex codes
      rgb_fn   = false,        -- CSS rgb() and rgba() functions
      hsl_fn   = false,        -- CSS hsl() and hsla() functions
      css      = false,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn   = false,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      mode     = 'background', -- Set the display mode.
    }
  },

  keys = {
    { "<leader>ct", "<cmd>ColorizerToggle<cr>", desc = "Colorizer Toggle" },
  },

  config = function(_, opts)
    require("colorizer").setup(opts)
  end
}
