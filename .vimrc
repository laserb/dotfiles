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

" disable conceal
let g:indentLine_setConceal = 0

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
" diff {{{3
Plugin 'chrisbra/vim-diff-enhanced'

" vimdiff enhanced
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif
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
" }}}2

" Linter {{{2
" ALE {{{3
" Plugin 'dense-analysis/ale'
"let g:ale_virtualtext_cursor = 1
"let g:ale_virtualtext_prefix = "ALE> "
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
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_root_markers = ['.ctrlp']
" }}}3
" surround {{{3
Plugin 'tpope/vim-surround'
" }}}3
" vifm {{{3
Plugin 'vifm/neovim-vifm'
" }}}3
" }}}2

" Other {{{2
" cheat.sh {{{3
Plugin 'dbeniamine/cheat.sh-vim'
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
" }}}2
" }}}1

" COC {{{1
Plugin 'neoclide/coc.nvim'
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-diagnostic',
            \ 'coc-json',
            \ 'coc-git',
            \ 'coc-jedi',
            \ 'coc-yaml',
            \ 'coc-sh'
            \ ]
inoremap <silent><expr> <c-space> coc#refresh()
" }}}1

"{{{1 Terminal
tnoremap <Esc><Esc> <C-\><C-n>
"}}}

syntax on
filetype plugin indent on
