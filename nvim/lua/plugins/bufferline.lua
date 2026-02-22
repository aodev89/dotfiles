return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",        -- slant | thick | thin
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          diagnostics = "nvim_lsp",         -- shows LSP error/warning counts on tabs
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,             -- draws a line between tree and tabs
            },
          },
        },
      })
    end,
  }
}
