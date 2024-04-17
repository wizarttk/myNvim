-- 配置这个自带的插件，防止在normal模式下使用[[和]](已经映射为surround del)的时候发生冲突
return {
  "RRethy/vim-illuminate",
  event = "LazyFile",
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    -- map("]]", "next")
    -- map("[[", "prev")

    -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        -- map("]]", "next", buffer)
        -- map("[[", "prev", buffer)
      end,
    })
  end,
  keys = {
    { "]]", false },
    { "[[", false },
  },
}
