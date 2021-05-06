require('plugins')
require('lv-globals')
require('lv-utils')
require('lv-autocommands')
require('settings')
vim.cmd('luafile ~/.config/nvim/lv-settings.lua')
require('keymappings')
require('lv-galaxyline')
require('lv-comment')
require('lv-compe')
require('lv-treesitter')
require('lv-autopairs')

-- TODO is there a way to do this without vimscript
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

-- LSP
require('lsp')
require('lsp.clangd')
require('lsp.php-ls')
require('lsp.dart-ls')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.go-ls')
require('lsp.js-ts-ls')
require('lsp.python-ls')
require('lsp.rust-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.terraform-ls')
require('lsp.vim-ls')
require('lsp.graphql-ls')
require('lsp.docker-ls')
require('lsp.html-ls')
require('lsp.css-ls')
require('lsp.emmet-ls')
require('lsp.efm-general-ls')
require('lsp.latex-ls')
require('lsp.svelte-ls')
-- require('lsp.tailwindcss-ls')
require('lsp.ruby-ls')
require('lsp.kotlin-ls')
require('lsp.vue-ls')
require('lsp.angular-ls')

