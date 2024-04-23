-- return {
--   "mfussenegger/nvim-lint",
--   config = function()
--     require("lint").setup({
--       linters_by_ft = {
--         zsh = { "shellcheck" },
--         bash = { "shellcheck" },
--       }
--     })
--   end
-- }


return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      bash = { "shellcheck" },
      javascript = { "oxlint" },
      -- Dockerfile = { "hadolint" },
      -- zsh = { "zsh" },
    },
  },
}
