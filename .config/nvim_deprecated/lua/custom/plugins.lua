local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  {
    "tpope/vim-salve",
    opts = overrides.salve,
    dependencies = {
      -- format & linting
      {
        "tpope/vim-fireplace",
        opts = overrides.fireplace,
      },
    },
  },
  -- {
  --   "TimUntersberger/neogit",
  --   dependencies = {
  --     {
  --       "nvim-lua/plenary.nvim"
  --     }
  --   },
  --   config = function()
  --     local neogit = require('neogit')
  --     neogit.setup {}
  --   end,
  -- },
}

return plugins
