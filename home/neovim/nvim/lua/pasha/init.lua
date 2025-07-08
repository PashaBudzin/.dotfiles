require("pasha.remap")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.cmd("set termguicolors")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "pasha.plugins" },
})

require("pasha.set")
require("pasha.neovide")

local colorscheme = require("pasha.colors.save-colors").load_theme("catppuccin")

vim.cmd.colorscheme(colorscheme)

require("pasha.colors.colors")

if #vim.v.argv < 3 then
    vim.cmd("Ex")
end
