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
autocmd BufWritePre * :%s/\s\+$//e

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

" do not conceal in latex
let g:tex_conceal=""

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>h
nnoremap <c-h> <c-w>l

" copy paste mappings
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

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
nnoremap <F8> :cnext<CR>
nnoremap <F7> :cprevious<CR>

" CtrlP settings
let g:ctrlp_by_filename = 1

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
