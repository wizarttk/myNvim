-- nvim-lint 是一个轻量级的 Neovim 插件，用于为各种编程语言提供静态代码分析和 lint 支持。
-- 它与其他 LSP 插件（如 nvim-lspconfig）不同，nvim-lint 专注于运行外部的 lint 工具，而不是一个完整的语言服务。
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
