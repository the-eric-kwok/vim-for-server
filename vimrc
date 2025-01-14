"==========================================
" ProjectLink: https://github.com/the-eric-kwok/vim-for-server
" Author:  wklken & Eric
" Version: 0.3
" Email: wklken@yeah.net erickwok404@gmail.com
" BlogPost: http://www.wklken.me
" Donation: http://www.wklken.me/pages/donation.html
" ReadMe: README.md
" Last_modify: 2019-11-21
" Desc: simple vim config for server, without any plugins.
" Install with a simple command: 
"     curl https://raw.githubusercontent.com/the-eric-kwok/vim-for-server/master/vimrc > ~/.vimrc
"==========================================

" leader
let mapleader = ','
let g:mapleader = ','

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" save
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!             " sudo save and reload
command Wq :execute ':silent w !sudo tee % > /dev/null' | :quit             " sudo save and exit

" set default shell on Windows
if has("win32") || has("win16")
    set shell=C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0\\powershell.exe
endif

" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500

set splitbelow                  " 设置分屏默认新建在下方
set splitright                  " 设置分屏默认新建在右边

set nottyfast                   " 尽可能减少带宽需求以增加流畅度
set lazyredraw                  " 尽可能减少带宽需求以增加流畅度

" show location
set cursorcolumn
set cursorline

" movement
set scrolloff=7                 " keep 3 lines when scrolling


" show
set ruler                       " show the current row and column
set number                      " show line numbers
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis


" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present


" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=indent
set foldlevel=99
let g:FoldMethod = 0
map <space>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Disable mouse
set mouse=
" Enable mouse
"set mouse=a
" Hide the mouse cursor while typing
set mousehide


" ============================ theme and status line ============================

" theme
set background=dark
colorscheme desert
hi CursorLine term=bold cterm=bold ctermbg=DarkGray guibg=Grey40
hi CursorColumn ctermbg=DarkGray cterm=bold

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar


" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,json,plist set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.plist set filetype=plist
autocmd BufRead,BufNewFile *.command set filetype=sh
autocmd BufRead,BufNewFile *.pyw set filetype=python


" Shell、Python、bat 脚本自动加上 hashbag
autocmd BufNewFile *.bat,*.sh,*.command,*.py,*.pyw exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " .bat
    if &filetype == 'dosbatch'
        call setline(1, "@echo off")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python3")
        call append(1, "\# -*- encoding: utf-8 -*-")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" ============================ key map ============================

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" 重映射粘贴键，以支持连续粘贴
vnoremap p "0p

" 分屏窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
tmap <C-j> <C-W>j
tmap <C-k> <C-W>k
tmap <C-h> <C-W>h
tmap <C-l> <C-W>l

" <Space> - Z 最大化 / 还原分屏
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <space>z :ZoomToggle<CR>

nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" kj 替换 Esc
inoremap kj <Esc>

" Quickly close the current window
nnoremap <space>q :q<CR>
" Quickly save the current file
nnoremap <space>w :w<CR>

" select all
map <space>sa ggVG"

" select block
nnoremap <space>v V`}

" select word
noremap <A-v> lbve

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" switch # *
" nnoremap # *
" nnoremap * #

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><space>/ :nohls<CR>

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

"Map ; to : and save a million keystrokes
" ex mode commands made easy 用于快速进入命令行
nnoremap ; :

" Shift+H 跳转到当前行开始位置（有内容的地方）, Shift+L 跳转到当前行结束为止（有内容的地方）
nnoremap H g^
nnoremap L g$
vnoremap H g^
vnoremap L g$

" gh 跳转到当前行首, gl 跳转到当前行尾
nnoremap gh ^
nnoremap gl $
vnoremap gh ^
vnoremap gl $

" Shift+K 向下滚动半屏, Shift+J 向上滚动半屏
nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>

" 普通模式、编辑模式 ctrl-a ctrl-e 跳转行首尾
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" ctrl-f 映射为搜索
map <C-F> /

" 进入搜索Use sane regexes"
"nnoremap / /\v
"vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" 去掉搜索高亮
noremap <silent><space>/ :nohls<CR>

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 系统剪贴板快捷键
vnoremap <space>y "+y
vnoremap <space>x "+x
nnoremap <space>p "+p
vnoremap <space>p "+p

" 调整分屏大小
nnoremap <space>- <C-w>-
tnoremap <space>- <C-w>-
nnoremap <space>= <C-w>=
tnoremap <space>= <C-w>=
