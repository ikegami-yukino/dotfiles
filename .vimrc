set number
set nocompatible
set ambiwidth=double
set encoding=utf8
set fileencoding=utf8
set directory=~/.vim/tmp
set backupdir=~/.vim/backup
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set clipboard=unnamedplus
colorscheme peachpuff

"" indent guide
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

set list
set listchars=tab:^\ ,trail:~

autocmd Filetype python set tabstop=4
autocmd Filetype python set shiftwidth=4

syntax on
filetype plugin indent on
autocmd FileType python map <buffer> <F10> :call Autopep8() <CR>
autocmd FileType python map <buffer> <F11> :call Flake8() <CR>
au BufNewFile,BufRead *.hql set filetype=hive expandtab
au BufNewFile,BufRead *.q set filetype=hive expandtab
