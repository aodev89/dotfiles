-- Formatering med conform.nvim
-- Prettier for web, Black/isort for Python

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Formater fil / utvalg",
      },
    },
    opts = {
      formatters_by_ft = {
        -- JavaScript / TypeScript / React
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        -- Web
        html            = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        json            = { "prettier" },
        jsonc           = { "prettier" },
        markdown        = { "prettier" },
        yaml            = { "prettier" },
        -- Python
        python          = { "isort", "black" },
      },
      format_on_save = {
        timeout_ms   = 500,
        lsp_fallback = true,
      },
    },
  },
}
