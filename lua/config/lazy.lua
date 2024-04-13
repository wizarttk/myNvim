local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- 获取neovim插件在当前系统下的安装路径，并赋值给lazypath
if not vim.loop.fs_stat(lazypath) then                       -- vim.loop.sf_stat检查文件或路径的状态，如果返回flase/nil，则路径不存在，执行then后面的
  -- bootstrap lazy.nvim
  vim.fn.system({                                            -- 用于执行系统命令，克隆lazy.nvim插件的稳定分支到本地指定路径lazypath下
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath) -- 将 Lazy.nvim 插件的路径添加到 Neovim 的运行时路径 (runtime path, rtp) 的开头 -- :冒号用来调用表中的方法（使用元表添加的方法）

require("lazy").setup({
  -- spec 表指定要安装和加载的插件
  spec = {
    -- import 是一个特殊的键,用于告诉 lazy.nvim 插件管理器从哪里导入你自定义的插件配置(路径是相对路径)。
    { "LazyVim/LazyVim",          import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },

    -- import 和 require 不会递归加载目录下面子目录中的模块
    { import = "plugins.Schemes" },  -- 主题新增和修改
    { import = "plugins.FixPlugs" }, -- 修改已有插件
    { import = "plugins.NewPlugs" }, -- 新增插件
  },
  defaults = {
    -- defaults 表设置了一些默认选项。
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } }, -- install 表指定了要安装的插件
  checker = { enabled = true },                            -- automatically check for plugin updates  -- checker 表启用了插件更新检查器,它会自动检查插件是否有新的更新版本。
  performance = {                                          -- performance 表用于优化 Neovim 的性能。在这里,它禁用了一些不需要的内置 Neovim 插件,以提高启动速度和减少内存使用。
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
