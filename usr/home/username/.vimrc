let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



" UTF-8 encoding
set encoding=UTF-8



" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" PostgreSQL syntax highlighting
Plug 'lifepillar/pgsql.vim'

" TypeScript
Plug 'leafgarland/typescript-vim'

" Jinja2
Plug 'glench/vim-jinja2-syntax'

" 80 char rule
"Plug 'seletskiy/vim-over80'

" Colorizer
Plug 'lilydjwg/colorizer'

" NERDTree
Plug 'scrooloose/nerdtree'

" VIM-AIRLANE (cool status bar)
Plug 'vim-airline/vim-airline'

" Initialize plugin system
call plug#end()



" All *.sql files as pgSQL
let g:sql_type_default = 'pgsql'

" Line numbers
set number

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" NERDTree width
let g:NERDTreeWinSize=56

" Enable tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" 80 char line limit rule
set colorcolumn=80
:hi ColorColumn ctermbg=black guibg=black

" Switch between different windows by their direction
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

