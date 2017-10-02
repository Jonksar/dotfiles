set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Color scheme
Plugin 'altercation/vim-colors-solarized.git'

" Syntax
Plugin 'vim-scripts/JSON.vim', {'autoload': {'filetypes': ['json']}}
Plugin 'kchmck/vim-coffee-script', {'autoload': {'filetypes': ['coffee']}}
Plugin 'vim-scripts/po.vim--gray', {'autoload': {'filetypes': ['po']}}
Plugin 'vim-scripts/plist.vim', {'autoload': {'filetypes': ['plist']}}
Plugin 'hunner/vim-plist', {'autoload': {'filetypes': ['plist']}}
Plugin 'joedicastro/vim-markdown', {'autoload': {'filetypes': ['markdown']}}
Plugin 'sophacles/vim-bundle-mako', {'autoload': {'filetypes': ['mako']}}
Plugin 'elzr/vim-json', {'autoload': {'filetypes': ['json']}}
Plugin 'scrooloose/syntastic'

" Python
Plugin 'Shougo/neocomplete.vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'Yggdroot/indentLine', {'autoload': {'filetypes': ['python', 'cpp']}}
Plugin 'alfredodeza/coveragepy.vim', {'autoload': {'filetypes': ['python']}}

" Text edition
Plugin 'delimitMate.vim'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Valloric/YouCompleteMe'

" GUI
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" NERDTree
Plugin 'https://github.com/scrooloose/nerdtree.git'

call vundle#end()            " required
filetype plugin indent on    " required

" VIM Setup {{{ ===============================================================

let mapleader = ","
let maplocalleader=' '

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible

" Leader-based shortcuts {{{
" Source: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Copy & paste to system clipboard with <Space>p and <Space>y
"

:command! -nargs=* Silent execute ':silent !'.<args> | execute ':redraw!'
noremap <Leader>q :qa<cr>
noremap <Leader>w :w <cr>
noremap <Leader>e :wqa!<cr>
noremap <C-n> :NERDTreeToggle<cr>
noremap <leader>n :NERDTreeToggle<cr>
noremap <Leader>b :w <bar> !make -C $(sed 's.src.build.g' <<< $(pwd)) --no-print-directory -j4<cr>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Enter visual line mode
nmap <Leader><Leader> V
"}}}

" Leader-based shortcuts {{{
" Source: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Copy & paste to system clipboard with <Space>p and <Space>y
"

"noremap j jzz
"noremap k kzz
"noremap G Gzz

"}}}
" Copy & paste {{{
if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif
" Enable "bracketed paste mode". See: https://stackoverflow.com/a/7053522/31493
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif
"}}}


" GUI {{{
set mouse=a
set mousehide
set wrap
set cursorline
set ttyfast
set title
set showcmd
set hidden
set ruler
set lazyredraw
set autoread
set ttimeoutlen=0
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"}}}
"
" Numbers

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


" Editing {{{
set smarttab
set smartindent
set gdefault
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set backspace=indent,eol,start
set autoindent                 " set on the auto-indent
set foldmethod=indent          " automatically fold by indent level
set nofoldenable               " ... but have folds open by default"
set virtualedit=all
set colorcolumn=200
" highlight tabs and trailing spaces
" source: https://wincent.com/blog/making-vim-highlight-suspicious-characters
set listchars=nbsp:¬,eol:¶,tab:→\ ,extends:»,precedes:«,trail:•
" Leave Ex Mode, For Good
" source: http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <nop>
" }}}


" Searching {{{
set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
set smartcase                   " smart case ignore
set ignorecase                  " ignore case letters
" }}}


" History and permanent undo levels {{{
set history=1000
set undofile
set undoreload=1000
" }}}


" Colorscheme {{{

syntax enable                  " enable the syntax highlight
set background=dark            " set a dark background
let g:solarized_termtrans = 1
colorscheme desert
" }}}


" Font
set guifont=Source\ Code\ Pro:h11


" Make a dir if no exists {{{
function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction
" }}}


" Backups {{{
set backup
set noswapfile
set backupdir=$HOME/.vim/tmp/backup/
set undodir=$HOME/.vim/tmp/undo/
set directory=$HOME/.vim/tmp/swap/
set viminfo+=n$HOME/.vim/tmp/viminfo
" Make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)
" }}}


" Autoload configuration when this file changes ($MYVIMRC)
autocmd! BufWritePost vimrc source %


" Delete trailing whitespaces
autocmd BufWritePre,FileWritePost * :%s/\s\+$//e
" Replace all non-breakable spaces by simple spaces
" Source: http://nathan.vertile.com/find-and-replace-non-breaking-spaces-in-vim/
autocmd BufWritePre,FileWritePost * silent! :%s/\%xa0/ /g
" Remove Byte Order Mark at the beginning
autocmd BufWritePre,FileWritePost * setlocal nobomb


" Execution permissions by default to shebang (#!) files
augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post = '+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END


" Airline
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" indentLine
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239


" Syntastic
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '⚡'
let g:syntastic_style_warning_symbol = '⚡'


" Git gutter
let g:gitgutter_max_signs = 10000


" FILETYPES  {{{ ==============================================================

" JSON
autocmd BufNewFile,BufRead *.json set ft=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=79 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" Plist
au BufRead,BufNewFile *.plist set filetype=plist
autocmd FileType plist NeoBundleSource vim-plist
autocmd FileType plist NeoBundleSource plist.vim

" Git commit
autocmd Filetype gitcommit setlocal spell textwidth=72

" END FILETYPES }}}
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Window title
set titlestring=%t%(\ [%R%M]%)

set backspace=indent,eol,start

map <leader>f :YcmCompleter FixIt<CR>
map <leader>g :YcmCompleter GoTo<CR>

nnoremap <leader>u :nohlsearch<CR>v/\u<CR>

map     <F12>   :nohlsearch<CR>
imap    <F12>   <ESC>:nohlsearch<CR>i
vmap    <F12>   <ESC>:nohlsearch<CR>gv


 if &diff
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none

    " get from REMOTE
    map <F5> :diffg RE<CR>
    " get from BASE
    map <F6> :diffg BA<CR>
    " get from LOCAL
    map <F7> :diffg LO<CR>

endif

" Move between windows
map <C-Up> :wincmd k<CR>
map <C-Down> :wincmd j<CR>
map <C-Left> :wincmd h<CR>
map <C-Right> :wincmd l<CR>

" changes every search value by last insert command
nnoremap <C-c> :%s//<C-r>./eg<CR>


nnoremap <C-j> 10j
nnoremap <C-k> 10k



" NERDTREE

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Remap arrowkeys to do something useful
" http://codingfearlessly.com/vim-putting-arrows-to-use

nmap <Left> <<
nmap <Right> >>
nmap <Down> ddp
nmap <Up> dd2kp

vmap <Left> <gv
vmap <Right> >gv

" remaps // under visual mode to search under selection
vnoremap // y/<C-R>"<CR>

" Automatically generates header files
autocmd bufnewfile *.c so /home/koala/.vim/templates/c_template.txt
autocmd bufnewfile *.c exe "1,7g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.c exe "1,7g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.c execute "normal ma"
autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.c execute "normal `a"

autocmd bufnewfile *.cpp so /home/koala/.vim/templates/c_template.txt
autocmd bufnewfile *.cpp exe "1,7g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.cpp exe "1,7g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.cpp execute "normal ma"
autocmd Bufwritepre,filewritepre *.cpp exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.cpp execute "normal `a"

autocmd bufnewfile *.hpp so /home/koala/.vim/templates/c_template.txt
autocmd bufnewfile *.hpp exe "1,7g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.hpp exe "1,7g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.hpp execute "normal ma"
autocmd Bufwritepre,filewritepre *.hpp exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.hpp execute "normal `a"

autocmd bufnewfile *.py so /home/koala/.vim/templates/py_template.txt
autocmd bufnewfile *.py exe "1,7g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.py exe "1,7g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.py execute "normal ma"
autocmd Bufwritepre,filewritepre *.py exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.py execute "normal `a"


" END VIM SETUP }}}
" vim:foldmethod=marker
"
