augroup vimrc
   autocmd!
   autocmd ColorScheme * highlight Normal ctermbg=NONE guifg=black guibg=NONE
   autocmd ColorScheme * highlight MatchParen cterm=bold ctermfg=yellow ctermbg=brown gui=bold guifg=red guibg=NONE
augroup END

set t_Co=256
if &term =~ '256color' | set t_ut= | endif " Disable Background Color Erase (tmux)

colorscheme miramare
hi NonText ctermfg=NONE
hi NonText ctermbg=NONE
hi EndOfBuffer ctermfg=NONE
hi EndOfBuffer ctermbg=NONE
hi CursorLine cterm=NONE ctermbg=233
hi StatusLine ctermbg=235
hi StatusLineNC ctermbg=234
set cursorline

