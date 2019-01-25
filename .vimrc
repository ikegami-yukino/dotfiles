set number
set nocompatible
set ambiwidth=double
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,cp932,eucjp-ms
set directory=~/.vim/tmp
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set clipboard=unnamedplus,autoselect

colorscheme peachpuff

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

"" indent guide
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"Rainbow Parentheses Improved
let g:rainbow_active=1

set list
set listchars=tab:^\ ,trail:~

autocmd Filetype python set tabstop=4
autocmd Filetype python set shiftwidth=4
autocmd Filetype javascript set tabstop=4
autocmd Filetype javascript set shiftwidth=4

syntax on
filetype plugin indent on
autocmd FileType python map <buffer> <F8> :Isort <CR>
autocmd FileType python map <buffer> <F9> :call Yapf() <CR>
autocmd FileType python map <buffer> <F10> :call Autopep8() <CR>
autocmd FileType python map <buffer> <F11> :call Flake8() <CR>
au BufNewFile,BufRead *.hql set filetype=hive expandtab
au BufNewFile,BufRead *.q set filetype=hive expandtab
au BufNewFile,BufRead *.gyp set filetype=python expandtab

augroup Templates
  autocmd BufNewFile *.py 0r ~/.vim/template/python.py
augroup END

if has('win32')
  set rop=type:directx,renmode:5
  source $VIMRUNTIME/mswin.vim
endif
