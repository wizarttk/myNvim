return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {

    filesystem = {

      commands = { -- 用来注册新功能
        -- over write default 'delete' command to 'trash'.
        delete = function(state)
          local inputs = require("neo-tree.ui.inputs")
          local path = state.tree:get_node().path
          local msg = "Are you sure you want to trash " .. path
          inputs.confirm(msg, function(confirmed)
            if not confirmed then return end

            vim.fn.system { "trash", vim.fn.fnameescape(path) }
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,

        -- over write default 'delete_visual' command to 'trash' x n.
        delete_visual = function(state, selected_nodes)
          local inputs = require("neo-tree.ui.inputs")

          -- get table items count
          function GetTableLen(tbl)
            local len = 0
            for _ in pairs(tbl) do
              len = len + 1
            end
            return len
          end

          local count = GetTableLen(selected_nodes)
          local msg = "Are you sure you want to trash " .. count .. " files ?"
          inputs.confirm(msg, function(confirmed)
            if not confirmed then return end
            for _, node in ipairs(selected_nodes) do
              vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
            end
            require("neo-tree.sources.manager").refresh(state.name)
          end)
        end,

        -- mark two files to diff them.
        diff_files = function(state)
          local node = state.tree:get_node()
          local log = require("neo-tree.log")
          state.clipboard = state.clipboard or {}
          if diff_Node and diff_Node ~= tostring(node.id) then
            local current_Diff = node.id
            require("neo-tree.utils").open_file(state, diff_Node, open)
            vim.cmd("vert diffs " .. current_Diff)
            log.info("Diffing " .. diff_Name .. " against " .. node.name)
            diff_Node = nil
            current_Diff = nil
            state.clipboard = {}
            require("neo-tree.ui.renderer").redraw(state)
          else
            local existing = state.clipboard[node.id]
            if existing and existing.action == "diff" then
              state.clipboard[node.id] = nil
              diff_Node = nil
              require("neo-tree.ui.renderer").redraw(state)
            else
              state.clipboard[node.id] = { action = "diff", node = node }
              diff_Name = state.clipboard[node.id].node.name
              diff_Node = tostring(state.clipboard[node.id].node.id)
              log.info("Diff source file " .. diff_Name)
              require("neo-tree.ui.renderer").redraw(state)
            end
          end
        end,
      },

      window = {
        mappings = { -- 映射 opts.window.mappings
          -- 删除映射
          ["c"]  = false,
          ["C"]  = false,
          ["H"]  = false,
          ["A"]  = false,
          ["w"]  = false,
          ["t"]  = false,
          ["?"]  = false,
          -- ["D"]  = false,
          ["oc"] = false,
          ["od"] = false,
          ["om"] = false,
          ["on"] = false,
          ["os"] = false,
          ["og"] = false,
          ["I"]  = false,
          ["Y"]  = false,

          -- 新增映射
          -- cc 复制文件的绝对路径: 1.选中文件 2.获取绝对路径 3.将路径输出到剪贴板中
          ["cc"] = function(state)
            local node = state.tree:get_node() -- 获取当前选中的节点对象
            local path = node:get_id()         -- 获取路径
            vim.fn.setreg("+", path)
            vim.fn.setreg("", path)
          end,

          ["o"]  = "open",              -- 使用 o 打开文件或目录

          [",c"] = "order_by_created",  -- 按照创建时间排序
          [",a"] = "order_by_name",     -- 按照名称排序
          [",m"] = "order_by_modified", -- 按照修改时间排序
          [",s"] = "order_by_size",     -- 按照大小排序

          ["D"]  = "diff_files",
          ["~"]  = "show_help",       -- 显示“帮助”
          ["."]  = "toggle_hidden",   -- 使用 . 切换是否显示隐藏文件
          ["Z"]  = "expand_all_nodes", -- 使用 zz 展开所有目录

          ["h"]  = function(state)    -- state是neo-tree内部的一个状态对象，它包含了当前文件树视图的各种状态信息
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,

          ["l"]  = function(state)
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
    }
  },

  config = function(_, opts)
    require("neo-tree").setup(opts)
  end
}
