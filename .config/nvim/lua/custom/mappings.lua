local M = {}

M.lsp_config = {
  n = {
    ["<leader><space>rn"] = { vim.lsp.buf.rename, opts = {} },
    ["<leader><space>wa"] = { vim.lsp.buf.add_workspace_folder, opts = {} },
    ["<leader><space>wr"] = { vim.lsp.buf.remove_workspace_folder, opts = {} },
    ["<leader><space>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      opts = {},
    },
    ["<leader><space>d"] = { vim.lsp.buf.type_definition, opts = {} },
    ["<leader><space>ca"] = { vim.lsp.buf.code_action, opts = {} },
    ["<leader><space>f"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      opts = {},
    },
  },
}

return M
