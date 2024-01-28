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
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
