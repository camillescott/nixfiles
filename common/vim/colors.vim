"augroup vimrc
"   autocmd!
"   autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=black guibg=NONE
"   autocmd ColorScheme * highlight MatchParen cterm=bold ctermfg=yellow ctermbg=brown gui=bold guifg=red guibg=NONE
"augroup END

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"set t_Co=256
"if &term =~ '256color' | set t_ut= | endif " Disable Background Color Erase (tmux)
set termguicolors
set conceallevel=3

let g:lightline = {
      \ 'colorscheme': 'nightfox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction',
      \   'cocstatus': 'StatusDiagnostic'
      \ },
      \ }


"let g:camillionaire_transparent_background = 1
"colorscheme camillionaire
colorscheme nordfox

" nightfox/nordfox is configured in lua...
lua << EOF
local nightfox = require('nightfox')
nightfox.setup({
    fox = "nordfox",
    transparent = true,
    styles = {
        comments = "italic", -- change style of comments to be italic
        strings = "italic",
    },
})
nightfox.load()
EOF

set cursorline
set fillchars+=vert:\║
