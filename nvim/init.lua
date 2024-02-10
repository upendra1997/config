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
vim.cmd("set nu")

require("lazy").setup({
  "joom/vim-commentary"
, "tpope/vim-surround"
, {
    'nvim-telescope/telescope.nvim', tag = '0.1.5'
  , dependencies = { 'nvim-lua/plenary.nvim' }
  }
, "neovim/nvim-lspconfig"
})

-- setting up telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- setting up lspconfig
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.clangd.setup{}
lspconfig.nixd.setup{}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


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
