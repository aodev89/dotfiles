return {
  {
    "kdheepak/lazygit.nvim",
    -- lazygit.nvim needs these to work properly
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- This keybind opens lazygit in a floating terminal window
      -- <leader> is typically the space bar (we'll set that below)
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
    end,
  }
}
