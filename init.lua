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
vim.keymap.set({'n','i'},"<C-s>",function ()
  vim.cmd("write")
end)
vim.keymap.set("i","<C-_>","<Esc>gcc<CR>i", {remap = true})
vim.keymap.set("n","<C-_>","gcc", {remap = true})
vim.keymap.set("x","<C-_>","gc", {remap = true})
-- vim.keymap.set("i","<C-c>","<C-x><C-o>", {remap = true})
vim.keymap.set("n",",",function ()
  vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 1)
end)
vim.keymap.set("n",".",function ()
  vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 1)
end)
vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-a>", "gg0vG$")
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set('i', "<C-z>", function ()
  vim.cmd("execute \"normal zg\"")
end)



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

-- for testing only
-- vim.keymap.set('i','<c-v>', function ()
--   local current_cursor = vim.api.nvim_win_get_cursor(0)
--   local current_line = vim.api.nvim_get_current_line()
--   local current_char = string.sub(current_line,current_cursor[2],current_cursor[2])
--   vim.api.nvim_err_writeln(current_char)
-- end)

