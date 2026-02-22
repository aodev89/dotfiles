return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")

      -- fzf-lua is best used alongside Telescope, not as a replacement.
      -- Map it to keys that make sense for quick, frequent actions.

      -- Find files in the project (respects .gitignore via fd)
      vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files (fzf)" })

      -- Live grep — searches file *contents* across the whole project
      vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep (fzf)" })

      -- Browse open buffers
      vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers (fzf)" })

      -- Search Git commits — great for reviewing history
      vim.keymap.set("n", "<leader>fc", fzf.git_commits, { desc = "Git commits (fzf)" })
    end,
  }
}
