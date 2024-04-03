return {
  "navarasu/onedark.nvim",
  lazy = false,
  config = function()
    require("onedark").setup({
      style = "deep",
      term_color = true,
    })
    require("onedark").load()
  end,
}
