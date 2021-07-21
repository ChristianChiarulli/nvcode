local M = {}

local formatter_profiles = {
  rufo = {
    exe = "rufo",
    args = { "-x" },
    stdin = true,
  },
}

M.config = function()
  O.lang.ruby = {
    diagnostics = {
      virtualtext = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    filetypes = { "rb", "erb", "rakefile", "ruby" },
    formatters = {
      "rufo",
    },
    linters = { "ruby" },
    lsp = {
      path = DATA_PATH .. "/lspinstall/ruby/solargraph/solargraph",
    },
  }
end

M.format = function()
  O.formatters.filetype["ruby"] = require("lv-utils").wrap_formatters(O.lang.ruby.formatters, formatter_profiles)

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  require("lint").linters_by_ft = {
    ruby = O.lang.ruby.linters,
  }
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "sorbet" then
    require("lspconfig").sorbet.setup {}
  end

  if not require("lv-utils").check_lsp_client_active "solargraph" then
    -- If you are using rvm, make sure to change below configuration
    require("lspconfig").solargraph.setup {
      cmd = { O.lang.ruby.lsp.path, "stdio" },
      on_attach = require("lsp").common_on_attach,
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = O.lang.ruby.diagnostics.virtual_text,
          signs = O.lang.ruby.diagnostics.signs,
          underline = O.lang.ruby.diagnostics.underline,
          update_in_insert = true,
        }),
      },
      filetypes = O.lang.ruby.filetypes,
    }
  end
end

M.dap = function()
  -- gem install readapt ruby-debug-ide
  if O.plugin.dap.active then
    local dap_install = require "dap-install"
    dap_install.config("ruby_vsc_dbg", {})
  end
end

return M
