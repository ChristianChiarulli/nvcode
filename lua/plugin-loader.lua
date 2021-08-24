local plugin_loader = {}

function plugin_loader:init()
  local execute = vim.api.nvim_command
  local fn = vim.fn
  local utils = require "utils"

  local install_path = utils.join_paths(LUNARVIM_RUNTIME_DIR, "site", "pack", "packer", "start", "packer.nvim")
  if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
  end

  local packer_ok, packer = pcall(require, "packer")
  if not packer_ok then
    return
  end

  packer.init {
    package_root = utils.join_paths(LUNARVIM_RUNTIME_DIR, "site", "pack"),
    compile_path = utils.join_paths(LUNARVIM_CONFIG_DIR, "plugin", "packer_compiled.lua"),
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  self.packer = packer
  return self
end

function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end
  end)
end

return {
  init = function()
    return plugin_loader:init()
  end,
}
