--[[
参考：https://www.reddit.com/r/neovim/comments/15ptmcq/change_the_mapping_of_s_in_flashnvim_in_it_to/
      https://github.com/folke/flash.nvim
      使用 :h flash 打开help文档
--]]

-- 配置文件思路： 使用<leader>l 1. 找到要配置的插件 -- 回车，cd到第一条目录中，打开lua目录的主配置文件(一般是config.lua  2. 根据主模块(M)的结构，可以改写opts

return {
  "folke/flash.nvim",
  -- stylua: ignore start
  keys = {
    -- 修改映射
    { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },            -- Flash跳转
    { "s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, -- 块选择
  },
  -- stylua: ignore end

  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
      },
    },
  },

  --config函数是多余的，因为当提供opts时，LazyVim会自动调用setup
  -- config = function(_, opts)
  --   require("flash").setup(opts)
  -- end
}
