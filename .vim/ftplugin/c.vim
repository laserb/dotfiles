" prevent loading c staff for c++
if (&filetype != 'c')
    finish
endif

let b:autoformat = 1
set formatprg=clang-format\ -style\=\"{
    \BasedOnStyle:\ LLVM,
    \IndentWidth:\ 8,
    \UseTab:\ Always,
    \BreakBeforeBraces:\ Linux,
    \AllowShortIfStatementsOnASingleLine:\ false,
    \IndentCaseLabels:\ false
    \}\"
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
