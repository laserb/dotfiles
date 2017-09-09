set nocompatible               " be iMproved
scriptencoding utf-8
set encoding=utf-8
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
Plugin 'nixprime/cpsm'
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
Plugin 'laserb/vimwiki'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'laserb/vim-instant-markdown'
Plugin 'laserb/instant-markdown-d'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tell-k/vim-autopep8'

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

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" remove trailing whitespaces
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    call Preserve(':%s/\s\+$//e')
endfun

" Re-format the whole buffer.
function! Format()
    " Only strip if the b:autoformat is 1
    if exists('b:autoformat') && b:autoformat == 1
        call Preserve('normal gggqG')
    endif
endfunction

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd BufWritePre * call Format()

" copy to clipboard
set clipboard=unnamed
set clipboard=unnamedplus

" split
set splitright
set splitbelow

" set swap(.swp), backup(~), undo(.udf) directory to temp
set backupdir=/tmp//
set directory=/tmp//

" vimdiff enhanced
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif

" ctags
set tags=./tags,tags;$HOME

set number
color jellybeans
set background=dark

" nerdtree
" open if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if only nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-n> :NERDTreeToggle<CR>

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
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_pylint_post_args="--max-line-length=100"

" mark white spaces
set list lcs=tab:\┆\
let g:indentLine_color_term = 236
let g:indentLine_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" instant markdown
let g:instant_markdown_autostart = 0
let g:instant_markdown_port = 8890
autocmd FileType markdown nnoremap <F9> :silent InstantMarkdownPreview<CR>
let g:instant_markdown_browser = 'electron'

" vimwiki
let g:vimwiki_list = [{
            \ 'path': '~/vimwiki/',
            \ 'auto_export': 1,
            \ 'auto_toc': 1,
            \ 'section_class': 'link-target',
            \ }]
let g:vimwiki_header_mode = 1
nmap <Leader>wv <Plug>VimwikiVSplitLink
nmap <Leader>wh <Plug>VimwikiSplitLink
nmap <Leader>wb <Plug>VimwikiGoBackLink
nmap <Leader>k <Plug>VimwikiDiaryPrevDay
nmap <Leader>j <Plug>VimwikiDiaryNextDay
nmap <Leader>wc <Plug>Vimwiki2HTML
nmap <Leader>wu :call VimwikiToggleUrlVisibility()<CR>
function! VimwikiToggleUrlVisibility()
    if g:vimwiki_url_maxsave
        let g:vimwiki_url_maxsave = 0
    else
        let g:vimwiki_url_maxsave = 15
    endif
    edit
endfunction

function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^dir:'
        let link = link[6:]
    else
        return 0
    endif
    try
        exe 'silent !i3-sensible-terminal -e vifm '.link.' &'
        return 1
    catch
        echo "Start vifm failed"
        return 0
    endtry
endfunction

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1
" let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" conque-gdb
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

" open new terminal at current position
nnoremap ,t :silent :!xterm &<CR>

" map make
nnoremap <F9> :silent make\|redraw!\|cc<CR>
nnoremap <F10> :silent make run\|redraw!\|cc<CR>
nnoremap <F11> :silent make all\|redraw!\|cc<CR>

" CtrlP settings
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_root_markers = ['.ctrlp']

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
let g:airline#extensions#branch#enabled = 0

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
