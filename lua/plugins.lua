return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      local lspinstall = require "core.lspinstall"
      lspinstall.setup()
    end,
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope"):config()
    end,
    disable = not lvim.builtins.telescope.active,
  },

  -- Completion & Snippets
  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("core.compe"):config()
    end,
    disable = not lvim.builtins.compe.active,
    -- wants = "vim-vsnip",
    -- requires = {
    -- {
    --   "hrsh7th/vim-vsnip",
    --   wants = "friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- {
    --   "rafamadriz/friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- },
  },
  {
    "hrsh7th/vim-vsnip",
    -- wants = "friendly-snippets",
    event = "InsertEnter",
    disable = not lvim.builtins.compe.active,
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre",
    disable = not lvim.builtins.compe.active,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = "nvim-compe",
    config = function()
      require("core.autopairs"):config()
    end,
    disable = not lvim.builtins.autopairs.active or not lvim.builtins.compe.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("core.treesitter"):config()
    end,
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("core.nvimtree"):config()
    end,
    disable = not lvim.builtins.nvimtree.active,
  },

  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("core.gitsigns"):config()
    end,
    event = "BufRead",
    disable = not lvim.builtins.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("core.which-key").config()
    end,
    -- event = "BufWinEnter",
    -- disable = not lvim.builtins.which_key.active,
  },

  -- Comments
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      require("nvim_comment"):config()
    end,
    disable = not lvim.builtins.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("core.project"):config()
    end,
    disable = not lvim.builtins.project.active,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "shadmansaleh/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("core.lualine"):config()
    end,
    disable = not lvim.builtins.lualine.active,
  },

  {
    "romgrk/barbar.nvim",
    config = function()
      require("core.bufferline"):config()
    end,
    event = "BufWinEnter",
    disable = not lvim.builtins.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("core.dap"):config()
    end,
    disable = not lvim.builtins.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not lvim.builtins.dap.active,
  },

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("core.dashboard"):config()
    end,
    disable = not lvim.builtins.dashboard.active,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal"):config()
    end,
    disable = not lvim.builtins.terminal.active,
  },
}
