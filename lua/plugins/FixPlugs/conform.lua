return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "luaformatter" },
      zsh = { "beautysh" },
      bash = { "beautysh" },
      -- python     = { "pyright" },
      javascript = { "tsserver" },
      -- go         = { "gopls" }
    },
  },

  -- 不要添加config字段,不要写成注释的这种，因为这种直接覆盖，会破坏lazyvim原有的格式
  -- config = function(_, opts)
  --   require("bufferline").setup(opts)
  -- end
}
