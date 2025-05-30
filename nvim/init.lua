-- will see how primeogen have his vim configured.
-- sadly, I only saw a clickbait.
--
-- now trying lazy vim. https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.g.mapleader = " "
vim.opt.rtp:prepend(lazypath)
vim.cmd("set smartindent")
vim.cmd("set tabstop=2")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set termguicolors")
vim.cmd("colorscheme vim")
-- vim.cmd("colorscheme default")

require("lazy").setup({
  "joom/vim-commentary"
  , "tpope/vim-surround"
, {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8'
  ,
  dependencies = { 'nvim-lua/plenary.nvim' }
}
, "neovim/nvim-lspconfig"
, "github/copilot.vim"
, 'hrsh7th/nvim-cmp'
, 'hrsh7th/cmp-nvim-lsp'
, 'saadparwaiz1/cmp_luasnip'
, {
  'L3MON4D3/LuaSnip'
  ,
  dependencies = {
    'nvim-treesitter/nvim-treesitter'
    , 'nvim-tree/nvim-web-devicons'
  }
}
})

-- setting up telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gci', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>gco', builtin.lsp_outgoing_calls, {})
vim.keymap.set('n', '<leader>gk', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>gs', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>gS', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>gK', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>gy', builtin.lsp_type_definitions, {})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setting up lspconfig
local lspconfig = require('lspconfig')
local servers = { 'pyright', 'ts_ls', 'clangd', 'nixd', 'rust_analyzer', 'gopls', 'clojure_lsp', 'lua_ls', 'jdtls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader><space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader><space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader><space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader><space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader><space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader><space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader><space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
    -- autocomplete = false
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-y>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<Esc>'] = cmp.mapping.abort(),
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(), -- to disable overlapping completion and documentations.
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' }
  },
}
