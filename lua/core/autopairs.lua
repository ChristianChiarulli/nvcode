local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {
      map_complete = vim.bo.filetype ~= "tex",
      check_ts = true,
      ts_config = {
        java = false,
      },
    },
  },
}

function M:setup(config)
  config:extend_with(self.defaults)
end

function M:config()
  -- skip it, if you use another global object
  _G.MUtils = {}
  local autopairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  vim.g.completion_confirm_key = ""
  MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()["selected"] ~= -1 then
        return vim.fn["compe#confirm"](autopairs.esc "<cr>")
      else
        return autopairs.esc "<cr>"
      end
    else
      return autopairs.autopairs_cr()
    end
  end

  if package.loaded["compe"] then
    require("nvim-autopairs.completion.compe").setup {
      map_cr = lvim.builtins.autopairs.config.map_cr,
      map_complete = lvim.builtins.autopairs.config.map_complete,
    }
  end

  autopairs.setup {
    check_ts = lvim.builtins.autopairs.config.check_ts,
    ts_config = lvim.builtins.autopairs.config.ts_config,
  }

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- TODO: can these rules be safely added from "config.lua" ?
  -- press % => %% is only inside comment or string
  autopairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }

  if lvim.builtins.autopairs.on_config_done then
    lvim.builtins.autopairs.on_config_done(autopairs)
  end
end

return M
