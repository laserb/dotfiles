set nocompatible               " be iMproved
scriptencoding utf-8
set encoding=utf-8
"filetype on                   " required!

" use files in ~/.vim/after/ftplugin to add
" file type specific settings

set autowrite

" folding
" set nofoldenable
set foldmethod=marker

" filename completion similar to shell
set wildmenu
set wildmode=longest,list

" clipboards {{{1
" copy to clipboard
set clipboard=unnamed
set clipboard=unnamedplus
" }}}1

" split {{{1
set splitright
set splitbelow
" }}}1

" directories {{{1
" set swap(.swp), backup(~), undo(.udf) directory to temp
set backupdir=/tmp//
set directory=/tmp//
" }}}1

" keyboard mappings {{{1
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

" open new terminal at current position
nnoremap ,t :silent :!xterm &<CR>

" map make
nnoremap <F9> :silent make\|redraw!\|cc<CR>
nnoremap <F10> :silent make run\|redraw!\|cc<CR>
nnoremap <F11> :silent make all\|redraw!\|cc<CR>
" }}}1

" vundle {{{1
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

call vundle#end()
" My Bundles here:
" Install with :PluginInstall
" }}}1

" design {{{1
set number
set background=dark
" color {{{2
Plugin 'nanotech/jellybeans.vim'
color jellybeans
" }}}2
" white spaces {{{2
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}2
" highlight long lines {{{2
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(100,999),",")
highlight ColorColumn guibg=#3a3a3a ctermbg=237
" }}}2
" mark white spaces {{{2
set list!
set lcs=tab:\┆\
let g:indentLine_color_term = 237
let g:indentLine_char = '┆'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
" }}}2
" }}}1

" Plugins {{{1

" Language Support {{{2
" arduino {{{3
Plugin 'sudar/vim-arduino-syntax'
" }}}3
" fsharp {{{3
Plugin 'fsharp/vim-fsharp'
" }}}3
" javascript {{{3
Plugin 'pangloss/vim-javascript'
" }}}3
" python {{{3
Plugin 'tell-k/vim-autopep8'
Plugin 'davidhalter/jedi-vim'

" python jedi
let g:jedi#popup_on_dot = 0
" }}}3
" kotlin {{{3
Plugin 'udalov/kotlin-vim'
"}}}3
" rust {{{3
Plugin 'rust-lang/rust.vim'
"}}}3
" lua {{{3
let g:syntastic_lua_checkers = ['luac', 'luacheck']
" }}}3
    " {{{3 vue.js
        Plugin 'posva/vim-vue'
    " }}}3
" }}}2

" Style Support {{{2
" table-mode {{{3
Plugin 'dhruvasagar/vim-table-mode'
" }}}3
" i3 {{{3
Plugin 'PotatoesMaster/i3-vim-syntax'
" }}}3
" coloresque {{{3
Plugin 'spacewander/vim-coloresque'
" }}}3
" editorconfig {{{3
Plugin 'editorconfig/editorconfig-vim'
" }}}3
" bitbake {{{3
Plugin 'kergoth/vim-bitbake'
" }}}3
" diff {{{3
Plugin 'chrisbra/vim-diff-enhanced'

" vimdiff enhanced
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif
" }}}3
" doxygen {{{3
Plugin 'vim-scripts/DoxygenToolkit.vim'
" }}}3
" reStructuredText {{{3
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'matthew-brett/vim-rst-sections'
Plugin 'nvie/vim-rst-tables'

let g:riv_fold_auto_update = 0

" instant reStructured Text
let g:instant_rst_browser = 'chromium'
autocmd FileType rst nnoremap <F9> :silent InstantRst<CR>
autocmd FileType rst let g:table_mode_corner_corner='+'
autocmd FileType rst let g:table_mode_header_fillchar='='
" }}}3
" markdown {{{3
Plugin 'euclio/vim-markdown-composer'
" }}}3
" todo.txt {{{3
Plugin 'elentok/todo.vim'
Plugin 'freitass/todo.txt-vim'

" todo.txt
let g:todo_root = "~/ownCloud/Android/Todo"
" }}}3
" vimwiki {{{3
Plugin 'laserb/vimwiki'

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
" }}}3
" latex {{{3
" do not conceal in latex
let g:tex_conceal=""
" }}}3
" }}}2

" Compiling, Debuging, Executing {{{2
" clang {{{3
Plugin 'justmao945/vim-clang'

" vim-clang
let g:clang_diagsopt = 'topleft:6'
" }}}3
" gdb {{{3
Plugin 'vim-scripts/Conque-GDB'

" conque-gdb
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly
nnoremap <silent> <Leader>Y :ConqueGdbCommand y<CR>
nnoremap <silent> <Leader>N :ConqueGdbCommand n<CR>
nnoremap <silent> <Leader>k :ConqueGdbCommand k<CR>
" }}}3
" slime {{{3
Plugin 'jpalardy/vim-slime'

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1
" let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
" }}}3
" }}}2

" Linter {{{2
" shellcheck {{{3
let g:syntastic_sh_shellcheck_args = "-x"
" }}}3
" Syntastic {{{3
Plugin 'scrooloose/syntastic'

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

let g:syntastic_kotlin_kotlinc_classpath = "bin:build/libs/*:lib:.:lib/*:*:/usr/share/java/*:build/classes/kotlin/main"

let g:syntastic_java_javac_classpath = "bin:build/libs/*:lib:.:lib/*:*:/usr/share/java/*"
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_pylint_post_args="--max-line-length=100"
" }}}3
" LanguageTool {{{3
Plugin 'vim-scripts/LanguageTool'
" }}}3
" }}}2

" Editor {{{2
" airline {{{3
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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
" }}}3
" ctrlp {{{3
Plugin 'ctrlpvim/ctrlp.vim'

" CtrlP settings
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_root_markers = ['.ctrlp']
" }}}3
" ultisnips {{{3
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" UltiSnips
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}3
" surround {{{3
Plugin 'tpope/vim-surround'
" }}}3
" vifm {{{3
Plugin 'vifm/neovim-vifm'
" }}}3
" {{{3 ctags
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
" }}}3
" }}}2

" Other {{{2
" cpsm {{{3
Plugin 'nixprime/cpsm'
" }}}3
" vim-scripts {{{3
Plugin 'https://fedorapeople.org/cgit/wwoods/public_git/vim-scripts.git'
" }}}3
" unimpaired {{{3
Plugin 'tpope/vim-unimpaired'
" }}}3
" indentLine {{{3
Plugin 'Yggdroot/indentLine'
" }}}3
" fugitive {{{3
Plugin 'tpope/vim-fugitive'
" }}}3
" repeat {{{3
Plugin 'tpope/vim-repeat'
" }}}3
" ctags {{{3
set tags=./tags,tags;$HOME
" }}}3
" {{{3 fetch
Plugin 'kopischke/vim-fetch'
" }}}3
" }}}2

" Scripts {{{2
" Preserve {{{3
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
" }}}3
" remove trailing whitespaces {{{3
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
" }}}3
" hexit {{{3
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
" }}}3
" large files {{{3
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
" }}}3
" }}}2
" }}}1

"{{{1 Terminal
tnoremap <Esc><Esc> <C-\><C-n>
"}}}
syntax on
filetype plugin indent on
