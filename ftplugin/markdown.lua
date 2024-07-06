-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
-- Vim-markdown settings
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_toc_autofit = 1

-- Conceal and line break settings
vim.opt.conceallevel = 2
vim.opt.linebreak = true

-- Function to open TOC when opening markdown files
local function toc()
  if vim.bo.filetype == 'markdown' then
    local prev_winnr = vim.api.nvim_get_current_win()
    vim.cmd('Toc')
    if vim.api.nvim_get_current_win() ~= prev_winnr then
      vim.bo.filetype = 'qf'
      vim.wo.foldenable = false
      vim.cmd('syntax on')
      vim.api.nvim_set_current_win(prev_winnr)
    end
  end
end

-- Autocommands for markdown files
vim.api.nvim_create_autocmd("VimEnter", {pattern = "*.md", callback = toc})
vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*.md", callback = toc})
vim.api.nvim_create_autocmd("BufWinEnter", {pattern = "*.md", callback = toc})

-- Toggling TOC function
local function toc_toggle()
  if vim.tbl_contains({"markdown", "qf"}, vim.bo.filetype) then
    if vim.fn.getloclist(0, {winid = 0}).winid ~= 0 then
      -- Location window is open
      vim.cmd('lclose')
    else
      -- Location window is closed
      toc()
    end
  end
end

-- Mapping for TOC toggle
-- vim.api.nvim_del_keymap('i','<C-t>')
vim.keymap.set('n', '<C-t>', toc_toggle)
vim.keymap.set({'n','i'}, '<C-s>', function ()
  vim.cmd("write")
  if vim.tbl_contains({"markdown", "qf"}, vim.bo.filetype) then
    if vim.fn.getloclist(0, {winid = 0}).winid ~= 0 then
      -- Location window is open
      vim.cmd('lclose')
      toc()
    end
  end
end)

local function ysiwi_and_move_crusor(current_cursor)
  current_cursor[2] = current_cursor[2] + 1
  vim.cmd('execute \"normal ysiw*\"')
  vim.api.nvim_win_set_cursor(0, current_cursor)
end

vim.keymap.set({'i','n'}, '<C-b>', function ()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  ysiwi_and_move_crusor(current_cursor)
end)

vim.keymap.set('v', '<c-b>', '<S-S>*vf*', {remap=true})

vim.keymap.set({'i','n'}, '<C-v>', function ()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd('execute \"normal ds*\"')
  current_cursor[2] = current_cursor[2] - 1
  if current_cursor[2] >= 0 then
    vim.api.nvim_win_set_cursor(0, current_cursor)
  end
end)


