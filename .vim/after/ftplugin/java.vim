setlocal makeprg=javac\ -cp\ src\ -d\ bin\ %
map <F10> :!java -cp bin %:t:r<CR>
map <F11> <CR> <F9> & <F10>
