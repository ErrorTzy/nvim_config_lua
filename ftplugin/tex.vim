let g:vimtex_imaps_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0  
let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : '/home/scott/Documents/app_storage/LatexBuildfiles/',
        \ 'out_dir' : '/home/scott/Documents/app_storage/LatexBuildfiles/',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-xelatex',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}
function! AddItem()
  let [end_lnum, end_col] = searchpairpos('\\begin{', '', '\\end{', 'nW')
  if match(getline(end_lnum), '\(itemize\|enumerate\|description\)') != -1
    return "\\item "
  else
    return ""
  endif
endfunction
inoremap <expr><buffer> <CR> getline('.') =~ '\item $' 
  \ ? '<c-w><c-w>' 
  \ : (col(".") < col("$") ? '<CR>' : '<CR>'.AddItem() )
nnoremap <expr><buffer> o "o".AddItem()
nnoremap <expr><buffer> O "O".AddItem()
let g:vimtex_view_method = 'zathura'
set spell
set spelllang=en_us
set conceallevel=1
set lbr
let g:tex_conceal='abdmg'
nmap <localleader>v <plug>(vimtex-view)
nmap <localleader>c <Plug>(vimtex-compile)

lua <<EOF
  local cmp = require'cmp'
  cmp.setup({sources = cmp.config.sources({
     { name = 'nvim_lsp' },
     -- { name = 'vsnip' }, -- For vsnip users.
     -- { name = 'luasnip' }, -- For luasnip users.
     { name = 'ultisnips' }, -- For ultisnips users.
     -- { name = 'snippy' }, -- For snippy users.
   }, {
     { name = 'buffer' },
   })})

EOF
   
