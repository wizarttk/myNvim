-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins directory will be loaded automatically by lazy.nvim
-- lazy.nvim将自动加载plugins目录的每个规范文件
--
-- In your plugin files, you can:
-- * add extra plugins                                增加额外的插件
-- * disable/enabled LazyVim plugins                  开启/关闭插件
-- * override the configuration of LazyVim plugins    覆盖lazyvim的插件配置

--[[ 配置字段
      dir: 字符串,指定插件在本地存储的目录路径
      url: 字符串,指定插件的远程 Git 仓库 URL
      name: 字符串,指定插件的名称
      dev: 布尔值,如果设置为 true,则从开发分支加载插件
      lazy: 布尔值,如果设置为 true,则延迟加载插件
      enabled: 布尔值或函数,控制是否启用该插件
      cond: 函数,根据条件函数的返回值决定是否加载插件
      dependencies: 表格,指定在加载该插件之前需要先加载的依赖插件列表
      init: 函数,在插件加载前运行的初始化函数
      main: 字符串,指定插件的主文件路径
      build: 字符串或函数,指定插件构建命令
      branch: 字符串,指定要加载的插件分支
      tag: 字符串,指定要加载的插件标签
      commit: 字符串,指定要加载的插件提交哈希值
      version: 字符串,指定插件的版本约束
      pin: 布尔值,如果设置为 true,则固定插件版本,不会自动更新
      submodules: 布尔值,如果设置为 true,则递归更新插件的子模块
      event: 字符串或表格,指定触发插件加载的事件
      cmd: 字符串或表格,指定触发插件加载的命令
      ft: 字符串或表格,指定插件只对特定文件类型生效
      keys: 字符串或表格,指定触发插件加载的快捷键映射
      module: 字符串,指定加载的插件模块
      priority: 数字,设置插件的加载优先级
      optional: 布尔值,如果设置为 true,则即使插件加载失败也不会导致错误
***重点
    opts:
     (指定插件的配置选项及其值。这些选项会在插件加载时传递给插件,用于定制插件的行为。)
      可以是一个 表 ,表中包含了一些配置选项,这是最常见的用法。
      也可以是一个 函数 ,这个函数会返回一个表,表中包含配置选项。使用函数可以让配置更加动态和可复用。(见telescope.lua的config写法)

    config:
     (该选项会在插件加载完成后执行，可以在这个函数中编写一个写额外的动态配置代码,比如设置键映射、调用插件提供的api（如require("plugin_name").setup(opts)）、修改插件内部状态等)
      可以是一个 函数 ,这个函数用于执行插件或模块的具体配置逻辑。这是最常见的用法。
      也可以是一个 布尔值 ,如果为 true,则启用默认配置;如果为 false,则不启用默认配置。

--]]

-- 通过在文件开头使用 return，可以显式地指定将这个配置表格作为整个文件的返回值(返回给lazy.lua)
-- 在lua中，当一个文件被加载时，它本身就作为一个代码快被执行，这个文件的最后一行代码执行完毕后，Lua解释其回去最后一个值作为返回值
-- Lua 中一种常见的编码习惯,通过 return 显式地返回需要的值，没有 return 语句，则默认情况下，Lua 解释器会返回 nil
--
-- 在 Neovim 配置中,通常会有一个入口文件(一般是init.lua，这里是lazy.lua)负责引入和加载各个模块或配置文件。
-- 当你使用 require 语句加载一个 Lua 文件时,实际上就是执行了该文件中的所有代码,并获取该文件的返回值。
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config                          # 更改 troube 配置
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec     # opts 将与父规范合并
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble                                # 禁用 troube 插件
  { "folke/trouble.nvim",      enabled = false },

  -- add symbols-outline                            # 添加 symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true, -- 表示使用 lazy.nvim 的默认配置逻辑,即自动调用插件主模块的 setup(opts) 函数,将 opts 传递给插件。
  },

  -- override nvim-cmp and add cmp-emoji            # 覆盖 nvim-cmp 并且添加 cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts) -- opt是一个函数，提供一个钩子来修改或替换默认的配置选项。函数参数接收一个默认配置表,函数返回值将作为最终传递给插件的配置。
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files   # 更改一些telescope选项，和一个用来浏览插件文件的快捷键
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files  # 添加 keymap
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = { -- opt是一个表格，直接将这个表格作为插件的配置选项传递给插件。
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = { -- 列出插件所以来的其他插件
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add pyright to lspconfig                 # 添加pyright 到 lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig    # pyright 将自动通过 mason 安装并通过 lspconfig 加载pyright
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig   # 添加 tsserver 并使用 typescript.nvim 进行设置,而不是 lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,     # 对于 typescript,LazyVim 还包括额外的规范来正确设置 lspconfig、
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:       # treesitter、mason 和 typescript.nvim。所以你可以使用:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers       # 添加更多的 treesitter 解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  -- 由于 `vim.tbl_deep_extend` 只能合并表而不能合并列表,上面的代码
  -- 将会用新值覆盖 `ensure_installed`。
  -- 如果你想扩展默认配置,请使用下面的代码:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:    # opts 函数也可以用于更改默认选项:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults      # 或者你可以返回新的选项来覆盖所有默认值
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
        --在此处添加你自定义的 lualine 配置
      }
    end,
  },

  -- use mini.starter instead of alpha
  -- 使用 mini.starter 代替 alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  -- 添加 jsonls 和 schemastore 包，并为 json、json5、jsonc 配置treesitter
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  -- 在线面添加你想要的任何工具
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- 使用 <tab> 进行补全和代码片段 (supertab)
  -- 首先: 在 LuaSnip 中禁用默认的 <tab> 和 <s-tab> 行为
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  -- 然后：在cmp中配置 supertab
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            -- 你可以将 expand_or_jumpable() 调用替换为 expand_or_locally_jumpable()
            -- 这样你只会在代码片段区域内跳转
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
