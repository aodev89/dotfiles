return {
  {
    "neovim/nvim-lspconfig",
    config = function()

      -- Neovim 0.11+ native LSP config API
      -- Each vim.lsp.config call replaces what lspconfig.X.setup({}) used to do

      vim.lsp.config("pyright", {})

      vim.lsp.config("ts_ls", {})  -- note: tsserver was renamed to ts_ls

      vim.lsp.config("html", {})

      vim.lsp.config("cssls", {})

      vim.lsp.config("tailwindcss", {
        filetypes = {
          "html", "css", "javascript", "javascriptreact",
          "typescript", "typescriptreact",
        },
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "classList" },
          },
        },
      })

      -- This line actually enables all the servers you configured above
      vim.lsp.enable({
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
      })

    end,
  }
}
