setlocal makeprg=xelatex\ -interaction=nonstopmode\ -file-line-error\ %
map <F10> :silent !xdg-open %:r.pdf &<CR> :redraw!<CR>
set autochdir
