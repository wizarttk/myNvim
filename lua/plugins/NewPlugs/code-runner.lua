--[[
mapping:
<F5>rr         RunCode       -- 运行代码
<F5>rf        RunFile        -- 在新标签页运行代码
<F5>rp        RunProject     -- 运行当前项目（只有当你在一个项目当中的时候）
<F5>rc        RunClose       -- 关闭运行代码的窗口或终端
<F5>crf       CRFiletype     -- 使用支持的文件打开 json（仅当您配置了 json 文件时使用）
<F5>crp       CRProjects     -- 打开带有项目列表的 json（仅当您配置了 json 文件时使用）
--]]

return {
  "CRAG666/code_runner.nvim",
  opts = {
    mode = "toggleterm",

    filetype = {
      java = {
        "cd $dir &&",
        "javac $fileName &&",
        "java $fileNameWithoutExt"
      },
      python = "python3 -u",
      --TODO:
      -- go = "go run", -- 自己加上的
      typescript = "deno run",
      rust = {
        "cd $dir &&",
        "rustc $fileName &&",
        "$dir/$fileNameWithoutExt"
      },
      c = function(...)
        c_base = {
          "cd $dir &&",
          "gcc $fileName -o",
          "/tmp/$fileNameWithoutExt",
        }
        local c_exec = {
          "&& /tmp/$fileNameWithoutExt &&",
          "rm /tmp/$fileNameWithoutExt",
        }
        vim.ui.input({ prompt = "Add more args:" }, function(input)
          c_base[4] = input
          vim.print(vim.tbl_extend("force", c_base, c_exec))
          require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
        end)
      end,
    },
  },


  config = function(_, opts)
    require("code_runner").setup(opts)
  end

}
