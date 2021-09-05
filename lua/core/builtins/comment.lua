local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {},
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults)
  self.config:merge(overrides)
end

function M:configure()
  local nvim_comment = require "nvim_comment"

  nvim_comment.setup(self.config:get "config")
  if self.config:get "on_config_done" then
    self.config:get "on_config_done"(nvim_comment)
  end
end

return M
