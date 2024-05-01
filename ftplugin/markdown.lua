-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- Markdown-specific surround mappings
vim.b.surround_98 = "**\r**" -- Character 'b' is 98 in ASCII

-- Vim-markdown settings
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_toc_autofit = 1

-- Conceal and line break settings
vim.opt.conceallevel = 2
vim.opt.linebreak = true

-- Function to open TOC when opening markdown files
local function toc()
  if vim.bo.filetype == 'markdown' then
    local prev_winnr = vim.fn.winnr()
    vim.cmd('Toc')
    if vim.fn.winnr() ~= prev_winnr then
      vim.bo.filetype = 'qf'
      vim.wo.foldenable = false
      vim.cmd('syntax on')
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
      vim.cmd('Toc')
    end
  end
end

-- Mapping for TOC toggle
vim.keymap.set({'n','i'}, '<C-t>', toc_toggle)
