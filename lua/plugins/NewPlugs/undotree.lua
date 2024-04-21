-- display the history of undo
--[[
mappings
    j     = "move_next",
    k     = "move_prev",
    gj    = "move2parent",
    J     = "move_change_next",
    K     = "move_change_prev",
    <cr>  = "action_enter",
    p     = "enter_diffbuf",
    q     = "quit",
--]]

return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = {
    { "cu", "<cmd>lua require('undotree').toggle()<cr>" }, -- 使用cu切换打开undo历史
  },
}
