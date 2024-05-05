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


local add_astroid_and_move_crusor = function (current_cursor)
  vim.api.nvim_put({"**"}, 'c', true, true)
  current_cursor[2] = current_cursor[2] + 1
  vim.api.nvim_win_set_cursor(0, current_cursor)
end

local ysiwi_and_move_crusor = function (current_cursor)
  vim.cmd('execute \"normal ysiw*\"')
  current_cursor[2] = current_cursor[2] + 1
  vim.api.nvim_win_set_cursor(0, current_cursor)
end


local toggle_markdown = function ()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = vim.api.nvim_get_current_line()

  if current_line == '' then
    -- if the line is empty, add ** and return immediately

    add_astroid_and_move_crusor(current_cursor)
    return
  end


  local current_line_length = string.len(current_line)
  local left_string = string.sub(current_line,1,current_cursor[2]) -- in insert mode, this will be the string before the cursor
  local right_string = nil -- in inser mode, this will be the string next to the cursor

  if current_line_length > current_cursor[2] then
    right_string = string.sub(current_line, current_cursor[2] + 1, current_line_length)
    -- now we have both left and right
    -- now the cursor is:
    -- 1. left %w and right %w
    --   this is the easiest case. I only need to check if there is an enviornment that includes the word.
    --   Notice that **aaa** aa|a **aaa** should not consider aaa to be inside an enviornment.
    --   If it is inside an enviornment, toggle the enviornment to *, **, ***
    --   If it is not inside an enviornment, use ysiwi_and_move_crusor()
    -- 2. left %w and right *
    --   In this case the right * is clearly an end of enviornment
    --   It cannot be the start of an enviornment 
    --   I will need to check how many * are there.
    --   If there are more than 2, then do ds* two times
    --   If there are 2 or less, ysiwi_and_move_crusor()
    -- 3. left %w and right 
    -- . left * and right %w
    --   In this case the left * is clearly a start of enviornment.
    --   It cannot be the end of an enviornment
    --   Still, check how many * and do the toggle.
    --
  else
    -- If there is not right part:
    -- If it is an * on the left, then you need to check the whole style word.
    -- If it is a non-word but not *, add ** immediately and return.
    -- If it is a word, then find the first non-word and add a pair of *. This  

    local current_char = string.sub(current_line, current_cursor[2], current_cursor[2])
    if current_char == '*' then
      -- check whole and add *

      return
    elseif not string.match(current_char, '%w') then
      -- a non-word
      add_astroid_and_move_crusor(current_cursor)
      return
    else
      -- a word, then we add a pair of * around this word
      ysiwi_and_move_crusor(current_cursor)
      return
    end
    -- check whole
  end

  -- Now both left and right has content. We first find if there is any 
  local left_primary_stop = nil
  local left_nonword_stop = nil
  local right_primary_stop = nil
  local right_nonword_stop = nil

  while not left_primary_stop do
    -- the left string goes backwards. Therefore its index goes from its length to 1
    for i = string.len(left_string), 10, 1 do
    end
  end
  vim.api.nvim_err_writeln("L:" .. left_string)
  vim.api.nvim_err_writeln("R:" .. right_string)



  -- cases:
  -- apple|. --> **apple**. current: e next: .
  -- apple |. --> apple **. current: _ next: .
  -- apple. | --> apple. ** current: _ next: 
  -- *apple|* --> **apple** current: e next: *
  -- *|apple* --> **apple** current: * next: a
  --
  -- If the current is a word or *, then add a pair of ** AROUND it
  -- If the current is a non-word that is not *, then PUT **
  --
  -- if current_line == '' or -- Case A: the line is empty
  --   not string.match(current_char,'%w') or -- current char is a non-word
  --   string.len(current_line) == current_cursor[2] or -- is the end of line
  --   not string.match(
  --     string.sub(current_line,current_cursor[2] + 1,current_cursor[2] + 1),
  --     '%w') -- the next char is a non-word
  --   then
  --   vim.api.nvim_put({"**"}, 'c', true, true)
  -- else
  --   vim.cmd('execute \"normal ysiw*\"')
  -- end
  -- current_cursor[2] = current_cursor[2] + 1
  -- vim.api.nvim_win_set_cursor(0, current_cursor)

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


