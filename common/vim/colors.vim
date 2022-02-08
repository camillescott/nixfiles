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

set t_Co=256
if &term =~ '256color' | set t_ut= | endif " Disable Background Color Erase (tmux)

let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction',
      \   'cocstatus': 'StatusDiagnostic'
      \ },
      \ }


let g:camillionaire_transparent_background = 1
colorscheme camillionaire

set cursorline

