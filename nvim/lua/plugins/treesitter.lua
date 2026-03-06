-- Treesitter: syntaksutheving og bedre kodeforståelse

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",  -- Auto-lukk HTML/JSX-tagger
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "jsdoc",
          "typescript", "tsx",
          "python",
          "html", "css",
          "json", "jsonc",
          "yaml", "toml",
          "markdown", "markdown_inline",
          "lua", "vim", "vimdoc",
          "bash",
          "regex",
        },
        auto_install    = true,
        highlight       = { enable = true },
        indent          = { enable = true },
        autotag         = { enable = true },   -- nvim-ts-autotag

        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      })
    end,
  },
}
