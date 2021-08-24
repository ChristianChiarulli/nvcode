-- {{{ Bootstrap
local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/lvim")

vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
vim.opt.rtp:append(home_dir .. "/.config/lvim")
vim.opt.rtp:append(home_dir .. "/.config/lvim/after")

vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site/after")

-- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp
vim.cmd [[let &packpath = &runtimepath]]
-- }}}
local utils = require "utils"
require "default-config"

local autocmds = require "core.autocmds"
require("settings").load_options()

local status_ok, error = pcall(vim.cmd, "luafile " .. USER_CONFIG_PATH)
if not status_ok then
  print("something is wrong with your " .. USER_CONFIG_PATH)
  print(error)
end
require("settings").load_commands()
autocmds.define_augroups(lvim.autocommands)

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, lvim.plugins }
vim.g.colors_name = lvim.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd("colorscheme " .. lvim.colorscheme)

utils.toggle_autoformat()
local commands = require "core.commands"
commands.load(commands.defaults)

require("lsp").config()

local null_status_ok, null_ls = pcall(require, "null-ls")
if null_status_ok then
  null_ls.config {}
  require("lspconfig")["null-ls"].setup(lvim.lsp.null_ls.setup)
end

local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
if lsp_settings_status_ok then
  lsp_settings.setup {
    config_home = utils.join_paths(LUNARVIM_CONFIG_DIR, "lsp-settings"),
  }
end

require("keymappings").setup()
