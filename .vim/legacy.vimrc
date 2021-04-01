" arduino {{{3
Plugin 'sudar/vim-arduino-syntax'
" }}}3
" fsharp {{{3
Plugin 'fsharp/vim-fsharp'
" }}}3
" javascript {{{3
Plugin 'pangloss/vim-javascript'
" }}}3
" julia {{{3
Plugin 'JuliaEditorSupport/julia-vim'
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
"{{{3
Plugin 'dart-lang/dart-vim-plugin'
"}}}3
" bitbake {{{3
Plugin 'kergoth/vim-bitbake'
" }}}3
" doxygen {{{3
Plugin 'vim-scripts/DoxygenToolkit.vim'
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
" {{{3 robotframework
Plugin 'mfukar/robotframework-vim'
" }}}3
" {{{3 vue
Plugin 'posva/vim-vue'

" }}}3
" Compiling, Debuging, Executing {{{2
" clang {{{3
Plugin 'justmao945/vim-clang'

" vim-clang
let g:clang_diagsopt = 'topleft:6'
" }}}3
" gdb {{{3
"Plugin 'vim-scripts/Conque-GDB'

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
" {{{3 ctags
" Plugin 'xolox/vim-easytags'
" Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
" }}}3
" ctags {{{3
set tags=./tags,tags;$HOME
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
