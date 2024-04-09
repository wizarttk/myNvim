PLUGIN SPEC                                  *lazy.nvim-lazy.nvim-plugin-spec*

  ------------------------------------------------------------------------------------------------------------------------------------
  Property       Type                                                             Description
  -------------- ---------------------------------------------------------------- ----------------------------------------------------
  [1]            string?                                                          Short plugin url. Will be expanded using
                                                                                  config.git.url_format

  dir            string?                                                          A directory pointing to a local plugin

  url            string?                                                          A custom git url where the plugin is hosted

  name           string?                                                          A custom name for the plugin used for the local
                                                                                  plugin directory and as the display name

  dev            boolean?                                                         When true, a local plugin directory will be used
                                                                                  instead. See config.dev

  lazy           boolean?                                                         When true, the plugin will only be loaded when
                                                                                  needed. Lazy-loaded plugins are automatically loaded
                                                                                  when their Lua modules are required, or when one of
                                                                                  the lazy-loading handlers triggers

  enabled        boolean? or fun():boolean                                        When false, or if the function returns false, then
                                                                                  this plugin will not be included in the spec

  cond           boolean? or fun(LazyPlugin):boolean                              When false, or if the function returns false, then
                                                                                  this plugin will not be loaded. Useful to disable
                                                                                  some plugins in vscode, or firenvim for example.

  dependencies   LazySpec[]                                                       A list of plugin names or plugin specs that should
                                                                                  be loaded when the plugin loads. Dependencies are
                                                                                  always lazy-loaded unless specified otherwise. When
                                                                                  specifying a name, make sure the plugin spec has
                                                                                  been defined somewhere else.

  init           fun(LazyPlugin)                                                  init functions are always executed during startup

  opts           table or fun(LazyPlugin, opts:table)                             opts should be a table (will be merged with parent
                                                                                  specs), return a table (replaces parent specs) or
                                                                                  should change a table. The table will be passed to
                                                                                  the Plugin.config() function. Setting this value
                                                                                  will imply Plugin.config()

  config         fun(LazyPlugin, opts:table) or true                              config is executed when the plugin loads. The
                                                                                  default implementation will automatically run
                                                                                  require(MAIN).setup(opts). Lazy uses several
                                                                                  heuristics to determine the plugin’s MAIN module
                                                                                  automatically based on the plugin’s name. See also
                                                                                  opts. To use the default implementation without opts
                                                                                  set config to true.

  main           string?                                                          You can specify the main module to use for config()
                                                                                  and opts(), in case it can not be determined
                                                                                  automatically. See config()

  build          fun(LazyPlugin) or string or a list of build commands            build is executed when a plugin is installed or
                                                                                  updated. Before running build, a plugin is first
                                                                                  loaded. If it’s a string it will be ran as a shell
                                                                                  command. When prefixed with : it is a Neovim
                                                                                  command. You can also specify a list to executed
                                                                                  multiple build commands. Some plugins provide their
                                                                                  own build.lua which is automatically used by lazy.
                                                                                  So no need to specify a build step for those
                                                                                  plugins.

  branch         string?                                                          Branch of the repository

  tag            string?                                                          Tag of the repository

  commit         string?                                                          Commit of the repository

  version        string? or false to override the default                         Version to use from the repository. Full Semver
                                                                                  ranges are supported

  pin            boolean?                                                         When true, this plugin will not be included in
                                                                                  updates

  submodules     boolean?                                                         When false, git submodules will not be fetched.
                                                                                  Defaults to true

  event          string? or string[] or                                           Lazy-load on event. Events can be specified as
                 fun(self:LazyPlugin, event:string[]):string[] or                 BufEnter or with a pattern like BufEnter *.lua
                 {event:string[]\|string, pattern?:string[]\|string}              

  cmd            string? or string[] or                                           Lazy-load on command
                 fun(self:LazyPlugin, cmd:string[]):string[]                      

  ft             string? or string[] or                                           Lazy-load on filetype
                 fun(self:LazyPlugin, ft:string[]):string[]                       

  keys           string? or string[] or LazyKeysSpec[] or                         Lazy-load on key mapping
                 fun(self:LazyPlugin, keys:string[]):(string \| LazyKeysSpec)[]   

  module         false?                                                           Do not automatically load this Lua module when it’s
                                                                                  required somewhere

  priority       number?                                                          Only useful for start plugins (lazy=false) to force
                                                                                  loading certain plugins first. Default priority is
                                                                                  50. It’s recommended to set this to a high number
                                                                                  for colorschemes.

  optional       boolean?                                                         When a spec is tagged optional, it will only be
                                                                                  included in the final spec, when the same plugin has
                                                                                  been specified at least once somewhere else without
                                                                                  optional. This is mainly useful for Neovim distros,
                                                                                  to allow setting options on plugins that may/may not
                                                                                  be part of the user’s plugins
  ------------------------------------------------------------------------------------------------------------------------------------
来源：  /home/david/.local/share/nvim/lazy/lazy.nvim/doc/lazy.nvim.txt 
配置文件思路： 使用<leader>l 1. 找到要配置的插件 -- 回车，cd到第一条目录中，打开lua目录的主配置文件(一般是config.lua  2. 根据主模块的结构，可以改写opts

-------
写插件配置的时候：
opts = {} 等价于
config = function()
  require('plugin_name').setup({})

end

opt 是一个表格,用于直接传递插件的配置选项。
config 是一个函数,它在插件加载后执行,可以用来进一步配置插件或执行其他操作。(可以额外加入其他函数)
-------

在 LazyVim 中, 插件的选项是通过插件自身提供的设置方式来获取和配置的。每个插件都有自己的配置方式,常见的做法包括:

1. **查看插件文档**

大多数插件都会在自己的文档中列出可配置的选项及其含义,以及如何进行配置。比如通过 `:help zen-mode.nvim` 可以查看 `zen-mode.nvim` 插件的文档。

2. **检查插件源码**

如果文档不够清晰,可以直接查看插件的源码,通常插件的设置选项会放在一个名为 `setup()` 或 `config()` 之类的函数中。例如 `zen-mode.nvim` 的设置就在 `setup()` 函数中。

3. **使用 Lua 语言调试**

在 Neovim 中使用 `luafile` 命令或 Lua 解释器来加载并调试插件,查看它接受何种选项。

4. **参考其他人的配置**

在网上搜索别人分享的插件配置,通常可以找到一些例子。

5. **使用插件提供的设置界面**（如果有的话）**

有些插件提供了交互式的设置界面,通过命令或快捷键即可调出并配置选项。

一旦找到插件接受的选项,就可以在 LazyVim 的插件配置表中使用 `opt` 字段或 `config` 函数来设置这些选项了。总的来说,熟悉插件及其文档是获取配置方式的关键。


