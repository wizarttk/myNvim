-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       gopls = {
--         settings = {
--           gopls = {
--             completions = {
--               completeUnimported = true, -- 设置为 true 或 false
--               usePlaceholders = true,    -- 禁用参数提示
--             }
--           }
--         }
--       }
--     }
--   }
-- }
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}

      -- 配置 gopls
      opts.servers.gopls = {
        settings = {
          gopls = {
            completions = {
              completeUnimported = true, -- 设置为 true 或 false
              usePlaceholders = false,   -- 禁用参数提示
            },
          },
        },
      }

      return opts
    end,
  },
}
