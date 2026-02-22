-- Bootstrap lazy.nvim (auto-installs it if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options (good defaults for web/python dev)
vim.opt.number = true          -- line numbers
vim.opt.relativenumber = true  -- relative line numbers (great for navigation)
vim.opt.tabstop = 2            -- 2-space tabs (standard for JS/TS/HTML)
vim.opt.shiftwidth = 2
vim.opt.expandtab = true       -- use spaces instead of tab characters
vim.opt.termguicolors = true   -- enables full color support
vim.g.mapleader = " "
-- Load plugins
require("lazy").setup("plugins")
-- Load keymaps
require("keymaps")
