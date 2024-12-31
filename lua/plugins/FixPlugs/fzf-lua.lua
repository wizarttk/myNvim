return {
  -- 加载 fzf-lua 插件
  "ibhagwan/fzf-lua",
  -- 定义何时加载插件（懒加载）
  cmd = "FzfLua",
  -- 配置选项
  opts = function(_, opts)
    -- 导入必要的模块
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- 配置快捷键映射
    -- Quickfix 窗口的快捷键设置
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept" -- Ctrl-q: 选择所有并确认
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"      -- Ctrl-u: 向上翻半页
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"    -- Ctrl-d: 向下翻半页
    config.defaults.keymap.fzf["ctrl-x"] = "jump"              -- Ctrl-x: 跳转
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down" -- Ctrl-f: 预览窗口向下翻页
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"   -- Ctrl-b: 预览窗口向上翻页
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble 插件集成
    -- 如果安装了 trouble.nvim，添加相关快捷键
    if LazyVim.has("trouble.nvim") then
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
    end

    -- 切换根目录/当前工作目录的功能
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local o = vim.deepcopy(ctx.__call_opts)
      o.root = o.root == false
      o.cwd = nil
      o.buf = ctx.__CTX.bufnr
      LazyVim.pick.open(ctx.__INFO.cmd, o)
    end
    config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
    config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

    -- 图片预览器配置
    -- 按优先级尝试使用不同的图片预览工具
    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },                               -- 首选 ueberzug
      { cmd = "chafa",    args = { "{file}", "--format=symbols" } }, -- 其次是 chafa
      { cmd = "viu",      args = { "-b" } },                         -- 最后是 viu
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    -- 返回主要配置
    return {
      "default-title",
      fzf_colors = true,           -- 启用 fzf 颜色
      fzf_opts = {
        ["--no-scrollbar"] = true, -- 禁用滚动条
      },
      defaults = {
        -- formatter = "path.filename_first",  -- 文件名优先显示格式
        formatter = "path.dirname_first", -- 目录名优先显示格式
      },
      -- 预览器配置
      previewers = {
        builtin = {
          -- 配置支持预览的图片格式
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain", -- ueberzug 缩放模式
        },
      },
      -- vim.ui.select 的自定义配置
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          -- 代码动作窗口的特殊配置
          winopts = {
            layout = "vertical",
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          -- 普通选择窗口配置
          winopts = {
            width = 0.5,
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      -- 窗口通用配置
      winopts = {
        width = 0.8, -- 窗口宽度为屏幕的 80%
        height = 0.8, -- 窗口高度为屏幕的 80%
        row = 0.5, -- 垂直居中
        col = 0.5, -- 水平居中
        preview = {
          scrollchars = { "┃", "" }, -- 滚动条字符
        },
      },
      -- 文件搜索配置
      files = {
        cwd_prompt = false,                      -- 不显示当前工作目录提示
        actions = {
          ["alt-i"] = { actions.toggle_ignore }, -- Alt-i: 切换忽略文件
          ["alt-h"] = { actions.toggle_hidden }, -- Alt-h: 切换隐藏文件
        },
      },
      -- grep 搜索配置
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore }, -- Alt-i: 切换忽略文件
          ["alt-h"] = { actions.toggle_hidden }, -- Alt-h: 切换隐藏文件
        },
      },
      -- LSP 相关配置
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          -- 如果安装了 delta，使用原生代码动作预览
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,
  -- 插件配置函数
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- 为所有选择器使用相同的提示符
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  -- 初始化函数
  init = function()
    LazyVim.on_very_lazy(function()
      -- 配置 vim.ui.select 使用 fzf-lua
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local opts = LazyVim.opts("fzf-lua") or {}
        require("fzf-lua").register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
      end
    end)
  end,
  -- 快捷键配置
  keys = {
    -- 关闭快捷键映射（用来映射成新的）
    { "<leader>fr", false },
    { "<leader>fr", false },

    -- fzf 窗口内的快捷键
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    { "<c-o>", "<enter>", ft = "fzf", mode = "t", nowait = true }, -- 修改映射，窗口内<c-o>打开文件
    { "<c-s>", "<c-v>", ft = "fzf", mode = "t", nowait = true },   -- 修改映射，窗口内<c-s>垂直平铺打开文件

    -- 通用快捷键
    { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "切换缓冲区" },
    { "<leader>/", LazyVim.pick("live_grep"), desc = "在根目录中 Grep" }, -- 常用
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "命令历史" },
    { "<leader><space>", LazyVim.pick("files"), desc = "在根目录中查找文件" },

    -- 查找相关快捷键
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "缓冲区" },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "查找配置文件" },
    { "<leader>ff", LazyVim.pick("files"), desc = "在根目录中查找文件" },
    { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "在当前目录中查找文件" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "查找 Git 文件" },
    -- { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "最近文件" },
    -- { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "最近文件(当前目录)" },
    { "<leader>R", "<cmd>FzfLua oldfiles<cr>", desc = "最近文件" }, -- 修改
    { "<leader>r", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "最近文件（当前目录）" }, -- 修改

    -- Git 相关快捷键
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "提交记录" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git 状态" },

    -- 搜索相关快捷键
    { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "寄存器" },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "自动命令" },
    { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "在当前缓冲区中搜索" },
    { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "命令历史" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "命令" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "文档诊断" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "工作区诊断" },
    { "<leader>sg", LazyVim.pick("live_grep"), desc = "在根目录中 Grep" },
    { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "在当前目录中 Grep" },
    { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "帮助页面" },
    { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "搜索高亮组" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "跳转列表" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "键位映射" },
    { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "位置列表" },
    { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man 页面" },
    { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "跳转到标记" },
    { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "恢复上次搜索" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix 列表" },
    { "<leader>sw", LazyVim.pick("grep_cword"), desc = "搜索当前单词(根目录)" },
    { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "搜索当前单词(当前目录)" },
    { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "搜索选中文本(根目录)" },
    { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "搜索选中文本(当前目录)" },
    { "<leader>uC", LazyVim.pick("colorschemes"), desc = "预览配色方案" },

    -- LSP 符号搜索
    {
      "<leader>ss",
      function()
        require("fzf-lua").lsp_document_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = "跳转到符号",
    },
    {
      "<leader>sS",
      function()
        require("fzf-lua").lsp_live_workspace_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = "跳转到工作区符号",
    },
  },
}
