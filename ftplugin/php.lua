O.formatters.filetype["php"] = {
  function()
    return {
      exe = "phpcbf",
      --  TODO: append to this for args don't overwrite
      args = { "--standard=PSR12", vim.api.nvim_buf_get_name(0) },
      stdin = false,
    }
  end,
}
require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

if require("lv-utils").check_lsp_client_active "intelephense" then
  return
end

require("lspconfig").intelephense.setup {
  cmd = { DATA_PATH .. "/lspinstall/php/node_modules/.bin/intelephense", "--stdio" },
  on_attach = require("lsp").common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = O.lang.php.diagnostics.virtual_text,
      signs = O.lang.php.diagnostics.signs,
      underline = O.lang.php.diagnostics.underline,
      update_in_insert = true,
    }),
  },
  filetypes = O.lang.php.filetypes,
  settings = {
    intelephense = {
      format = {
        braces = O.lang.php.format.braces,
      },
      environment = {
        phpVersion = O.lang.php.environment.php_version,
      },
    },
  },
}
