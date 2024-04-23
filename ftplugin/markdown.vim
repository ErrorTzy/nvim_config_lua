set spell
set spelllang=en_us
let b:surround_{char2nr('b')} = "**\r**"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
set conceallevel=2
set lbr

function! s:Toc()
  if &filetype == 'markdown'
    let prev_winnr = winnr()
    :Toc
    if winnr() != prev_winnr
      set filetype=qf
      setl nofoldenable
      syntax on
    endif
  endif
endfunction
autocmd VimEnter *.m*  call s:Toc()
autocmd BufReadPost *.m* call s:Toc()
autocmd BufWinEnter *.m* call s:Toc()

function s:TocToggle()
    if index(["markdown", "qf"], &filetype) == -1
        return
    endif

    if get(getloclist(0, {'winid':0}), 'winid', 0)
        " the location window is open
        lclose
    else
        " the location window is closed
        Toc
    endif
endfunction

command TocToggle call s:TocToggle()

nnoremap <C-t> :TocToggle<CR><C-w>w
xmap <Leader>b Sb
xmap <Leader>t S*
