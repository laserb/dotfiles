set nocompatible               " be iMproved
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
" Install with :PluginInstall
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/LanguageTool'
Plugin 'scrooloose/syntastic'
Plugin 'https://fedorapeople.org/cgit/wwoods/public_git/vim-scripts.git'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'tpope/vim-unimpaired'
Plugin 'jpalardy/vim-slime'
Plugin 'Yggdroot/indentLine'
Plugin 'fsharp/vim-fsharp'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'justmao945/vim-clang'
Plugin 'spacewander/vim-coloresque'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'kergoth/vim-bitbake'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'

call vundle#end()

syntax on
filetype plugin indent on
" use files in ~/.vim/after/ftplugin to add
" file type specific settings
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autowrite
" remove trailing whitespaces

fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1

" copy to clipboard
set clipboard=unnamed
set clipboard=unnamedplus

" set swap(.swp), backup(~), undo(.udf) directory to temp
set backupdir=/tmp//
set directory=/tmp//

" ctags
set tags=./tags,tags;$HOME

set number
color torte
set background=dark

" highlight long lines
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(100,999),",")
highlight ColorColumn guibg=#2d2d2d ctermbg=234

" do not conceal in latex
let g:tex_conceal=""

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>h
nnoremap <c-h> <c-w>l
nnoremap <c-Down> <c-w>j
nnoremap <c-Up> <c-w>k
nnoremap <c-Left> <c-w>h
nnoremap <c-Right> <c-w>l

" copy paste mappings
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" syntastic
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_java_javac_classpath = "bin:lib:.:lib/*:*:/usr/share/java/*"
let g:syntastic_python_checkers = ["pylint2"]
let g:syntastic_python_pylint_post_args="--max-line-length=100"

" mark white spaces
set list lcs=tab:\┆\
let g:indentLine_color_term = 236
let g:indentLine_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1
" let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" open new terminal at current position
nnoremap ,t :silent :!xterm &<CR>

" map make
nnoremap <F9> :silent make\|redraw!\|cc<CR>
nnoremap <F10> :silent make run\|redraw!\|cc<CR>
nnoremap <F11> :silent make all\|redraw!\|cc<CR>

" CtrlP settings
let g:ctrlp_by_filename = 1

" vim airline
set laststatus=2
set ttimeoutlen=50
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" UltiSnips
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" The following maps the F8 key to toggle between hex and binary (while also
" setting the
" " noeol and binary flags, so if you :write your file, vim doesn't perform
" unwanted conversions.
noremap <F4> :call HexIt()<CR>
let $in_hex=0
function! HexIt()
    set binary
    set noeol
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunction


" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif
