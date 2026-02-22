return {
  -- Colorscheme
  {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- load before all other plugins so colors are set first
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",  -- mocha | macchiato | frappe | latte
      integrations = {
        -- these tell Catppuccin to theme your other plugins too
        nvim_tree = true,
        telescope = { enabled = true },
        treesitter = true,
        lsp_trouble = true,
        cmp = true,
        lazy = true,
        fzf = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
},
  

  -- Fuzzy finder (file search, text search, etc.)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- File tree
  -- LSP + autocompletion (language intelligence)
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } },

  -- Treesitter (better syntax highlighting)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Status line
  { "nvim-lualine/lualine.nvim" },
}
