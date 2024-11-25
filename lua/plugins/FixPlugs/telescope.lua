--[[
常用操作:
  双击空格    搜索目录文件(root 目录)

  <leader>r   搜索最近打开的文件 (cwd 目录)
  <leader>R   搜索最近打开的文件（root 目录)

  <leader>/   使用Grep搜索 (cwd 目录)
  <leader>?   使用Grep搜索 (root 目录)
--]]

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fr",  false },
    { "<leader>fR",  false },
    { "<leadfer>sg", false },
    { "<leadfer>sG", false },

    --搜索文件名
    { "<leader>r",   LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    { "<leader>R",   "<cmd>Telescope oldfiles<cr>",                         desc = "Recent (root Dir)" },

    -- 使用grep搜索文本所在的文件
    { "<leader>/",   LazyVim.pick("live_grep", { cwd = false }),       desc = "Grep (cwd)" },
    { "<leader>?",   LazyVim.pick("live_grep"),                        desc = "Grep (root Dir)" },
  },
  opts = function()
    -- opts如果为函数，则需要返回他的配置选项，之所以有时候是函数，是因为前面需要一些预处理，来为要返回配置做铺垫
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end
    local open_selected_with_trouble = function(...)
      return require("trouble.providers.telescope").open_selected_with_trouble(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          -- 在telescope界面的normal模式下，按 ? 查看当前的键位映射
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
            ["o"] = actions.select_default,    -- open in buffer
            ["s"] = actions.select_vertical,   -- open in vsplit
            ["S"] = actions.select_horizontal, -- open in splits
          },
        },
      },
    }
  end,

}
