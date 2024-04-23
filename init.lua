-- vim settings
vim.opt.title = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.g.python3_host_prog = '~/.config/nvim/venv/bin/python'

-- in-built keybinding
vim.keymap.set("n","j","gj")
vim.keymap.set("n","k","gk")
vim.keymap.set("v","j","gj")
vim.keymap.set("v","k","gk")
vim.keymap.set("n","<C-s>",":w<CR>")
vim.keymap.set("i","<C-s>","<Esc>:w<CR>a")
vim.keymap.set("v","<C-c>","\"+y")
vim.keymap.set("n","<C-a>","gg0vG$")
vim.keymap.set("i","<C-l>","<c-g>u<Esc>[s1z=`]a<c-g>u")



-- lazy.vim initialization

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup("plugins")

-- set color scheme
vim.cmd.colorscheme "catppuccin"

vim.g.vim_markdown_math = 1
vim.g.markdown_fenced_languages = {'html', 'python', 'bash=sh'}
