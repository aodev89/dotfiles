return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Neovim has its own file explorer (netrw) that will conflict with
      -- nvim-tree if you don't disable it first
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,  -- collapse empty folders into one line
          icons = {
            show = {
              file = true,
              folder = true,
              git = true,  -- shows git status icons next to files
            },
          },
        },
        filters = {
          dotfiles = false,  -- show hidden files like .env, .gitignore
        },
        git = {
          enable = true,     -- highlight files based on git status
        },
      })
    end,
  }
}
