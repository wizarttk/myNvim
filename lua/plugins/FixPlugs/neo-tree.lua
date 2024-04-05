return {
  "nvim-neo-tree/neo-tree.nvim",
  -- config = require("neo-tree").setup({
  opts = {
    window = {
      mappings = { -- 映射 opts.window.mappings
        ["o"] = "open", -- 使用 o 打开文件或目录
        ["."] = "toggle_hidden", -- 使用 . 切换是否显示隐藏文件

        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      },
    },

    commands = {
      -- over write default 'delete' command to 'trash'.
      delete = function(state)
        local inputs = require("neo-tree.ui.inputs")
        local path = state.tree:get_node().path
        local msg = "Are you sure you want to trash " .. path
        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end

          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
          require("neo-tree.sources.manager").refresh(state.name)
        end)
      end,

      -- over write default 'delete_visual' command to 'trash' x n.
      delete_visual = function(state, selected_nodes)
        local inputs = require("neo-tree.ui.inputs")

        -- get table items count
        function GetTableLen(tbl)
          local len = 0
          for n in pairs(tbl) do
            len = len + 1
          end
          return len
        end

        local count = GetTableLen(selected_nodes)
        local msg = "Are you sure you want to trash " .. count .. " files ?"
        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end
          for _, node in ipairs(selected_nodes) do
            vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
          end
          require("neo-tree.sources.manager").refresh(state.name)
        end)
      end,
    },
  },
}

-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   sconfig = require("neo-tree").setup({
--     function()
--       local window = {
--         mappings = {
--           ["o"] = "open",
--         },
--       }
--     end,
--   }),
-- }

-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     window = {
--       mappings = {
--         ["o"] = "open",
--       },
--     },
--   },
-- }
