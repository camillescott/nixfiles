filetype plugin indent on    " required

" Make the leader comma
let mapleader=","

set nocompatible
set ttyfast
set lazyredraw

set showmatch

" Im a bad vimmer, gimme mouse
set mouse+=a
" set ttymouse=sgr

" Makes backspace work in insert mode on osx
set backspace=indent,eol,start

" turn on syntax highlighting
if has("syntax")
    syntax on
endif

set nowrap
set number

" NerdTree mapping
map <F2> :NERDTreeToggle<CR>

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

"
" Status Line Stuff
"
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%{StatusDiagnostic()}
set statusline+=[%{strlen(&ft)?&ft:'none'}]  " filetype
set statusline+=%=                           " right align
set statusline+=%{fugitive#statusline()}
set laststatus=2

let g:rainbow_active = 1

" vim-markdown options
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1

" vim headers
let g:header_auto_add_header = 0
let g:header_field_author = 'Camille Scott'
let g:header_field_author_email = 'camille.scott.w@gmail.com'
let g:header_field_copyright = '(c) Camille Scott, 2021'
let g:header_field_modified_by = 0
let g:header_field_modified_timestamp = 0
let g:header_field_license_id = 'MIT'

let orgfoldexpr=&foldexpr

" fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" filetype stuff
autocmd FileType markdown setlocal spell|setlocal textwidth=100
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set expandtab|set linebreak|set wrap

augroup rmd_ft
    au!
    autocmd BufNewFile,BufRead *.Rmd set syntax=markdown|set linebreak|set wrap|set spell
augroup END

au BufRead,BufNewFile *.rst setlocal textwidth=100
autocmd FileType rst setlocal spell
au BufRead,BufNewFile *.tex setlocal textwidth=100
autocmd FileType tex setlocal spell
au BufRead,BufNewFile *.texw setlocal textwidth=100
autocmd FileType Pweave setlocal spell

augroup snakefile_ft
  au!
  autocmd BufNewFile,BufRead *.snakefile set syntax=snakemake|set tabstop=4|set shiftwidth=4|set expandtab|set
augroup END

