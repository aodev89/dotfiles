-- LSP Configuration
-- Støtter: JavaScript, TypeScript, React, TailwindCSS, Python, CSS, HTML

return {
  -- Mason: automatisk installasjon av LSP-servere
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP-servere
        "typescript-language-server",
        "pyright",
        "css-lsp",
        "html-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        -- Linters
        "eslint_d",
        "flake8",
        -- Formatters
        "prettier",
        "black",
        "isort",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Mason <-> lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",           -- TypeScript / JavaScript
        "pyright",         -- Python
        "cssls",           -- CSS
        "html",            -- HTML
        "tailwindcss",     -- TailwindCSS
        "emmet_ls",        -- Emmet (HTML/JSX snippets)
      },
      automatic_installation = true,
    },
  },

  -- Kjerne LSP-konfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps som aktiveres når en LSP kobler til
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local map = vim.keymap.set

          map("n", "gd",         vim.lsp.buf.definition,       vim.tbl_extend("force", opts, { desc = "Gå til definisjon" }))
          map("n", "gD",         vim.lsp.buf.declaration,      vim.tbl_extend("force", opts, { desc = "Gå til deklarasjon" }))
          map("n", "gr",         vim.lsp.buf.references,       vim.tbl_extend("force", opts, { desc = "Vis referanser" }))
          map("n", "gi",         vim.lsp.buf.implementation,   vim.tbl_extend("force", opts, { desc = "Gå til implementasjon" }))
          map("n", "K",          vim.lsp.buf.hover,            vim.tbl_extend("force", opts, { desc = "Hover dokumentasjon" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action,      vim.tbl_extend("force", opts, { desc = "Code actions" }))
          map("n", "<leader>rn", vim.lsp.buf.rename,           vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          map("n", "<leader>D",  vim.lsp.buf.type_definition,  vim.tbl_extend("force", opts, { desc = "Type definisjon" }))
          map("n", "<leader>ds", vim.lsp.buf.document_symbol,  vim.tbl_extend("force", opts, { desc = "Dokument symboler" }))
          map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symboler" }))
          map("n", "[d",         vim.diagnostic.goto_prev,     vim.tbl_extend("force", opts, { desc = "Forrige diagnostikk" }))
          map("n", "]d",         vim.diagnostic.goto_next,     vim.tbl_extend("force", opts, { desc = "Neste diagnostikk" }))
          map("n", "<leader>e",  vim.diagnostic.open_float,    vim.tbl_extend("force", opts, { desc = "Åpne diagnostikk float" }))
          map("n", "<leader>q",  vim.diagnostic.setloclist,    vim.tbl_extend("force", opts, { desc = "Diagnostikk liste" }))
        end,
      })

      -- Diagnostikk-ikoner
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
        },
      })

      -- ─── TypeScript / JavaScript ───────────────────────────────────────────
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "javascript.jsx", "typescript.tsx",
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      -- ─── Python ───────────────────────────────────────────────────────────
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- ─── CSS ──────────────────────────────────────────────────────────────
      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css  = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
      })

      -- ─── HTML ─────────────────────────────────────────────────────────────
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "htmldjango", "handlebars" },
      })

      -- ─── TailwindCSS ──────────────────────────────────────────────────────
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
        },
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "classList", "ngClass" },
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cn\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              },
            },
          },
        },
      })

      -- ─── Emmet (HTML/JSX snippets) ────────────────────────────────────────
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "html", "css", "scss",
          "javascriptreact", "typescriptreact",
        },
        init_options = {
          html = { options = { ["bem.enabled"] = true } },
        },
      })
    end,
  },
}
